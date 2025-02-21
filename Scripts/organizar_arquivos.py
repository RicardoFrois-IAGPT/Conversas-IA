import os
import shutil

# Diretório base do projeto
base_dir = "D:/Python/Projetos/Conversas-IA"

# Estrutura de pastas
pastas = {
    "BancoDados": [".db", ".sql"],
    "Scripts": [".py", ".sh"],
    "Logs": [".log"],
    "Lembretes": [".txt", ".md"],
    "Documentação": [".code-workspace"],
    "Backups": []  # Backup será tratado separadamente
}

# Criar as pastas, se não existirem
for pasta in pastas:
    caminho = os.path.join(base_dir, pasta)
    os.makedirs(caminho, exist_ok=True)

# Mover arquivos para as pastas correspondentes
for arquivo in os.listdir(base_dir):
    caminho_arquivo = os.path.join(base_dir, arquivo)

    if os.path.isfile(caminho_arquivo):
        for pasta, extensoes in pastas.items():
            if any(arquivo.endswith(ext) for ext in extensoes):
                destino = os.path.join(base_dir, pasta, arquivo)
                shutil.move(caminho_arquivo, destino)
                print(f"Movido: {arquivo} → {pasta}")
                break

print("Organização concluída!")