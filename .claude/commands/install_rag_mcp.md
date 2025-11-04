# /install_rag_mcp

注册Simple RAG插件的MCP服务器

## 描述

自动注册Simple RAG插件的MCP服务器到Claude Code，简化配置过程。

## 使用方法

```
/install_rag_mcp
```

## 执行流程

### 1. 询问MCP服务器地址

```
请输入MCP服务器地址：
默认地址：http://localhost:8001/mcp

请输入地址（或按回车使用默认值）：
```

### 2. 验证连接

检查MCP服务器是否可访问：
```bash
curl -s http://localhost:8001/health
```

### 3. 执行注册

根据用户输入执行注册命令：

**默认地址时：**
```bash
claude mcp add --transport http simple-rag http://localhost:8001/mcp
```

**自定义地址时：**
```bash
claude mcp add --transport http simple-rag <用户输入的地址>
```

### 4. 验证注册

确认simple-rag已成功注册：
```bash
claude mcp list | grep simple-rag
```

## 示例对话

```
用户: /install_rag_mcp

助手: 请输入MCP服务器地址：
      默认地址：http://localhost:8001/mcp

      请输入地址（或按回车使用默认值）：
用户: [按回车]

助手: 正在检查MCP服务器连接...
      ✓ 连接成功！

      正在注册MCP服务器...
      claude mcp add --transport http simple-rag http://localhost:8001/mcp

      正在验证注册...
      ✓ 注册成功！

      simple-rag 服务器已成功注册到Claude Code
```

## 自动化脚本

如果您想直接运行自动化脚本：

```bash
# 方式1：使用默认地址
claude mcp add --transport http simple-rag http://localhost:8001/mcp

# 方式2：使用自定义地址
claude mcp add --transport http simple-rag http://YOUR_SERVER:8001/mcp
```

## 故障排除

### 常见问题

1. **MCP服务器未运行**
   ```
   错误：连接失败
   解决：确保MCP服务器正在运行
   ```

2. **权限问题**
   ```
   错误：Permission denied
   解决：确保有权限访问配置文件
   ```

3. **地址错误**
   ```
   错误：无法连接到服务器
   解决：检查地址是否正确，确保包含 http://
   ```

### 手动验证

运行以下命令检查状态：
```bash
# 检查MCP服务器状态
curl http://localhost:8001/health

# 列出已注册的MCP服务器
claude mcp list

# 验证simple-rag插件
cd plugins/simple-rag
./verify-setup.sh
```

## 完整示例

### 示例1：使用默认地址

```bash
$ /install_rag_mcp
✓ 默认地址：http://localhost:8001/mcp
✓ 服务器连接正常
✓ 注册成功
✓ 验证通过
```

### 示例2：使用自定义地址

```bash
$ /install_rag_mcp
请输入地址：http://192.168.1.100:8001/mcp
✓ 服务器连接正常
✓ 注册成功
✓ 验证通过
```

## 配置文件位置

注册后，MCP服务器配置将添加到：
- Linux/macOS: `~/.claude/mcp.json`
- Windows: `%USERPROFILE%/.claude/mcp.json`

## 相关命令

```bash
# 查看所有MCP服务器
claude mcp list

# 移除MCP服务器
claude mcp remove simple-rag

# 查看MCP服务器详细信息
claude mcp show simple-rag
```

## 依赖服务

- **MCP服务器**: 默认 http://localhost:8001/mcp
- **Weaviate数据库**: 10.5.9.199:8181

确保这些服务正常运行后，插件即可正常工作。
