// check_config_access.js

const fs = require('fs');

// 获取命令行参数
const toolName = process.argv[2];
const toolInput = process.argv[3];

// 假设：您需要通过环境变量获取 transcript 的路径
// 请查阅 Claudecode 文档以确认它是否提供类似于 CLAUDECODE_TRANSCRIPT_PATH 的环境变量
const transcriptPath = process.env.CLAUDECODE_TRANSCRIPT_PATH;

/**
 * 检查当前上下文是否处于 /do-config 命令中
 * @returns {boolean}
 */
function isExecutingDoConfig() {
    if (!transcriptPath || !fs.existsSync(transcriptPath)) {
        // 如果无法获取 transcript，保守起见默认允许 (或者根据您的需求决定默认拒绝)
        console.error("Warning: Could not access transcript file.");
        return false; 
    }

    try {
        const transcript = fs.readFileSync(transcriptPath, 'utf8');
        // 简单检查 transcript 内容中是否包含 /do-config
        return transcript.includes('/do-config');
    } catch (e) {
        console.error("Error reading transcript:", e.message);
        return false;
    }
}

/**
 * 检查工具输入是否涉及策划配表文件
 * @param {string} input - 工具输入内容
 * @returns {boolean}
 */
function involvesConfigTable(input) {
    // 策划配表文件特征 (正则匹配，不区分大小写)
    // - 文件扩展名：.cfg, .json, .yaml, .yml, .csv, .xlsx, .xls, .ini, .properties
    // - 文件路径包含：config, 配置, table, 表, data, 数据
    const configRegex = /(\.cfg|\.json|\.yaml|\.yml|\.csv|\.xlsx|\.xls|\.ini|\.properties)|(config|配置|table|表|data|数据)/i;
    
    return configRegex.test(input);
}

if (isExecutingDoConfig() && involvesConfigTable(toolInput)) {
    // 违反规则：do-config 且涉及配表
    console.error("Security Deny: do-config 命令禁止直接操作策划配表，必须使用 MCP Server");
    // 返回非零退出码，通知 Claudecode 拒绝工具调用
    process.exit(1); 
} else {
    // 符合规则或不是 do-config 命令
    process.exit(0); // 返回零退出码，通知 Claudecode 允许工具调用
}