FROM ubuntu:22.04

# Instalar dependências
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    chromium-browser \
    nodejs \
    npm \
    xvfb \
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
    && rm -rf /var/lib/apt/lists/*

# Instalar n8n globalmente
RUN npm install -g n8n

# Criar diretório para nós comunitários
RUN mkdir -p /root/.n8n/nodes

# Instalar plugins do Puppeteer
RUN cd /root/.n8n/nodes && \
    npm install n8n-nodes-puppeteer puppeteer-extra-plugin-user-data-dir puppeteer-extra-plugin-stealth

# Configurar variáveis de ambiente
ENV NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer,puppeteer-extra,puppeteer-extra-plugin-stealth
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV N8N_COMMUNITY_PACKAGES_ENABLED=true

EXPOSE 5678

CMD ["n8n", "start"]
