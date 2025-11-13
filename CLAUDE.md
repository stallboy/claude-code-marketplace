# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repository is a **Claude Code Marketplace** containing bundled plugins for Claude Code. It houses two main plugins:

1. **tech-translator** - Professional technical content translation
2. **simple-rag** - Knowledge database access through MCP Server and Weaviate

## Architecture

The repository follows a marketplace plugin architecture:

```
claude-code-marketplace/
├── .claude-plugin/              # Root marketplace configuration
│   ├── marketplace.json         # Bundle manifest (2 plugins)
│   └── .mcp.json               # Global MCP server configuration
├── plugins/
│   ├── tech-translator/        # Translation plugin
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json    # Plugin metadata
│   │   └── skills/
│   │       ├── SKILL.md       # Translation skill definition
│   │       └── references/    # Translation resources
│   └── simple-rag/             # RAG plugin
│       ├── .claude-plugin/
│       │   └── plugin.json    # Plugin metadata
│       ├── skills/
│       │   ├── SKILL.md       # Search skill definition
│       │   └── references/
│       ├── verify-setup.sh    # Setup verification script
│       └── test-mcp-connection.sh  # MCP connection test
└── README.md                   # Marketplace documentation
```

### Plugin Execution Flow

**simple-rag plugin flow:**
```
Claude Code → MCP Client → HTTP MCP Server (localhost:8001) → Weaviate Vector DB
```

**tech-translator plugin:**
```
Claude Code → Translation Skill → Direct translation (no backend required)
```

## Common Commands

### Development Tasks

```bash
# Verify simple-rag plugin setup (from plugins/simple-rag/)
./verify-setup.sh

# Test MCP Server connection (from plugins/simple-rag/)
./test-mcp-connection.sh

# Test MCP initialization and tools
curl -X POST http://localhost:8001/mcp \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05"}}'
```

### Git Workflow

```bash
# Stage all changes
git add .

# Commit plugin updates
git commit -m "feat: update plugin-name"

# Push to repository
git push
```

### Plugin Testing

1. **tech-translator**: No backend required
   - Test by sending translation requests through Claude Code

## Plugin Details

### tech-translator (plugins/tech-translator/)

**Purpose**: Professional technical document translation maintaining terminology consistency

**Key Files**:
- `skills/SKILL.md` - Comprehensive translation guidelines with 3-tier term classification
- `skills/references/technical_terms_glossary.md` - Established technical term translations
- `skills/references/translation_guidelines.md` - Detailed workflow and best practices

**Translation Categories**:
- Category A: Preserve original (HTTP, JSON, API, Python, React)
- Category B: Translate with annotation (algorithm → 算法(algorithm))
- Category C: Full translation (computer → 计算机)

**Triggered when**:
- User requests technical document translation
- API documentation needs translation
- Academic/technical papers require translation
- Software development content needs localization

### simple-rag (plugins/simple-rag/)

**Purpose**: Provide Claude with access to knowledge databases and document libraries

**Architecture**:
- **Frontend**: Claude Code plugin
- **Backend**: MCP Server (http://localhost:8001/mcp)
- **Database**: Weaviate Vector DB (10.5.9.199:8181)

**Auto-trigger scenarios**:
1. Querying project documents ("帮我查找关于API设计的文档")
2. Searching knowledge base ("知识库中有关于微服务架构的信息吗？")
3. Document retrieval ("搜索包含JWT认证的文档")
4. Technical consultation ("这个错误如何解决？")
5. Learning resources ("推荐一些关于微服务的学习资料")

**Configuration**:
- Endpoint: `http://localhost:8001/mcp`
- Protocol: StreamableHTTP
- Timeout: 30 seconds
- Retry: 3 attempts with exponential backoff

## Configuration Files

### marketplace.json (`.claude-plugin/marketplace.json`)

Defines the plugin bundle:
```json
{
  "name": "thy",
  "plugins": [
    {"name": "tech-translator", "category": "productivity"},
    {"name": "simple-rag", "category": "productivity"}
  ]
}
```

### .mcp.json (`.claude-plugin/.mcp.json`)

Global MCP server configuration for simple-rag:
```json
{
  "mcpServers": {
    "simple-rag": {
      "url": "http://localhost:8001/mcp",
      "env": {
        "WEAVIATE_HOST": "10.5.9.199",
        "WEAVIATE_PORT": "8181",
        "WEAVIATE_GRPC_PORT": "50051"
      }
    }
  }
}
```

## Important Notes

1. **simple-rag dependencies**: Both MCP Server and Weaviate must be running for the plugin to function
2. **Translation consistency**: tech-translator maintains terminology consistency across documents
3. **No build process**: This is a configuration/documentation repository - no compilation required
4. **Git workflow**: Each plugin can be updated independently while maintaining marketplace bundle
5. **Service health**: Use `verify-setup.sh` to check if all required services are running

## Troubleshooting

### simple-rag not working

```bash
# Check MCP Server is running
curl http://localhost:8001/health || echo "MCP Server down"

# Check Weaviate connectivity
curl http://10.5.9.199:8181/health || echo "Weaviate down"

# Run full verification
./plugins/simple-rag/verify-setup.sh
```

### Plugin not appearing in Claude Code

1. Verify `plugin.json` exists in plugin directory
2. Check `marketplace.json` includes the plugin
3. Restart Claude Code application
4. Verify `.mcp.json` MCP server configuration is valid

## References

- Root README: `README.md` - Marketplace overview and installation
- Tech Translator details: `plugins/tech-translator/skills/SKILL.md`
- Simple RAG details: `plugins/simple-rag/README.md` and `plugins/simple-rag/skills/SKILL.md`
