# 技术文档翻译指南

## 翻译工作流程

### 阶段1：预翻译分析
1. **文档评估**
   - 识别文档类型（API文档、教程、学术论文、用户手册等）
   - 确定技术领域（前端开发、后端开发、数据科学、AI等）
   - 分析目标读者群体（开发者、研究人员、普通用户）

2. **术语映射**
   - 创建术语一致性表格
   - 标记所有技术术语和专有名词
   - 确定每个术语的分类（A类、B类、C类）

3. **结构分析**
   - 记录所有格式元素（标题、列表、表格、代码块）
   - 识别特殊内容（数学公式、URL、文件路径）
   - 分析文档逻辑结构

### 阶段2：翻译执行
1. **应用分类规则**
   - A类术语：保持原样
   - B类术语：首次出现使用"中文翻译(英文原词)"格式
   - C类术语：完全翻译

2. **处理首次出现**
   - 为每个B类术语建立翻译记录
   - 确保首次出现格式正确
   - 记录在术语一致性表格中

3. **维护后续引用**
   - 使用已建立的翻译，不重复英文标注
   - 检查术语一致性
   - 更新术语表格

4. **保留技术元素**
   - 代码块、数学公式、URL、路径、版本号保持原样
   - 验证技术内容的完整性

### 阶段3：质量保证
1. **一致性检查**
   - 验证所有重复术语使用相同翻译
   - 检查首次出现标注是否正确应用
   - 确保术语表格完整准确

2. **技术验证**
   - 确认技术概念准确传达
   - 验证专业术语翻译正确性
   - 检查技术细节的准确性

3. **格式完整性**
   - 确认所有格式元素正确保留
   - 验证文档结构完整性
   - 检查特殊内容处理

4. **可读性审查**
   - 确保翻译在目标语言中流畅自然
   - 检查技术内容的可访问性
   - 验证没有语法和拼写错误

## 术语分类系统详解

### A类：保持原样（不翻译）

#### 编程语言和框架
- **保留原因**：这些是专有名称，全球统一使用
- **示例**：Python, JavaScript, TypeScript, Java, C++, Go, Rust
- **框架**：React, Vue, Angular, Node.js, Express, Django, Spring

#### 技术标准和协议
- **保留原因**：国际标准，确保技术兼容性
- **示例**：HTTP, HTTPS, TCP/IP, UDP, WebSocket, REST, GraphQL
- **数据格式**：JSON, XML, YAML, CSV

#### 缩写和首字母缩略词
- **保留原因**：行业通用，避免混淆
- **示例**：API, SDK, IDE, CLI, GUI, URL, URI
- **硬件相关**：CPU, GPU, RAM, SSD

#### 专有名词
- **公司名称**：Google, Microsoft, Apple, Amazon, Meta
- **产品名称**：Windows, macOS, iOS, Android, Chrome, Firefox
- **项目名称**：Kubernetes, Docker, TensorFlow, PyTorch

#### 领域特定术语
- **保留原因**：特定技术领域的专业术语
- **示例**：rendering pipeline, neural network, microservices
- **AI/ML**：machine learning, deep learning, natural language processing

### B类：翻译加标注（首次出现）

#### 技术概念
- **处理方式**：首次出现使用"中文翻译(英文原词)"
- **示例**：
  - algorithm → 算法(algorithm)
  - function → 函数(function)
  - database → 数据库(database)
  - deployment → 部署(deployment)

#### 系统组件
- **处理方式**：建立术语一致性
- **示例**：
  - server → 服务器(server)
  - client → 客户端(client)
  - container → 容器(container)
  - cluster → 集群(cluster)

#### 开发术语
- **处理方式**：确保技术准确性
- **示例**：
  - integration → 集成(integration)
  - testing → 测试(testing)
  - debugging → 调试(debugging)
  - optimization → 优化(optimization)

### C类：完全翻译

#### 通用计算机术语
- **处理方式**：直接翻译，无需标注
- **示例**：
  - computer → 计算机
  - software → 软件
  - hardware → 硬件
  - network → 网络

#### 基础数学术语
- **处理方式**：使用标准数学翻译
- **示例**：
  - variable → 变量
  - parameter → 参数
  - equation → 方程
  - matrix → 矩阵

#### 日常技术词汇
- **处理方式**：流畅自然的中文表达
- **示例**：
  - user → 用户
  - file → 文件
  - system → 系统
  - application → 应用程序

### 格式保持规则

#### 代码块处理
```python
# 保持原样，不翻译
import requests

def fetch_data(url):
    response = requests.get(url)
    return response.json()
```

#### 数学公式处理
保持数学公式原样，不翻译：
- $E = mc^2$ → $E = mc^2$
- $\sum_{i=1}^{n} i = \frac{n(n+1)}{2}$ → $\sum_{i=1}^{n} i = \frac{n(n+1)}{2}$

#### URL和文件路径
保持原样，不翻译：
- `https://api.example.com/v1/users` → `https://api.example.com/v1/users`
- `/usr/local/bin/python` → `/usr/local/bin/python`

#### 版本号
保持原样，不翻译：
- `v1.2.3` → `v1.2.3`
- `Python 3.9` → `Python 3.9`

### 文档结构保持

#### 标题层级
保持原有的标题层级和格式：
```markdown
# Main Title → # 主标题
## Section Title → ## 章节标题
### Subsection Title → ### 子章节标题
```

#### 列表和表格
保持列表和表格的格式：
```markdown
- Item 1 → - 项目1
- Item 2 → - 项目2
  - Subitem →   - 子项目
```

#### 引用和代码块
保持引用和代码块的格式：
````markdown
> This is a quote → > 这是一个引用

```python
code here → 
```
代码在这里
````

## 常见问题处理

### 不确定术语的处理
当不确定某个术语是否应该翻译时：
1. 优先保留英文术语
2. 可以添加脚注说明
3. 参考技术术语词汇表

### 长句子的处理
对于复杂的技术长句：
1. 保持技术准确性
2. 适当拆分句子结构
3. 确保中文表达流畅

### 文化差异处理
对于包含文化特定内容的文档：
1. 保持技术内容的准确性
2. 适当解释文化背景
3. 使用脚注提供额外信息

## 质量检查清单

### 技术准确性
- [ ] 所有技术术语翻译正确
- [ ] 代码块和公式保持原样
- [ ] 技术概念表达准确

### 格式完整性
- [ ] 文档结构保持完整
- [ ] 所有格式元素正确保留
- [ ] 链接和引用正常工作

### 语言质量
- [ ] 中文表达流畅自然
- [ ] 术语使用一致
- [ ] 没有语法和拼写错误

### 用户体验
- [ ] 翻译易于理解
- [ ] 技术内容可读性强
- [ ] 适合目标受众阅读

## 示例翻译

### 输入文档
````
The React framework provides a component-based architecture for building user interfaces. Each component manages its own state and can be composed to create complex UIs.

To install React, use the following command:

```bash
npm install react react-dom
```

React components use JSX syntax, which allows you to write HTML-like code in JavaScript.
````

### 输出翻译
````
React框架提供基于组件的架构来构建用户界面。每个组件管理自己的状态，并且可以组合起来创建复杂的用户界面。

要安装React，请使用以下命令：

```bash
npm install react react-dom
```

React组件使用JSX语法，允许你在JavaScript中编写类似HTML的代码。
````