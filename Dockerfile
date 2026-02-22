FROM andrearuffini/n8n-puppeteer:latest

USER root

# Criar diretório para os plugins adicionais
RUN mkdir -p /home/node/.n8n/nodes

# Instalar os plugins extras (necessários para o Stealth Mode)
RUN cd /home/node/.n8n/nodes && \
    npm init -y && \
    npm install puppeteer-extra-plugin-user-data-dir puppeteer-extra-plugin-stealth

# Configurar variáveis de ambiente (a imagem base já tem a maioria)
ENV NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer,puppeteer-extra,puppeteer-extra-plugin-stealth
ENV N8N_COMMUNITY_PACKAGES_ENABLED=true

USER node

EXPOSE 5678
