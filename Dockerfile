FROM n8nio/n8n:latest

USER root

# Instalar dependências do Chromium no Alpine
RUN apk update && apk add --no-cache \
    chromium \
    nodejs \
    npm \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    font-noto-emoji \
    fontconfig \
    && apk add --no-cache \
    --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    libgbm \
    && rm -rf /var/cache/apk/*

# Criar diretório para nós comunitários
RUN mkdir -p /home/node/.n8n/nodes

# Instalar o nó Puppeteer e suas dependências completas
RUN cd /home/node/.n8n/nodes && \
    npm init -y && \
    npm install n8n-nodes-puppeteer puppeteer-extra-plugin-user-data-dir puppeteer-extra-plugin-stealth

# Configurar variáveis de ambiente
ENV NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer,puppeteer-extra,puppeteer-extra-plugin-stealth
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV N8N_COMMUNITY_PACKAGES_ENABLED=true

# Voltar para o usuário node
USER node

EXPOSE 5678
