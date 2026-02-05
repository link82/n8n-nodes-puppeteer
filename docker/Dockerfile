FROM docker.n8n.io/n8nio/n8n

USER root

# Install n8n-nodes-puppeteer in a permanent location.
# This node connects only to a remote browser (e.g. Browserless).
# Set PUPPETEER_BROWSER_WS_ENDPOINT or configure the endpoint in the node.
RUN mkdir -p /opt/n8n-custom-nodes && \
    cd /opt/n8n-custom-nodes && \
    npm install n8n-nodes-puppeteer && \
    chown -R node:node /opt/n8n-custom-nodes

# Copy our custom entrypoint
COPY docker-custom-entrypoint.sh /docker-custom-entrypoint.sh
RUN chmod +x /docker-custom-entrypoint.sh && \
    chown node:node /docker-custom-entrypoint.sh

USER node

ENTRYPOINT ["/docker-custom-entrypoint.sh"]
