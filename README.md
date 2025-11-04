# Claude Code Marketplace

```
/plugin marketplace https://github.com/stallboy/claude-code-marketplace
```

## Available Plugins

### 1. tech-translator (技术翻译插件)

专为科技文献、学术论文和工程文档翻译而设计，遵循叶劲峰《游戏引擎架构》的翻译风格，使用中文翻译并在首次出现时用括号标注英文技术术语，在保持技术准确性的同时确保中文读者的可读性。

```bash
/plugin install tech-translator@claude-code-marketplace
```

### 2. simple-rag (知识数据库插件)

提供对外部知识数据库和文档库的访问能力。通过MCP Server实时查询向量数据库(Weaviate)，返回与用户问题相关的文档和信息。

#### 安装插件

```bash
/plugin install simple-rag@claude-code-marketplace
```

#### 配置MCP服务器

安装插件后，需要配置MCP服务器连接。可以通过以下命令手动添加MCP服务器：

**方法1：直接添加到Claude配置**

```bash
# 通过MCP配置文件添加服务器地址
# 编辑或创建：~/.claude/.mcp.json

{
  "mcpServers": {
    "simple-rag": {
      "name": "simple-rag-plugin",
      "description": "Plugin-specific MCP Server configuration",
      "command": "http",
      "url": "http://localhost:8001/mcp",
      "headers": {
        "Accept": "application/json, text/event-stream",
        "Content-Type": "application/json"
      },
      "env": {
        "WEAVIATE_HOST": "10.5.9.199",
        "WEAVIATE_PORT": "8181",
        "WEAVIATE_GRPC_PORT": "50051"
      },
      "timeout": 30000,
      "retry": {
        "retries": 3,
        "factor": 2,
        "minTimeout": 1000
      }
    }
  }
}
```

**方法2：通过Claude Code配置界面**

1. 打开Claude Code设置
2. 找到"MCP Servers"配置
3. 添加服务器信息：
   - **名称**: simple-rag
   - **类型**: HTTP
   - **URL**: http://localhost:8001/mcp
   - **Headers**:
     - `Accept: application/json, text/event-stream`
     - `Content-Type: application/json`

**方法3：使用Slash Command（推荐）⭐**

最简单的配置方式！直接使用命令：

```bash
/install_rag_mcp
```

**执行流程：**

1. 运行 `/install_rag_mcp` 命令
2. 系统会自动提示输入MCP服务器地址（默认：`http://localhost:8001/mcp`）
3. 按回车使用默认地址，或输入自定义地址
4. 系统自动验证服务器连接
5. 自动执行注册命令
6. 自动验证注册结果

**示例交互：**

```
/install_rag_mcp

请输入MCP服务器地址：
默认地址：http://localhost:8001/mcp

请输入地址（或按回车使用默认值）：
[按回车]

✓ 正在检查MCP服务器连接...
✓ 连接成功！

✓ 正在注册MCP服务器...
  执行命令：claude mcp add --transport http simple-rag http://localhost:8001/mcp

✓ 注册成功！
simple-rag 服务器已成功注册到Claude Code
```

**优势：**
- ✅ 一条命令完成所有配置
- ✅ 智能提示和默认值
- ✅ 自动验证服务器连接
- ✅ 自动验证注册结果
- ✅ 无需手动编辑配置文件

#### 使用示例

安装并配置完成后，插件会在以下场景自动触发：

- **查询项目文档**: "帮我查找关于API设计的文档"
- **搜索知识库**: "知识库中有关于微服务架构的信息吗？"
- **文档检索**: "搜索包含JWT认证的文档"
- **查找人员参与情况**: "龚华君在项目中参与了哪些文档？"
- **技术咨询**: "这个错误如何解决？"

#### 验证配置

运行验证脚本检查配置：

```bash
cd plugins/simple-rag
./verify-setup.sh
```

测试MCP连接：

```bash
cd plugins/simple-rag
./test-mcp-connection.sh
```

#### 依赖服务

- **MCP Server**: http://localhost:8001/mcp

确保这些服务正常运行后，插件即可正常工作。
