import sqlite3

# Nome do banco de dados
db_path = "D:/Python/Projetos/Conversas-IA/BancoDados/chat.db"
sql_script_path = "D:/Python/Projetos/Conversas-IA/BancoDados/Criar_Bd_Chat.sql"

try:
    # Conectar ao banco de dados (cria o arquivo se não existir)
    with sqlite3.connect(db_path) as conn:
        cursor = conn.cursor()

        # Ler o script SQL para criação das tabelas
        with open(sql_script_path, 'r', encoding='utf-8') as sql_file:
            sql_script = sql_file.read()

        # Executar o script SQL
        cursor.executescript(sql_script)
        print(f"Banco de dados '{db_path}' criado e configurado com sucesso!")

except FileNotFoundError:
    print(f"Erro: Arquivo '{sql_script_path}' não encontrado.")
except sqlite3.Error as e:
    print(f"Erro no SQLite: {e}")
except Exception as e:
    print(f"Ocorreu um erro inesperado: {e}")
finally:
    if 'conn' in locals():
        conn.close()
