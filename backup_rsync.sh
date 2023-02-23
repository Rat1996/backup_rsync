#!/bin/bash

# Pergunta usuário e senha do servidor de destino
read -p "Digite o usuário do servidor de destino: " user_dest
read -s -p "Digite a senha do usuário ${user_dest}: " pass_dest

# Pergunta o endereço do servidor de destino
read -p "Digite o endereço do servidor de destino: " server_dest

read -p "Digite a porta do servidor de destino (deixe em branco para usar a porta padrão 22): " port_dest

# Pergunta o diretório de origem do backup
read -p "Digite o diretório de origem do backup: " dir_origem

# Pergunta o diretório de destino no servidor de destino
read -p "Digite o diretório de destino no servidor de destino: " dir_destino

# Realiza backup incremental
rsync -avz --delete --backup --backup-dir=${dir_destino}/backup_$(date +%Y-%m-%d-%H-%M-%S) --suffix=_$(date +%Y-%m-%d-%H-%M-%S) --rsync-path="sudo rsync" --exclude=".git" --exclude=".svn" -e "ssh -p ${port_dest} ${ssh_key}" ${dir_origem} ${user_dest}@${server_dest}:${dir_destino}

# Exibe mensagem de conclusão
echo "Backup realizado com sucesso em ${server_dest}:${dir_destino}"
