#!/bin/bash
# SessionStart 钩子
# 游戏开发剧本处理器加载时显示欢迎消息

set -euo pipefail

# 读取标准输入中的 JSON 数据（SessionStart 可能没有太多输入）
input=$(cat)

# 记录日志（可选）
# echo "Hook: session-start" >&2

# 输出系统消息
echo '{
  "continue": true,
  "suppressOutput": false,
  "systemMessage": "游戏开发剧本处理器已加载。准备好处理剧本文件转换任务。"
}'