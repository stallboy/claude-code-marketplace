#!/bin/bash
# PreCompact 钩子
# 清理临时文件和中间处理结果，确保工作目录整洁

set -euo pipefail

# 读取标准输入中的 JSON 数据
input=$(cat)

# 记录日志（可选）
# echo "Hook: pre-compact" >&2

# 这里可以添加清理逻辑，例如：
# - 删除临时文件
# - 清理中间处理结果
# - 压缩日志文件

echo '{
  "continue": true,
  "suppressOutput": false,
  "systemMessage": "清理临时文件和中间处理结果，确保工作目录整洁。"
}'