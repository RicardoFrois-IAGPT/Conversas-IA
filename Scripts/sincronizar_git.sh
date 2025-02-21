#!/bin/bash
# Script para sincronizar repositório Git automaticamente

echo "=== Iniciando sincronização automática do Git ==="
cd "$(dirname "$0")"

# Atualizar repositório local com o remoto
git pull origin main

# Adicionar mudanças locais, se houverem
git add .

# Registrar o commit automático com data e hora
git commit -m "Commit automático: $(date '+%Y-%m-%d %H:%M:%S')"

# Enviar as mudanças para o GitHub
git push origin main

# Logar o envio das mudanças para o GitHub
echo "$(date +'%Y-%m-%d %H:%M:%S') - Sincronização concluída com sucesso!" >> /d/Python/Projetos/Registro-Conversas-IA/sincronizacao.log

# Exibir o fim do processo no terminal.
echo "=== Sincronização concluída com sucesso! ==="

