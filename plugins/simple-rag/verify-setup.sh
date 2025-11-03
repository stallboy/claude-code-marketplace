#!/bin/bash

# Simple RAG Plugin Setup Verification Script
# 此脚本用于验证Simple RAG插件的配置是否正确

echo "====================================="
echo "Simple RAG Plugin Setup Verification"
echo "====================================="
echo ""

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查文件结构
echo "1. 检查文件结构..."
files=(
  ".claude-plugin/plugin.json"
  "skills/SKILL.md"
  "skills/references/usage_examples.md"
  "README.md"
)

all_files_exist=true
for file in "${files[@]}"; do
  if [ -f "$file" ]; then
    echo -e "   ${GREEN}✓${NC} $file"
  else
    echo -e "   ${RED}✗${NC} $file (缺失)"
    all_files_exist=false
  fi
done

echo ""

# 检查JSON语法
echo "2. 检查JSON配置语法..."
if python3 -m json.tool .claude-plugin/plugin.json > /dev/null 2>&1; then
  echo -e "   ${GREEN}✓${NC} plugin.json 语法正确"
else
  echo -e "   ${RED}✗${NC} plugin.json 语法错误"
fi

echo ""

# 检查关键配置项
echo "3. 检查关键配置..."
required_keys=(
  "schema_version"
  "name_for_model"
  "name_for_human"
  "description_for_model"
  "api.base_url"
)

for key in "${required_keys[@]}"; do
  if grep -q "\"$key\"" .claude-plugin/plugin.json; then
    echo -e "   ${GREEN}✓${NC} $key"
  else
    echo -e "   ${RED}✗${NC} $key (缺失)"
  fi
done

echo ""

# 检查MCP Server URL
echo "4. 检查MCP Server配置..."
mcp_url=$(grep -o '"base_url": "[^"]*"' .claude-plugin/plugin.json | cut -d'"' -f4)
if [ "$mcp_url" = "http://localhost:8001/mcp" ]; then
  echo -e "   ${GREEN}✓${NC} MCP Server URL: $mcp_url"
else
  echo -e "   ${YELLOW}⚠${NC} MCP Server URL: $mcp_url"
fi

echo ""

# 检查Weaviate配置
echo "5. 检查Weaviate配置..."
weaviate_host=$(grep -o '"WEAVIATE_HOST": "[^"]*"' ../../.claude-plugin/.mcp.json | cut -d'"' -f4)
weaviate_port=$(grep -o '"WEAVIATE_PORT": "[^"]*"' ../../.claude-plugin/.mcp.json | cut -d'"' -f4)
echo -e "   ${GREEN}✓${NC} Weaviate Host: ${weaviate_host:-未配置}"
echo -e "   ${GREEN}✓${NC} Weaviate Port: ${weaviate_port:-未配置}"

echo ""

# 显示配置摘要
echo "====================================="
echo "配置摘要"
echo "====================================="
echo "插件名称: Simple RAG Plugin"
echo "模型名称: simple_rag"
echo "MCP Server: http://localhost:8001/mcp"
echo "协议: StreamableHTTP"
echo ""

# 检查依赖服务状态（可选）
echo "====================================="
echo "依赖服务状态"
echo "====================================="
echo ""

# 检查MCP Server
echo -n "MCP Server (localhost:8001): "
if curl -s --connect-timeout 2 http://localhost:8001 > /dev/null 2>&1; then
  echo -e "${GREEN}运行中${NC}"
else
  echo -e "${YELLOW}未运行 (请启动: npm run dev 或类似命令)${NC}"
fi

# 检查Weaviate
echo -n "Weaviate ($weaviate_host:$weaviate_port): "
if curl -s --connect-timeout 2 "http://$weaviate_host:$weaviate_port/health" > /dev/null 2>&1; then
  echo -e "${GREEN}运行中${NC}"
else
  echo -e "${YELLOW}未运行 (请启动Weaviate)${NC}"
fi

echo ""
echo "====================================="
echo "验证完成！"
echo "====================================="
echo ""
echo "使用说明:"
echo "1. 确保MCP Server在 http://localhost:8001 运行"
echo "2. 确保Weaviate在 $weaviate_host:$weaviate_port 运行"
echo "3. 插件将自动在需要搜索文档或知识库时被调用"
echo ""
