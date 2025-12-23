---
allowed-tools: mcp__cfg_mcp, Read, Write, Edit
description: 总结所有配置模块与配置表。
---


# summarize-config-tables

## Command Description

利用已接入的 MCP 服务 `cfg_mcp`，遍历所有配置模块与配置表，读取每个表的真实结构信息，并生成或更新配置总结说明。
最终将总结结果按模块分别写入对应目录下的 `$mod.md` 文件中，便于后续 AI 辅助配表时快速定位和理解配置内容。

**重要说明**：`cfg_mcp.listModule` 和 `cfg_mcp.listTable` 返回的 `description` 和 `rule` 字段是从现有的 `$mod.md`
文件中读取的文档信息，不是真实的数据库结构。这些信息可能过时或不完整。

---

## Parameters

- configRoot（可选）
- 配置根目录路径
- 默认值：`..\Config`
- 若提供参数 `configRoot`，该参数仅作为【配置根目录】使用
- 实际输出路径仍需在该根目录下，按模块规则生成对应的模块子目录
- 示例：
    - 若 `configRoot = ..\Config`
    - 且当前模块为 `video`
    - 则最终输出路径为：`..\Config\Video\$mod.md`

---

## 注意事项

1. **不允许自行编写或生成任何代码逻辑**
    - 不允许实现解析、推导、计算或数据加工代码
    - 所有信息获取必须仅通过 MCP 工具完成

2. **区分首次生成和更新场景**
    - 首次生成：创建完整的 `$mod.md` 文件
    - 更新场景：保留已有的人工编写内容，只更新表列表部分

---

## Execution Steps

### Step 1：获取所有模块列表

1. 调用 `cfg_mcp.listModule`
2. 从返回结果中提取 `modules[].moduleName`
3. 将所有 `moduleName` 作为后续遍历的模块列表

**注意**：`listModule` 返回的 `description` 是从现有 `$mod.md` 读取的，listModule仅用于知道有哪些模块。

---

### Step 2：逐个模块获取真实的表列表

对 Step 1 中获得的每一个 `moduleName`，依次执行以下操作：

1. 调用 `cfg_mcp.listTable(moduleName)`
2. 从返回结果中读取：
    - `inModule`：模块名
    - `tableNames`：真实的表名列表（这是可靠的信息）
3. **忽略 `description` 和 `rule` 字段**，这些是从现有 `$mod.md` 读取的，可能过时

---

### Step 3：读取每个配置表的真实结构信息

对当前模块中 `tableNames` 列表里的每一个 `tableName`：

1. 调用 `cfg_mcp.readTableSchema(tableName)`
2. 分析返回的 `relatedSchema` 字段
3. 基于表结构信息总结表的用途描述，**只需简单描述**
4. 将这些信息作为后续总结的输入素材

---

### Step 4：确定总结文件输出路径

根据模块名称确定输出目录与文件路径：

1. **配置根目录确定规则**：
    - 若提供参数 `configRoot`，则使用该参数作为配置根目录
    - 否则，默认使用 `..\Config` 作为配置根目录

2. **模块名规则**：
    - 普通模块：首字母大写作为文件夹名
    - 例如：`video` → `{configRoot}/Video`
    - 特殊模块 `_top`：
    - 表示配置根目录本身
    - 输出目录为：`{configRoot}`

3. **总结文件名**：
    - 每个模块的总结文件名固定为：`$mod.md`
    - `$mod.md` 是一个固定文件名，不随模块名变化
    - 每个模块目录下只会存在一个 `$mod.md`，用于承载该模块的全部总结内容
    - 比如 video 模块的数据文件路径为 `{configRoot}/Video/$mod.md`

4. **文件夹处理**：
    - 默认所有的模块文件夹都存在，无需检查是否存在

---

### Step 5：生成或更新模块总结内容

#### 场景判断：
1. **首次生成**：如果 `$mod.md` 文件不存在，创建完整的新文件
2. **更新场景**：如果 `$mod.md` 文件已存在，读取现有内容，保留人工编写部分

#### 5.1 生成 Front-matter（模块整体总结）

首次生成：
- 基于模块中所有表的共同特点，生成模块描述
- 输出格式：
```md
---
description: 模块整体功能与配置职责说明
---
```

更新场景：
- 读取现有文件的 front-matter
- 如果 description 明显不合适，可以更新

5.2 生成表级总结（Markdown 正文）

首次生成：
- 为 tableNames 中的每个表生成描述，**只需简单描述**
- 使用标准 Markdown 列表格式：
```md
- 表名1: 基于表结构生成的描述
- 表名2: 基于表结构生成的描述
```

更新场景：
1. 读取现有文件的正文内容
2. 识别并保留人工编写的内容：
- 表列表通常以 - 表名: 开头
- 正文中表列表以外的其他内容（段落、列表、代码块等）都视为人工编写，必须保留
3. 更新表列表：
- 确保列出 tableNames 中的所有表
- 对于已有描述的表：如果有明显变化，可以更新
- 对于新增的表：基于 readTableSchema 生成描述
- 对于已删除的表：从列表中移除
4. 合并内容：将更新的表列表与保留的人工内容合并

描述生成规则：
- 从 readTableSchema中提取表信息,生成简答的总结描述

---
Step 6：写入模块总结文件

1. 将 Step 5 生成的内容写入对应模块的 $mod.md 文件
2. 文件已存在的处理：
- 对比新内容与旧内容
- 如果只有表列表更新，保留其他所有内容
- 如果 front-matter 的 description 需要更新，更新它
3. 确保文件格式正确：
- Front-matter 使用 --- 分隔
- 表列表使用标准 Markdown 列表格式
- 人工编写内容保持原格式

---
Step 7：验证总结完整性

完成所有模块后，进行简单验证：
1. 重新调用 cfg_mcp.listTable 获取每个模块的表列表
2. 检查对应 $mod.md 文件是否包含了所有表
3. 如果发现遗漏，重新处理该模块
4. **不允许写代码检查**