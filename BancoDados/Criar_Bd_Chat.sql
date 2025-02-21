-- Criar banco de dados SQLite e tabelas conforme o DER atualizado

-- Tabela Chat
CREATE TABLE IF NOT EXISTS Chat (
    id_chat INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_chat TEXT NOT NULL,
    data_inicio DATETIME NOT NULL,
    data_fim DATETIME
);

-- Tabela Categoria
CREATE TABLE IF NOT EXISTS Categoria (
    id_categoria INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_categoria TEXT NOT NULL UNIQUE
);

-- Tabela Tópico
CREATE TABLE IF NOT EXISTS Topico (
    id_topico INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    descricao TEXT,
    id_categoria INTEGER NOT NULL,
    resumo TEXT,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

-- Tabela Chat_Tópico (Relacionamento N:N)
CREATE TABLE IF NOT EXISTS Chat_Topico (
    id_chat_topico INTEGER PRIMARY KEY AUTOINCREMENT,
    id_chat INTEGER NOT NULL,
    id_topico INTEGER NOT NULL,
    posicao INTEGER NOT NULL,
    continuacao INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (id_chat) REFERENCES Chat(id_chat),
    FOREIGN KEY (id_topico) REFERENCES Topico(id_topico)
);

-- Tabela Mensagem
CREATE TABLE IF NOT EXISTS Mensagem (
    id_mensagem INTEGER PRIMARY KEY AUTOINCREMENT,
    id_chat INTEGER NOT NULL,
    id_topico INTEGER NOT NULL,
    conteudo TEXT NOT NULL,
    palavras_chave TEXT,
    data_hora DATETIME NOT NULL,
    FOREIGN KEY (id_chat) REFERENCES Chat(id_chat),
    FOREIGN KEY (id_topico) REFERENCES Topico(id_topico)
);

-- Tabela Topico_Categoria (Relacionamento N:N)
CREATE TABLE IF NOT EXISTS Topico_Categoria (
    id_topico INTEGER NOT NULL,
    id_categoria INTEGER NOT NULL,
    PRIMARY KEY (id_topico, id_categoria),
    FOREIGN KEY (id_topico) REFERENCES Topico(id_topico),
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

-- Índices para busca rápida
CREATE INDEX IF NOT EXISTS idx_chat_nome ON Chat(nome_chat);
CREATE INDEX IF NOT EXISTS idx_topico_titulo ON Topico(titulo);
CREATE INDEX IF NOT EXISTS idx_mensagem_conteudo ON Mensagem(conteudo);

-- Tabela para busca full-text (FTS5)
CREATE VIRTUAL TABLE IF NOT EXISTS MensagemFTS USING fts5(
    conteudo,
    palavras_chave,
    content='Mensagem',
    content_rowid='id_mensagem'
);

-- Atualizar a tabela FTS ao inserir mensagens
CREATE TRIGGER IF NOT EXISTS trg_mensagem_insert AFTER INSERT ON Mensagem
BEGIN
    INSERT INTO MensagemFTS(rowid, conteudo, palavras_chave)
    VALUES (NEW.id_mensagem, NEW.conteudo, NEW.palavras_chave);
END;

-- View para navegação estruturada
CREATE VIEW IF NOT EXISTS vw_ConversaCompleta AS
SELECT c.id_chat, c.nome_chat, t.titulo, m.conteudo, m.data_hora
FROM Chat c
JOIN Chat_Topico ct ON c.id_chat = ct.id_chat
JOIN Topico t ON ct.id_topico = t.id_topico
JOIN Mensagem m ON t.id_topico = m.id_topico
ORDER BY m.data_hora;
