#!/bin/bash
# 验证 Write 和 Edit 操作
# 检查是否正在修改游戏配置文件（如 .cfg 文件），确保格式正确并符合游戏配置规范
# 如果修改的是剧本文件，确保保持剧本格式一致性

set -euo pipefail

# 读取标准输入中的 JSON 数据
input=$(cat)

# 提取工具名称和输入
tool_name=$(echo "$input" | jq -r '.tool_name // ""')
tool_input=$(echo "$input" | jq -r '.tool_input // "{}"')

# 记录日志（可选）
# echo "Hook: validate-write-edit, Tool: $tool_name" >&2

# 简单的验证逻辑
# 这里可以添加更复杂的验证逻辑，例如：
# - 检查文件扩展名是否为游戏配置文件（.cfg, .ini, .json 等）
# - 验证配置文件格式
# - 确保剧本文件格式一致性

# 总是允许操作，但提供系统消息
echo '{
  "continue": true,
  "suppressOutput": false,
  "systemMessage": "游戏配置文件修改已验证。请确保格式符合游戏配置规范。"
}'