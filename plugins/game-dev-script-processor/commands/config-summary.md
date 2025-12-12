# summarize-config-tables

## Command Description

利用已接入的 MCP 服务 `cfg_mcp`，遍历所有配置模块与配置表，读取每个表的结构与规则信息，并对配置进行总结说明。  
最终将总结结果按模块分别写入对应目录下的 `$mod.md` 文件中，便于后续 AI 辅助配表时快速定位和理解配置内容。

---

## Parameters
- configRoot（可选）
  - 配置根目录路径
  - 默认值：`Main\AIWork`
  - 若提供参数 `configRoot`，该参数仅作为【配置根目录】使用
  - 实际输出路径仍需在该根目录下，按模块规则生成对应的模块子目录
  - 示例：
    - 若 `configRoot = \Config`
    - 且当前模块为 `video`
    - 则最终输出路径为：`\Config\Video\$mod.md`

---

## 注意事项
1. 不允许自行编写或生成任何代码逻辑  
   - 不允许实现解析、推导、计算或数据加工代码  
   - 所有信息获取必须仅通过 MCP 工具完成

2. 调用 `cfg_mcp.listModule` 时：
   - 仅允许读取并使用 `modules[].moduleName`
   - 明确禁止读取或使用 `description` 字段中的任何内容

3. 调用 `cfg_mcp.listTable(moduleName)` 时：
   - 仅允许使用返回结果中的 `inModule` 与 `tableNames`
   - 明确忽略并禁止使用返回结果中的 `description` 与 `rule`，不得基于这些字段生成任何总结或描述

4. 调用 `cfg_mcp.readTableSchema(tableName)` 时：
   - 作为**唯一允许**用于生成模块级与表级总结的信息来源
   - 不允许混用其他 MCP 返回结果中的描述性字段

5. 当目标输出文件 `$mod.md` 已存在时：
   - **禁止读取**该文件中的任何已有内容
   - 不允许基于旧内容进行补充、对比或合并
   - 始终以本次 MCP 获取的信息重新生成并覆盖写入

---

## Execution Steps

### Step 1：获取所有模块列表

1. 调用 `cfg_mcp.listModule`
2. 从返回结果中仅提取 `modules[].moduleName`，**不需要读取** `description` 字段
3. 将所有 `moduleName` 作为后续遍历的模块列表

---

### Step 2：逐个模块获取其下的配置表列表

对 Step 1 中获得的每一个 `moduleName`，依次执行以下操作：

1. 调用 `cfg_mcp.listTable(moduleName)`
2. 从返回结果中读取：
   - `inModule`
   - `tableNames`
3. 如果 `tableNames` 为空，则该模块只生成模块级总结，不生成表级总结
4. **不需要读取** `description` 和 `rule` 的内容，忽略已经存在的 `description` 和 `rule` 的信息

---

### Step 3：读取每个配置表的结构信息

对当前模块中 `tableNames` 列表里的每一个 `tableName`：

1. 调用 `cfg_mcp.readTableSchema(tableName)`
2. 获取该表的信息，简单描述该表的用途即可，不需要详细描述字段信息
3. 将这些信息作为后续总结的输入素材
4. 在进行任何表级或模块级总结时，**只能基于**
   `cfg_mcp.readTableSchema(tableName)` 返回的内容进行整理与概括：
   - 不允许引入返回结果中未明确给出的业务含义
   - 不允许根据表名、字段名进行主观推断或补充说明
   - 不允许假设表的使用场景或策划意图
5. 若 `readTableSchema` 返回信息不足以支撑某项描述：
   - 该部分内容应省略，或明确标注为“未在 schema 中说明”

---

### Step 4：生成模块级与表级总结内容

在当前模块维度下，基于已读取的信息生成总结内容：

#### 4.1 模块整体总结（Front-matter）

- 对该模块的用途、配置范围、在整体配置体系中的职责进行概括
- 输出为 Front-matter 格式：

```md
---
description: 模块整体功能与配置职责说明
---
```

#### 4.2 表级总结（Markdown 正文）

- 按表逐个进行描述
- 只需简单描述每个表的用途即可
- 使用标准 Markdown 格式组织内容，便于阅读

---

### Step 5：确定总结文件输出路径

根据模块名称确定输出目录与文件路径：
1. 配置根目录确定规则：
   - 若提供参数 `configRoot`，则使用该参数作为配置根目录
   - 否则，默认使用 `Main\AIWork` 作为配置根目录
2. 模块名规则：
    - 普通模块：首字母大写作为文件夹名
        - 例如：`video` → `<configRoot>\Video`
    - 特殊模块 `_top`：
        - 表示配置根目录本身
        - 输出目录为：`<configRoot>`
3. 每个模块的总结文件名固定为：`$mod.md`
    - `$mod.md` 是一个固定文件名，不随模块名变化
    - 每个模块目录下只会存在一个 `$mod.md`，用于承载该模块的全部总结内容
    - 比如video模块的数据文件路径为`<configRoot>\Video\$mod.md`
4. 默认所有文件夹都已经存在，无需创建文件夹

---

### Step 6：写入模块总结文件

1. 将 Step 4 生成的内容完整写入对应模块的 `$mod.md` 文件
2. 若文件已存在：
    - **无需读取** `$mod.md` 文件中的内容
    - 覆盖写入最新总结内容
3. 确保每个模块只生成一个总结文件