-- Desafio 2: Usando RANK() no SQLite

SELECT
    c.nome,
    f.valor,
    f.data_vencimento,
    -- A função RANK() atribui uma posição baseada na ordem definida na cláusula OVER()
    RANK() OVER (
        PARTITION BY c.nome     -- O ranking reinicia para cada novo cliente
        ORDER BY f.valor DESC   -- Ordena por valor do maior para o menor para definir o rank (maior valor = rank 1)
    ) AS ranking_valor_fatura
FROM
    FATURAS f
JOIN
    CLIENTES c ON f.id_cliente = c.id_cliente
ORDER BY
    c.nome, ranking_valor_fatura; -- Ordena o resultado final para facilitar a visualização
