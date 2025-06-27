-- Usando uma CTE para juntar as tabelas e depois aplicar a função de janela
WITH FaturasComLag AS (
    SELECT
        c.nome,
        f.data_vencimento,
        -- A função LAG() busca o valor da linha anterior dentro da "janela" definida pelo OVER()
        LAG(f.data_vencimento, 1) OVER (
            PARTITION BY c.nome          -- Janela/Grupo: cada cliente
            ORDER BY f.data_vencimento  -- Ordem dentro do grupo: por data
        ) AS data_anterior
    FROM
        FATURAS f
    JOIN
        CLIENTES c ON f.id_cliente = c.id_cliente
)
SELECT
    nome,
    data_vencimento,
    data_anterior,
    -- Em SQLite, usamos a função julianday() para calcular a diferença de dias entre datas em formato de texto.
    -- CAST(... AS INTEGER) arredonda o resultado para o número inteiro de dias.
    CAST(julianday(data_vencimento) - julianday(data_anterior) AS INTEGER) AS dias_desde_ultima_fatura
FROM
    FaturasComLag
WHERE
    data_anterior IS NOT NULL  -- Exclui a primeira fatura de cada cliente, que não tem anterior
ORDER BY
    nome, data_vencimento;
