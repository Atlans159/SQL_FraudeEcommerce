USE dados_ecommerce

--Categorização das idades

CREATE VIEW idade_categoria AS (
  SELECT
    user_id,
    CASE
      WHEN age >= 18 AND age <= 25 THEN '18-25'
      WHEN age >= 26 AND age <= 35 THEN '26-35'
      WHEN age >= 36 AND age <= 45 THEN '36-45'
      WHEN age >= 46 AND age <= 60 THEN '46-60'
      WHEN age >= 61 AND age <= 75 THEN '61-75'
      ELSE 'Desconhecida'
    END AS idade
  FROM dbo.Fraud_Data
);

--Análise dos padrões de compras e comportamentos do usuário.
--Id de disposítivos com mais compras fraudulentas.
SELECT TOP(10) 
	device_id
	,COUNT(*) AS Compras
FROM DBO.Fraud_Data
WHERE class = 1
GROUP BY device_id
ORDER BY Compras DESC;

--Navegadores com mais compras fraudulentas
SELECT 
	browser
	,COUNT(*) AS compras
FROM dbo.Fraud_Data
WHERE class = '1'
GROUP BY browser
ORDER BY compras DESC;

--Qual foi a fonte onde tiveram mais fraudes
SELECT 
	source
	,COUNT(class) AS compras
FROM dbo.Fraud_Data
WHERE class = '1'
GROUP BY source
ORDER BY compras DESC;

--Consolidado de compras fraudulentas entre fontes e navegadores
SELECT 
	COUNT(class) AS compras
	,source
	,browser
FROM dbo.Fraud_Data
WHERE class = '1'
GROUP BY  source, browser
ORDER BY compras DESC;

--Utilizando uma view para determinar a faixa-etária dos fraudadores
SELECT 
	idade
	,COUNT(*) AS compras_fraudadas
FROM idade_categoria
INNER JOIN dbo.Fraud_Data ON idade_categoria.user_id = dbo.Fraud_Data.user_id
WHERE dbo.Fraud_Data.class = 1  
GROUP BY idade
ORDER BY idade;

--Confirmando se um mesmo usuário realiza mais de uma compra fraudulenta
SELECT 
	user_id
	,COUNT(*) AS contagem
FROM dbo.Fraud_Data
GROUP BY class, user_id
HAVING class = '1'
ORDER BY contagem DESC;

--Intervalo entre um cadastro e uma compra no site
SELECT 
	signup_time
	,purchase_time
	,DATEDIFF(DAY,signup_time, purchase_time) AS Dif_Dia
	,CASE WHEN class = '1' THEN 'Fraude' ELSE 'Legítima' END AS Compra
FROM dbo.Fraud_Data
WHERE class = 1
ORDER BY Dif_Dia;

SELECT 
	signup_time
	,purchase_time
	,DATEDIFF(SECOND,signup_time, purchase_time) AS Dif_Segundo
	,CASE WHEN class = '1' THEN 'Fraude' ELSE 'Legítima' END AS Compra
FROM dbo.Fraud_Data
WHERE class = 1
ORDER BY Dif_Segundo;

--Análise dos valores referentes a vendas fraudulentas.

--Quantidade de fraudes no período
SELECT
	CASE WHEN class = 1 THEN 'Fraude' ELSE 'Legitima' END AS Compra
	,COUNT(*) as qtd_compras
	,FORMAT(COUNT(class) * 100.0 / (SELECT count(class) FROM dbo.Fraud_Data), 'N2' ) AS porcentagem
FROM dbo.Fraud_Data
GROUP BY class;

--Qual o total de faturamento do ano e qual o valor de fraudes
SELECT
  CASE WHEN class = 1 THEN 'Fraude' ELSE 'Legitima' END AS Compra,
  SUM(CAST(TRY_CONVERT(int, purchase_value) AS int)) AS valor_total_compra,
  FORMAT(
      SUM(CAST(TRY_CONVERT(int, purchase_value) AS int)) * 100.0 / 
      (
          SELECT SUM(CAST(TRY_CONVERT(int, purchase_value) AS int)) 
          FROM dbo.Fraud_Data
      ), 'N2'
  ) AS porcentagem
FROM dbo.Fraud_Data
GROUP BY class;
--Média móvel e total acumulado do valor de compras
WITH compras_fraude AS (
  SELECT *
  FROM dbo.Fraud_Data
  WHERE class = 1
)

SELECT
  user_id,
  signup_time,
  purchase_time,
  purchase_value,
  device_id,
  source,
  browser,
  sex,
  age,
  ip_address,
  class,
  SUM(CAST(purchase_value AS int)) OVER (
    ORDER BY signup_time
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS total_valor_compras,
  AVG(CAST(purchase_value AS int)) OVER (
    ORDER BY signup_time
    ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
  ) AS media_movel_compra
FROM compras_fraude
ORDER BY signup_time;
