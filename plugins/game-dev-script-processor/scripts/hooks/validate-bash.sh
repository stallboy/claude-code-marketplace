#!/bin/bash
# 验证 Bash 命令安全性
# 检查Bash命令是否包含危险操作（如 rm -rf, mv, dd 等）
# 如果涉及删除或移动重要文件，请确认操作安全

set -euo pipefail

# 读取标准输入中的 JSON 数据
input=$(cat)

# 提取工具输入中的命令
tool_input=$(echo "$input" | jq -r '.tool_input // "{}"')
command=$(echo "$input" | jq -r '.tool_input.command // ""')

# 记录日志（可选）
# echo "Hook: validate-bash, Command: $command" >&2

# 危险操作模式匹配
dangerous_patterns=(
  "rm -rf"
  "rm -fr"
  "rm -r -f"
  "dd if=.* of=.*"
  "mv .* /dev/null"
  "chmod 777"
  "chown root"
  "> /dev/sd"
  ":(){:|:&};:"
)

# 检查命令是否包含危险模式
is_dangerous=false
dangerous_reason=""

for pattern in "${dangerous_patterns[@]}"; do
  if [[ "$command" =~ $pattern ]]; then
    is_dangerous=true
    dangerous_reason="检测到危险模式: $pattern"
    break
  fi
done

# 检查是否删除系统关键目录
if [[ "$command" =~ rm.*/(etc|usr|lib|bin|sbin|var|root|home) ]]; then
  is_dangerous=true
  dangerous_reason="可能删除系统关键目录"
fi

if [ "$is_dangerous" = true ]; then
  echo '{
    "continue": false,
    "suppressOutput": false,
    "systemMessage": "警告: '"$dangerous_reason"'。请确认操作安全。"
  }'
  exit 2
else
  echo '{
    "continue": true,
    "suppressOutput": false,
    "systemMessage": "Bash命令安全检查通过。请谨慎操作。"
  }'
fi