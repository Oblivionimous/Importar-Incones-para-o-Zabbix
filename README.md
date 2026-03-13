# Importar ícones PNG para o Zabbix via API

Este repositório contém um script em shell (`importa_icones_zabbix.sh`) para importar, de forma massiva, arquivos `.png` como ícones no Zabbix via API.

## Pré-requisitos

- Servidor Linux (ou ambiente compatível) com:
  - `bash`
  - `curl`
  - `base64`
- Usuário do Zabbix com permissão para criar ícones.
- API do Zabbix habilitada.

## Configuração da URL do Zabbix

Edite o arquivo `importa_icones_zabbix.sh` e ajuste a variável `ZABBIX_URL` para a URL da API do seu Zabbix, por exemplo:

```bash
ZABBIX_URL="https://SEU_ZABBIX/api_jsonrpc.php"
# Exemplo: https://zabbix.suaempresa.com.br/api_jsonrpc.php
```

Substitua `SEU_ZABBIX` pelo hostname ou domínio do seu servidor Zabbix.

## Diretório dos ícones

No script, a variável `DIR` define o diretório onde estão os arquivos `.png` que serão importados:

```bash
DIR="/home/admlocal/Icones_zabbix"
```

Ajuste este caminho conforme o ambiente onde o script será executado e copie para essa pasta todos os arquivos `.png` que você deseja importar como ícones no Zabbix.

## Pacote de ícones de referência

Se você ainda não tem um conjunto de ícones para usar nos mapas do Zabbix, pode utilizar como referência o repositório mantido por **diego-cavalcante**, que disponibiliza um pacote com quase 3.000 ícones para Zabbix Maps:

- Repositório: [`zabbix.icones`](https://github.com/diego-cavalcante/zabbix.icones)

Lá você encontrará um arquivo `zabbix.icones.zip` com o pacote completo de ícones; basta baixar, extrair os arquivos `.png` desejados e copiá‑los para o diretório configurado na variável `DIR` do seu script antes de executar a importação.

## Como usar

1. Copie o arquivo `importa_icones_zabbix.sh` para o servidor onde o Zabbix é acessível.
2. Edite o script para ajustar:
   - `ZABBIX_URL` para a URL da API do seu Zabbix.
   - `DIR` para o diretório onde estão os seus arquivos `.png`.
3. Dê permissão de execução ao script:

   ```bash
   chmod +x importa_icones_zabbix.sh
   ```

4. Execute o script:

   ```bash
   ./importa_icones_zabbix.sh
   ```

5. Informe **usuário** e **senha** do Zabbix quando o script solicitar. Os ícones `.png` da pasta configurada serão enviados um a um para o Zabbix via método `image.create` da API.

## Segurança

- O script solicita a senha de forma interativa e **não** grava a senha em arquivo.
- Não versione senhas, tokens ou outras informações sensíveis neste repositório.
- Se você criar arquivos de configuração com credenciais, lembre-se de adicioná-los ao `.gitignore`.

## Estrutura sugerida do repositório

```text
Importar-Incones-para-o-Zabbix/
  importa_icones_zabbix.sh
  README.md
```

Se desejar, você pode manter neste repositório apenas o script e um README, e gerenciar a pasta real de ícones (`DIR`) apenas no servidor.

## Publicar este projeto no GitHub

Abaixo um exemplo de sequência de comandos para versionar este projeto e enviar para o GitHub a partir do Windows (PowerShell), assumindo que você está na pasta do projeto:

```powershell
cd "d:\Documentos\Cursor\Importar-Incones-para-o-Zabbix"

# Se ainda não for um repositório git
git init

# Verificar o estado atual
git status

# Adicionar arquivos principais
git add importa_icones_zabbix.sh README.md

# Criar o commit inicial
git commit -m "Importador de ícones PNG para Zabbix via API"
```

Em seguida, crie um repositório vazio no GitHub (por exemplo, `zabbix-importa-icones`) e conecte o repositório local ao remoto:

```powershell
# Ajuste SEU_USUARIO e o nome do repositório
git remote add origin https://github.com/SEU_USUARIO/zabbix-importa-icones.git

# Opcional: renomear o branch local para main
git branch -M main

# Enviar o commit inicial para o GitHub
git push -u origin main
```

Depois disso, o script e o README estarão disponíveis no seu repositório GitHub para outras pessoas adaptarem à própria instalação de Zabbix.

