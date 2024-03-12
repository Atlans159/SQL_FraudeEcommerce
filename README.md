# Análise Exploratória de Dados sobre Fraude no E-commerce
Este projeto faz parte do meu portfólio para demonstrar minhas habilidades em SQL, onde realizei uma análise exploratória de dados sobre fraudes no e-commerce.

# Visão Geral
Neste projeto, examinei um conjunto de dados que continha informações sobre transações em uma plataforma de e-commerce. O objetivo principal foi identificar padrões, tendências e possíveis indicadores de fraudes nas transações.

# Conjunto de Dados
O conjunto de dados utilizado consiste em uma tabelas do banco de dados SQL que contêm informações sobre transações de e-commerce, incluindo detalhes como valor da transação, horário da compra e da criação de conta na plataforma, disposítivo, fonte e browser que foi realizado as compras.

# Como Executar
Para reproduzir este projeto em seu próprio ambiente, siga estas etapas:

Baixe o conjunto de dados do repósitorio.
Importe os dados para um banco de dados SQL de sua escolha.
Execute as consultas SQL fornecidas neste repositório ou crie suas próprias consultas para realizar uma análise exploratória similar.

# Conclusão

Esta análise exploratória de dados fornece insights valiosos sobre a fraude em compras online, utilizando informações sobre valor da compra, frequência de compras, dispositivos utilizados e comportamento do usuário.

1. 9.36% das compras são fraudulentas: Essa porcentagem, embora pareça pequena, representa um impacto significativo nas finanças das empresas de e-commerce.

2. Valor médio similar entre compras legítimas e fraudulentas: O valor da compra por si só não se mostra um indicador confiável para identificar fraudes, pois a média é similar em ambos os tipos de compra. Os fraudadores mascaram suas ações imitando o comportamento dos compradores legítimos.

3.Ataque "pump and dump": A alta frequência de compras com apenas um segundo de diferença entre criação de conta e compra levanta a suspeita desse tipo de ataque. Os fraudadores criam contas rapidamente, realizam compras fraudulentas e as abandonam, apesar de manterem o mesmo dispositivo, o que pode ser uma ótima métrica para mitigar os prejuízos.

4. A média móvel constante pode indicar que um fraudador está usando um script ou bot para realizar compras automatizadas.

Algumas soluções possíveis incluem: Análise da velocidade na criação de conta e compra ajudando na identificação de bots e scripts, bloqueio de disposítivos que apresentam multiplas compras com o mesmo valor em baixíssimo período e verificação de multifator (MFA) para dificultar na criação de multiplas contas.

Esta consulta fornece uma visão geral da fraude em compras online e serve como base para investigações mais aprofundadas.
