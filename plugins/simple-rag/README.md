# Simple RAG Plugin

## 简介

Simple RAG Plugin 是一个Claude Code Marketplace插件，通过MCP Server为Claude提供访问知识数据库和文档库的能力。该插件集成了Weaviate向量数据库，实现智能语义搜索和信息检索。

## 功能

- ✅ 智能语义搜索
- ✅ 知识库查询
- ✅ 文档检索
- ✅ 项目文档访问
- ✅ 向量相似性搜索
- ✅ 自动触发机制

## 架构

```
┌─────────────────┐
│   Claude Code   │
└────────┬────────┘
         │
         ▼
┌──────────────────────────┐
│    Simple RAG Plugin     │
└────────┬─────────────────┘
         │
         ▼ (HTTP/StreamableHTTP)
┌──────────────────────────┐
│   MCP Server             │
│   http://localhost:8001  │
└────────┬─────────────────┘
         │
         ▼
┌──────────────────────────┐
│   Weaviate Vector DB     │
│   10.5.9.199:8181        │
└──────────────────────────┘
```

## 快速开始

### 安装

1. 插件已预装在Claude Code Marketplace中
2. 确保MCP Server在 `http://localhost:8001/mcp` 运行
3. 确保Weaviate服务运行在 `10.5.9.199:8181`

### 使用示例

```bash
# 搜索项目文档
"帮我查找关于API设计的文档"

# 查询知识库
"知识库中有关于微服务架构的信息吗？"

# 检索特定文档
"搜索包含JWT认证的文档"
```

## 配置

### MCP Server配置

插件通过以下配置连接到MCP Server：

```json
{
  "base_url": "http://localhost:8001/mcp",
  "headers": {
    "Accept": "application/json, text/event-stream",
    "Content-Type": "application/json"
  },
  "timeout": 30000,
  "retry": {
    "retries": 3,
    "factor": 2,
    "minTimeout": 1000
  }
}
```

### Weaviate配置

```yaml
Host: 10.5.9.199
Port: 8181
gRPC Port: 50051
```

## 自动触发条件

插件会在以下场景自动被调用：

1. **查询项目文档** - 当用户询问项目相关文档时
2. **搜索知识库** - 当用户需要查找特定信息时
3. **文档检索** - 当用户明确要求搜索文档时
4. **技术咨询** - 当需要查找技术资料或最佳实践时
5. **学习资源** - 当用户请求推荐学习资料时

## 目录结构

```
simple-rag/
├── .claude-plugin/
│   └── plugin.json              # 插件配置文件
├── skills/
│   ├── SKILL.md                 # 技能详细说明
│   └── references/              # 参考文档目录
└── README.md                    # 本文档
```

## API参考

### 输入格式

```json
{
  "query": "搜索查询内容",
  "filters": {
    "document_type": "optional_filter",
    "category": "optional_category"
  },
  "limit": 10
}
```

### 输出格式

```json
{
  "results": [
    {
      "id": "document_id",
      "title": "文档标题",
      "content": "文档内容摘要",
      "score": 0.95,
      "metadata": {
        "source": "来源",
        "tags": ["标签1", "标签2"]
      }
    }
  ],
  "total": 42,
  "took": 123
}
```

## 故障排除

### 连接问题

- 检查MCP Server是否运行在 http://localhost:8001
- 验证Weaviate服务状态
- 确认网络连接正常

### 搜索无结果

- 尝试使用不同的关键词
- 检查文档是否已正确索引到Weaviate
- 验证查询语法是否正确

### 超时问题

- 当前超时设置为30秒
- 如果需要，可以调整timeout配置
- 检查数据库响应性能

## 开发

### 本地开发

1. 修改 `.claude-plugin/plugin.json` 更新配置
2. 更新 `skills/SKILL.md` 完善文档
3. 测试MCP Server连接

### 提交更新

```bash
git add .
git commit -m "feat: update simple-rag plugin"
git push
```

## 许可证

MIT License

## 支持

如有问题或建议，请联系：support@example.com

## 更新日志

### v0.0.1
- 初始版本发布
- 基础搜索功能
- 知识库查询支持
- 自动触发机制
