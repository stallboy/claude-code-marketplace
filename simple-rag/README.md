# Simple-RAG Plugin

## 项目概述

Simple-RAG 是一个基于 MCP (Model Context Protocol) 的文档检索插件，集成了 Weaviate 向量数据库，提供语义搜索和关键词搜索功能。

## 目录结构

```
claude-code-marketplace/
├── .claude-plugin/
│   ├── marketplace.json          # 插件市场配置文件
│   └── .mcp.json                 # MCP 服务器配置
├── simple-rag/
│   └── query/
│       └── SKILL.md              # 技能定义文档
└── simplerag/
    └── mcp-server/               # MCP 服务器实现
        ├── src/
        │   ├── index.ts          # MCP 服务器主入口
        │   ├── weaviate-client.ts
        │   └── types.ts
        ├── dist/                 # 编译后的文件
        └── package.json
```

## 组件说明

### 1. 插件定义 (.claude-plugin/marketplace.json)
- 插件名称: `simple-rag`
- 描述: 使用MCP Server和Weaviate向量数据库进行语义和关键词搜索的文档查询技能
- 技能路径: `./simple-rag/query`

### 2. MCP 服务器配置 (.claude-plugin/.mcp.json)
- 服务器名称: `simple-rag`
- 工作目录: `/mnt/c/Users/Administrator/workspace/simplerag/mcp-server/`
- 启动命令: `npm run dev`

### 3. 技能文档 (simple-rag/query/SKILL.md)
定义了四个主要工具：
- `retrieve`: 混合搜索文档块
- `retrieve_with_filters`: 高级过滤搜索
- `list_documents`: 列出文档
- `get_chunk_count_per_project`: 获取项目块数统计

### 4. MCP 服务器 (simplerag/mcp-server/)
完整的MCP服务器实现，包括：
- 协议处理 (stdio传输)
- 工具注册和调用处理
- Weaviate客户端集成
- 向量搜索和BM25搜索结合

## 使用方法

插件加载后，可以通过以下方式使用：

### 基础搜索
```typescript
// 搜索相关文档
retrieve({
  query: "如何配置认证",
  projects: ["project-a"]
});
```

### 高级搜索
```typescript
// 带过滤条件的搜索
retrieve_with_filters({
  query: "API文档",
  projects: ["backend"],
  dayAgo: 30,
  byAuthors: ["john.doe"],
  titleNotContain: "deprecated"
});
```

### 文档列表
```typescript
// 列出文档
list_documents({
  projects: ["frontend"],
  dayAgo: 7
});
```

### 统计信息
```typescript
// 获取项目统计
get_chunk_count_per_project({});
```

## 技术栈

- **MCP SDK**: @modelcontextprotocol/sdk
- **向量数据库**: Weaviate
- **语言**: TypeScript
- **传输协议**: stdio
- **搜索方式**: 语义搜索 + 关键词搜索 (混合)

## 依赖项

MCP服务器依赖：
- @modelcontextprotocol/sdk: MCP协议实现
- weaviate-client: Weaviate客户端
- zod: 数据验证
- dotenv: 环境变量
- ws: WebSocket支持

## 启动流程

1. Claude Code加载插件配置 (.claude-plugin/marketplace.json)
2. 启动MCP服务器 (.claude-plugin/.mcp.json)
3. 工具注册到MCP服务器
4. 客户端可以调用注册的四个工具

## 配置要求

- Weaviate实例运行中
- 知识库文档已索引到Weaviate
- 正确的环境变量配置
- npm/node 环境

## 开发命令

```bash
# 在 MCP 服务器目录中
cd /mnt/c/Users/Administrator/workspace/simplerag/mcp-server/

# 开发模式 (监视文件变化)
npm run dev

# 构建 TypeScript
npm run build

# 类型检查
npm run typecheck

# 验证配置
npm run verify
```

## 注意事项

- MCP服务器使用stdio传输，确保与标准输入输出的兼容性
- 所有搜索结果以JSON格式返回
- 支持项目、作者、日期等多维度过滤
- 语义搜索和关键词搜索结果会进行合并和排序
