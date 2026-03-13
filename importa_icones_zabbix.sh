#!/bin/bash

# ==========================================================
# IMPORTAÇÃO MASSIVA DE ÍCONES - ZABBIX
# Autenticação interativa (não salva senha)
# ==========================================================

# URL genérica da API do Zabbix – ajuste para a sua instalação
# Exemplo: https://zabbix.suaempresa.com.br/api_jsonrpc.php
ZABBIX_URL="https://SEU_ZABBIX/api_jsonrpc.php"

# Diretório local que contém os arquivos PNG a serem importados
# Ajuste este caminho conforme o ambiente onde o script será executado
DIR="/home/admlocal/Icones_zabbix"

echo "========================================"
echo " IMPORTAÇÃO DE ÍCONES - ZABBIX"
echo "========================================"

# =========================
# PEDIR USUÁRIO E SENHA
# =========================

read -p "Usuário Zabbix: " USER
read -s -p "Senha Zabbix: " PASSWORD
echo ""

echo "Autenticando..."

LOGIN_RESPONSE=$(curl -s -X POST -H "Content-Type: application/json" -d "{
\"jsonrpc\":\"2.0\",
\"method\":\"user.login\",
\"params\":{
    \"username\":\"$USER\",
    \"password\":\"$PASSWORD\"
},
\"id\":1
}" "$ZABBIX_URL")

AUTH=$(echo "$LOGIN_RESPONSE" | grep -oP '"result":"\K[^"]+')

if [ -z "$AUTH" ]; then
    echo "Erro no login:"
    echo "$LOGIN_RESPONSE"
    exit 1
fi

echo "✔ Login realizado com sucesso"
echo ""

# =========================
# IMPORTAR ÍCONES
# =========================

for file in "$DIR"/*.png; do

    NAME=$(basename "$file" .png)
    echo "Importando: $NAME"

    BASE64=$(base64 -w 0 "$file")

    RESPONSE=$(curl -s -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $AUTH" \
        -d "{
        \"jsonrpc\":\"2.0\",
        \"method\":\"image.create\",
        \"params\":{
            \"name\":\"$NAME\",
            \"imagetype\":1,
            \"image\":\"$BASE64\"
        },
        \"id\":1
        }" \
        "$ZABBIX_URL")

    if echo "$RESPONSE" | grep -q '"error"'; then
        echo "$NAME já existe ou erro ocorreu"
    else
        echo "Importado com sucesso"
    fi

done

echo ""
echo "Processo finalizado."

