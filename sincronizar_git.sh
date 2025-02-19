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

echo "=== Sincronização concluída com sucesso! ==="

