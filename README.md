# Claude Code Marketplace


## 安装rag

```bash
claude mcp add --transport http rag http://10.x.x.x:8001/mcp
```



## 添加插件市场
```
/plugin marketplace https://github.com/stallboy/claude-code-marketplace
```




## 安装插件

### 1. tech-translator (技术翻译插件)

专为科技文献、学术论文和工程文档翻译而设计，遵循叶劲峰《游戏引擎架构》的翻译风格，使用中文翻译并在首次出现时用括号标注英文技术术语，在保持技术准确性的同时确保中文读者的可读性。

```bash
/plugin install tech-translator@claude-code-marketplace
```


### 2. code

代码相关

- linux-review 以Linus Torvalds的风格进行代码审查，强调简洁性、实用性和向后兼容性

```bash
/plugin install code@claude-code-marketplace
```

### 3. game-dev-script-processor (游戏开发剧本处理器)

专为游戏开发设计的剧本处理器，能够将剧本文件自动转换为游戏配置文件。支持大型剧本文件的分块处理、配置验证和进度跟踪。

```bash
/plugin install game-dev-script-processor@claude-code-marketplace
```
