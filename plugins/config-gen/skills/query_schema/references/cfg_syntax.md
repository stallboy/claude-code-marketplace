# CFG 语法解析指南

## 语法概览

CFG语法用于定义游戏配置表的Schema结构，包含三种主要构造：`table`、`struct`、`interface`。

## 核心语法元素

### 1. Table 定义
```cfg
table table_name[id] (attributes) {
    field_name:field_type;
    // 注释
}
```

**属性说明：**
- `id`: 主键字段名
- `json`: 表示表以JSON格式存储
- `title='field'`: 标题字段
- `description='field'`: 描述字段
- `enum='field'`: 枚举类型定义

### 2. Struct 定义
```cfg
struct struct_name {
    field_name:field_type;
    field_name:field_type ->foreign_table.field (refTitle='field');
}
```

### 3. Interface 定义
```cfg
interface interface_name {
    struct struct_name {
        field_name:field_type;
    }
}
```

## 字段类型系统

### 基础类型
- `int`: 整数类型
- `text`: 文本类型
- `str`: 字符串类型
- `bool`: 布尔类型

### 容器类型
- `list<type>`: 类型列表
- `list<struct_type>`: 结构体列表

## 外键关系

### 外键语法
```cfg
field_name:field_type ->foreign_table.field (refTitle='display_field');
```

**示例：**
```cfg
target:int ->video (refTitle='text');
roleId:int ->role.role;
```

### 外键含义
- `->foreign_table`: 指向外键表
- `(refTitle='field')`: 外键表显示字段

## 注释系统

- `// 单行注释`: 用于字段说明
- 注释通常包含策划用途说明

## 实际示例解析

### Video 表定义
```cfg
table video[id] (json, title='name', description='text') {
    id:int; // 剧情节点唯一标识
    name:text; // 节点标题
    type:int ->videonodetype; // 节点类型
    choices:list<choice>; // 选项列表
    actions:list<triggerAction>; // 触发动作
}
```

### Choice 结构定义
```cfg
struct choice {
    text:text;
    target:int ->video (refTitle='text'); // 外键到video表，显示text字段
    timeout:int;
    conds:list<condition>;
    hide:bool;
}
```

## 关联关系分析

### 外键依赖
- `choice.target` → `video.id`
- `video.type` → `videonodetype.id`
- `condition.checkItem.id` → `prop.item`
- `condition.checkInfo.id` → `prop.info`

### 结构嵌套
- `video` 包含 `list<choice>`
- `choice` 包含 `list<condition>`
- `condition` 包含多个检查结构
- `action` 包含多个动作结构

## 查询结果解析

当查询表Schema时，API返回的JSON中包含cfg语法描述的Schema，需要解析：

1. 识别表定义和主键
2. 分析字段类型和外键关系
3. 理解结构嵌套关系
4. 识别关联表依赖