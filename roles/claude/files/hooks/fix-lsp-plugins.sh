#!/bin/bash
# Fix LSP plugin configs by removing unsupported fields like startupTimeout
# This runs on SessionStart to ensure LSP servers load properly

MARKETPLACE_JSON="$HOME/.claude/plugins/marketplaces/claude-plugins-official/.claude-plugin/marketplace.json"

[ ! -f "$MARKETPLACE_JSON" ] && exit 0

node -e "
const fs = require('fs');
const path = '$MARKETPLACE_JSON';
let data;
try {
    data = JSON.parse(fs.readFileSync(path, 'utf8'));
} catch (e) {
    process.exit(0);
}

let fixed = false;
const unsupportedFields = ['startupTimeout', 'shutdownTimeout'];

if (data.plugins) {
    for (const plugin of data.plugins) {
        if (plugin.lspServers) {
            for (const [serverName, config] of Object.entries(plugin.lspServers)) {
                for (const field of unsupportedFields) {
                    if (config[field] !== undefined) {
                        delete config[field];
                        fixed = true;
                    }
                }
            }
        }
    }
}

if (fixed) {
    fs.writeFileSync(path, JSON.stringify(data, null, 2));
}
" 2>/dev/null

exit 0
