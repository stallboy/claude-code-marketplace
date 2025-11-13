# 配置表查询API参考

## API 端点

### 查询单个表Schema
- **URL:** `http://$HOST/cfgserver/query_table?table_name=$tablename`
- **方法:** GET
- **参数:** `table_name` - 表名称字符串

### 查询多个表Schema
- **URL:** `http://$HOST/cfgserver/query_tables?table_name=$tablenames`
- **方法:** GET
- **参数:** `table_name` - 逗号分隔的表名列表

## 响应格式

### 成功响应
```json
{
    "result": "success",
    "schema": "cfg语法描述的schema内容",
    "table_name": "查询的表名"
}
```

### 错误响应
```json
{
    "result": "error",
    "err_msg": "错误描述信息"
}
```

## 使用示例

### 单表查询
```bash
curl "http://localhost/cfgserver/query_table?table_name=video"
```

### 多表查询
```bash
curl "http://localhost/cfgserver/query_tables?table_name=video,choice,videonodetype"
```

## 配置说明

- 默认主机地址：`localhost`
- 实际部署时替换为真实主机地址
- 无需认证和授权
- 无访问频率限制