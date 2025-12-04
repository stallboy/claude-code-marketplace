#!/bin/bash
# 验证 Task 任务完成后的文件完整性
# 剧本处理任务完成后，检查生成的文件是否完整，并验证配置文件的正确性

set -euo pipefail

# 读取标准输入中的 JSON 数据
input=$(cat)

# 提取工具结果
tool_result=$(echo "$input" | jq -r '.tool_result // "{}"')

# 记录日志（可选）
# echo "Hook: validate-task-completion" >&2

# 这里可以添加文件完整性检查逻辑，例如：
# - 检查生成的文件是否存在
# - 验证配置文件语法
# - 确保所有必需字段都已填写

echo '{
  "continue": true,
  "suppressOutput": false,
  "systemMessage": "剧本处理任务完成。请检查生成的文件完整性，并验证配置文件正确性。"
}'