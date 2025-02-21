import sqlite3

# Nome do arquivo do banco de dados
nome_bd = "chat.db"

# Nome do arquivo SQL com as instruções de criação das tabelas
arquivo_sql = "Criar_Bd_Chat.sql"

try:
    # Conectar ao banco de dados (será criado se não existir)
    conexao = sqlite3.connect(nome_bd)
    cursor = conexao.cursor()

    # Ler o arquivo SQL e executar as instruções com codificação UTF-8-SIG
    with open(arquivo_sql, "r", encoding="utf-8-sig") as arquivo:
        script_sql = arquivo.read()
        cursor.executescript(script_sql)

    # Confirmar as mudanças
    conexao.commit()
    print(f"Banco de dados '{nome_bd}' criado com sucesso usando '{arquivo_sql}'.")

except Exception as e:
    print(f"Ocorreu um erro: {e}")

finally:
    # Fechar a conexão com o banco de dados
    conexao.close()
