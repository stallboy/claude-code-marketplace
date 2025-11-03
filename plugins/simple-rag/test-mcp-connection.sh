#!/bin/bash

# Simple RAG Plugin - MCP Server连接测试脚本

echo "======================================"
echo "Simple RAG MCP Server 连接测试"
echo "======================================"
echo ""

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 测试初始化连接
echo "1. 测试MCP Server初始化连接..."
INIT_RESPONSE=$(curl -s -X POST http://localhost:8001/mcp \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{
    "jsonrpc": "2.0",
    "id": 1,
    "method": "initialize",
    "params": {
      "protocolVersion": "2024-11-05",
      "capabilities": {},
      "clientInfo": {
        "name": "claude-code-test",
        "version": "1.0.0"
      }
    }
  }')

if echo "$INIT_RESPONSE" | grep -q "result"; then
  echo -e "   ${GREEN}✓${NC} MCP Server连接成功"
  echo "   Server: $(echo "$INIT_RESPONSE" | grep -o '"name":"[^"]*"' | cut -d'"' -f4)"
  echo "   Version: $(echo "$INIT_RESPONSE" | grep -o '"version":"[^"]*"' | cut -d'"' -f4)"
else
  echo -e "   ${RED}✗${NC} MCP Server连接失败"
  echo "   Response: $INIT_RESPONSE"
  exit 1
fi

echo ""

# 获取工具列表
echo "2. 获取可用工具列表..."
TOOLS_RESPONSE=$(curl -s -X POST http://localhost:8001/mcp \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{
    "jsonrpc": "2.0",
    "id": 2,
    "method": "tools/list"
  }')

if echo "$TOOLS_RESPONSE" | grep -q "error"; then
  echo -e "   ${YELLOW}⚠${NC} 无法直接获取工具列表"
  echo "   错误: $(echo "$TOOLS_RESPONSE" | grep -o '"message":"[^"]*"' | cut -d'"' -f4)"
  echo ""
  echo "   尝试SSE模式..."
fi

# 使用SSE模式获取工具列表
echo ""
echo "3. 使用SSE模式测试..."
SSE_RESPONSE=$(curl -N -s -X POST http://localhost:8001/mcp \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{
    "jsonrpc": "2.0",
    "id": 1,
    "method": "initialize",
    "params": {
      "protocolVersion": "2024-11-05",
      "capabilities": {},
      "clientInfo": {
        "name": "claude-code-test",
        "version": "1.0.0"
      }
    }
  }')

if echo "$SSE_RESPONSE" | grep -q "simple"; then
  echo -e "   ${GREEN}✓${NC} SSE连接成功"
else
  echo -e "   ${YELLOW}⚠${NC} SSE连接需验证"
fi

echo ""
echo "======================================"
echo "配置验证"
echo "======================================"
echo ""

# 验证插件配置
echo "4. 验证插件配置..."
if [ -f "plugins/simple-rag/.claude-plugin/plugin.json" ]; then
  echo -e "   ${GREEN}✓${NC} plugin.json 存在"
  NAME=$(grep -o '"name": *"[^"]*"' plugins/simple-rag/.claude-plugin/plugin.json | cut -d'"' -f4)
  echo "   插件名称: $NAME"
else
  echo -e "   ${RED}✗${NC} plugin.json 不存在"
fi

echo ""

# 验证MCP配置
echo "5. 验证MCP配置..."
MCP_CONFIG="../.claude-plugin/.mcp.json"
if [ -f "$MCP_CONFIG" ]; then
  echo -e "   ${GREEN}✓${NC} .mcp.json 存在"
  MCP_SERVER=$(grep -o '"simple-rag"' "$MCP_CONFIG")
  if [ -n "$MCP_SERVER" ]; then
    echo -e "   ${GREEN}✓${NC} MCP服务器 'simple-rag' 已配置"
    MCP_URL=$(grep -o '"url": *"[^"]*"' "$MCP_CONFIG" | cut -d'"' -f4)
    echo "   MCP URL: $MCP_URL"
  else
    echo -e "   ${RED}✗${NC} MCP服务器 'simple-rag' 未配置"
  fi
else
  echo -e "   ${RED}✗${NC} .mcp.json 不存在"
fi

echo ""
echo "======================================"
echo "测试完成"
echo "======================================"
echo ""
echo "如果所有检查都通过，插件应该能够正常工作。"
echo "现在可以重启Claude Code并测试插件功能。"
echo ""
