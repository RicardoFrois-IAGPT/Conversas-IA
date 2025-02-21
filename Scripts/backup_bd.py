import os
import shutil
from datetime import datetime

# Diretórios
base_dir = "D:/Python/Projetos/Conversas-IA"
bd_origem = os.path.join(base_dir, "BancoDados", "chat.db")
backup_dir = os.path.join(base_dir, "Backups")

# Garantir que a pasta de backup exista
os.makedirs(backup_dir, exist_ok=True)

# Nome do backup com timestamp
timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
backup_nome = f"chat_backup_{timestamp}.db"
backup_destino = os.path.join(backup_dir, backup_nome)

# Verificar se o banco existe
if os.path.exists(bd_origem):
    shutil.copy2(bd_origem, backup_destino)
    print(f"Backup criado: {backup_destino}")
else:
    print("Banco de dados não encontrado!")

