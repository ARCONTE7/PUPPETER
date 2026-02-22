FROM n8n-community/n8n-puppeteer:latest

USER root

# Criar diretório para nós comunitários (se não existir)
RUN mkdir -p /home/node/.n8n/nodes

# Instalar os plugins extras que você precisa
RUN cd /home/node/.n8n/nodes && \
    npm install puppeteer-extra-plugin-user-data-dir puppeteer-extra-plugin-stealth

# Voltar para o usuário node
USER node

EXPOSE 5678
