# Game Dev Script Processor 插件

## 概述

游戏开发剧本处理器插件，专门用于将剧本文件转换为游戏配置文件。

## 安装

```bash
/plugin install game-dev-script-processor@claude-code-marketplace
```

## 使用方法

### 基本使用
```bash
/script-to-config --script-dir Doc/剧本_md_dir
```

### 参数说明
- `--script-dir`: 剧本目录路径（必需）
- `--output-dir`: 输出目录路径（可选，默认Main/AIWork）
- `--work-dir`: 工作目录路径（可选，默认为.work）
- `--rule-dir`: 规则目录路径（可选）
- `--resume`: 继续上次处理（可选）
- `--chunk-size`: 分块大小配置（可选，默认100）

## 功能特性

- 支持大型剧本文件分块处理
- 自动生成多种游戏配置文件
- 配置验证和完整性检查
- 处理进度跟踪和恢复

## 支持的配置文件

- video.cfg
- story.cfg
- prop.cfg
- role.cfg
- qte.cfg
- sceneexplore.cfg

## 许可证

MIT License