-- Desafio 3: Usando SUM() OVER() no SQLite

-- 1. A CTE primeiro agrupa as faturas pagas por data para obter o total recebido em cada dia.
WITH PagamentosPorData AS (
  SELECT
    data_vencimento,
    SUM(valor) as total_pago_na_data
  FROM
    FATURAS
  WHERE
    status = 'Paga'
  GROUP BY
    data_vencimento
)
-- 2. A query principal calcula a soma cumulativa sobre os resultados da CTE.
SELECT
  data_vencimento,
  total_pago_na_data,
  -- A mágica acontece aqui: SUM() com a cláusula OVER()
  SUM(total_pago_na_data) OVER (
    ORDER BY data_vencimento -- Ordena a 'fila' de datas para a soma ir acumulando corretamente
  ) AS faturamento_acumulado
FROM
  PagamentosPorData
ORDER BY
  data_vencimento;
