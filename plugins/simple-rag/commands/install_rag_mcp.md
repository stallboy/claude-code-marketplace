# /install_rag_mcp

注册Simple RAG插件的MCP服务器

## 描述

这个命令会自动注册Simple RAG插件的MCP服务器到Claude Code。命令会询问您要连接的MCP服务器地址，默认使用 localhost:8001。

## 使用方法

```
/install_rag_mcp
```

## 执行流程

1. 询问MCP服务器地址（默认：http://localhost:8001/mcp）
2. 执行注册命令：`claude mcp add --transport http simple-rag <服务器地址>`
3. 验证注册是否成功
4. 显示结果

## 示例

```
/install_rag_mcp
```

系统会提示：
- 默认地址：http://localhost:8001/mcp
- 如果您的MCP服务器在其他地址，请输入完整URL
- 例如：http://192.168.1.100:8001/mcp

## 验证

注册成功后，您可以运行以下命令验证：

```bash
claude mcp list
```

应该能看到 `simple-rag` 服务器在列表中。

## 依赖

确保MCP服务器正在运行：
- 启动MCP服务器：`npm run dev` 或查看项目文档
- 默认地址：http://localhost:8001/mcp
- 健康检查：http://localhost:8001/health

## 故障排除

如果注册失败：
1. 确保MCP服务器正在运行
2. 检查服务器地址是否正确
3. 确认防火墙未阻止连接
4. 运行验证脚本：`./verify-setup.sh`
