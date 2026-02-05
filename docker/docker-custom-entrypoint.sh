#!/bin/sh

print_banner() {
    echo "----------------------------------------"
    echo "n8n Puppeteer Node - Environment Details"
    echo "----------------------------------------"
    echo "Node.js version: $(node -v)"
    echo "n8n version: $(n8n --version)"

    PUPPETEER_PATH="/opt/n8n-custom-nodes/node_modules/n8n-nodes-puppeteer"
    if [ -f "$PUPPETEER_PATH/package.json" ]; then
        PUPPETEER_VERSION=$(node -p "require('$PUPPETEER_PATH/package.json').version")
        echo "n8n-nodes-puppeteer version: $PUPPETEER_VERSION"
    else
        echo "n8n-nodes-puppeteer: not installed"
    fi

    if [ -n "$PUPPETEER_BROWSER_WS_ENDPOINT" ] || [ -n "$PUPPETEER_WS_ENDPOINT" ]; then
        echo "Browser endpoint: ${PUPPETEER_BROWSER_WS_ENDPOINT:-$PUPPETEER_WS_ENDPOINT}"
    else
        echo "Browser endpoint: (set PUPPETEER_BROWSER_WS_ENDPOINT or configure in node)"
    fi
    echo "----------------------------------------"
}

# Add custom nodes to the NODE_PATH
if [ -n "$N8N_CUSTOM_EXTENSIONS" ]; then
    export N8N_CUSTOM_EXTENSIONS="/opt/n8n-custom-nodes:${N8N_CUSTOM_EXTENSIONS}"
else
    export N8N_CUSTOM_EXTENSIONS="/opt/n8n-custom-nodes"
fi

print_banner

# Execute the original n8n entrypoint script
exec /docker-entrypoint.sh "$@"
