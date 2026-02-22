FROM n8nio/n8n:latest

USER root

# Detectar e instalar dependências baseado no sistema
RUN if command -v apt-get >/dev/null 2>&1; then \
        apt-get update && apt-get install -y \
        chromium \
        nodejs \
        npm \
        fonts-liberation \
        libasound2 \
        libatk-bridge2.0-0 \
        libatk1.0-0 \
        libc6 \
        libcairo2 \
        libcups2 \
        libdbus-1-3 \
        libexpat1 \
        libfontconfig1 \
        libgbm1 \
        libgcc1 \
        libglib2.0-0 \
        libgtk-3-0 \
        libnspr4 \
        libnss3 \
        libpango-1.0-0 \
        libpangocairo-1.0-0 \
        libstdc++6 \
        libx11-6 \
        libx11-xcb1 \
        libxcb1 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxi6 \
        libxrandr2 \
        libxrender1 \
        libxss1 \
        libxtst6 \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*; \
    elif command -v apk >/dev/null 2>&1; then \
        apk update && apk add --no-cache \
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
        libgbm \
        && rm -rf /var/cache/apk/*; \
    elif command -v yum >/dev/null 2>&1; then \
        yum install -y \
        chromium \
        nodejs \
        npm \
        && yum clean all; \
    else \
        echo "Nenhum gerenciador de pacotes conhecido encontrado!"; \
        exit 1; \
    fi

# Criar diretório para nós comunitários
RUN mkdir -p /home/node/.n8n/nodes

# Instalar o nó Puppeteer e suas dependências completas
RUN cd /home/node/.n8n/nodes && \
    npm init -y && \
    npm install n8n-nodes-puppeteer puppeteer-extra-plugin-user-data-dir puppeteer-extra-plugin-stealth

# Configurar variáveis de ambiente
ENV NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer,puppeteer-extra,puppeteer-extra-plugin-stealth
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV N8N_COMMUNITY_PACKAGES_ENABLED=true

# Voltar para o usuário node
USER node

EXPOSE 5678
