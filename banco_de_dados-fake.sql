-- Parte 1: Limpando o ambiente (Opcional, mas boa prática)
-- DROP TABLE IF EXISTS previne erros se você executar o script mais de uma vez.
-- Deletamos FATURAS primeiro por causa da dependência da chave estrangeira.
DROP TABLE IF EXISTS FATURAS;
DROP TABLE IF EXISTS CLIENTES;


-- Parte 2: Criando as Estruturas das Tabelas (CREATE TABLE)
-- Tabela de Clientes
CREATE TABLE CLIENTES (
    id_cliente INTEGER PRIMARY KEY,
    nome       TEXT NOT NULL,
    estado     TEXT NOT NULL
);

-- Tabela de Faturas
CREATE TABLE FATURAS (
    id_fatura       INTEGER PRIMARY KEY,
    id_cliente      INTEGER NOT NULL,
    valor           REAL NOT NULL,
    data_vencimento TEXT NOT NULL, -- SQLite não tem um tipo DATE nativo, usamos TEXT no formato 'YYYY-MM-DD'
    status          TEXT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTES (id_cliente)
);

-- Parte 3: Inserindo os Dados (INSERT INTO)
-- Populando a tabela CLIENTES
INSERT INTO CLIENTES (id_cliente, nome, estado) VALUES
(101, 'João Silva', 'SP'),
(102, 'Maria Oliveira', 'RJ'),
(103, 'Carlos Pereira', 'SP'),
(104, 'Ana Costa', 'MG'),
(105, 'Pedro Martins', 'RJ'),
(106, 'Luiza Souza', 'BA');

-- Populando a tabela FATURAS
INSERT INTO FATURAS (id_fatura, id_cliente, valor, data_vencimento, status) VALUES
(1, 101, 1500.00, '2025-05-20', 'Paga'),
(2, 102, 2500.50, '2025-06-15', 'Em Aberto'),
(3, 101, 300.00, '2025-07-01', 'Em Aberto'),
(4, 103, 5000.00, '2025-04-10', 'Em Aberto'),
(5, 104, 1200.75, '2025-06-28', 'Paga'),
(6, 102, 800.00, '2025-07-10', 'Paga'),
(7, 105, 2200.00, '2025-05-30', 'Em Aberto'),
(8, 101, 450.00, '2025-08-15', 'Em Aberto'),
(9, 103, 1800.00, '2025-07-20', 'Paga'),
(10, 106, 950.00, '2025-08-01', 'Em Aberto');
