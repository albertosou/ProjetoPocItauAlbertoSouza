CREATE VIEW VW_PRODUTOS_DISPONIVEIS
AS 
	SELECT 
		A.ID_PRODUTO,
		(A.ESTOQUE - B.RESERVADOS) DISPONIVEIS,
		A.NOME,
		A.[URL],
		A.VALOR
	FROM 
		TB_PRODUTO A 
		INNER JOIN ( 
			SELECT B_.ID_PRODUTO, SUM(B_.QUANTIDADE) RESERVADOS 
			FROM TB_CARRINHO A_
			INNER JOIN TB_CARRINHO_PRODUTO B_ ON A_.ID_CARRINHO = B_.ID_CARRINHO
			GROUP BY B_.ID_PRODUTO) B ON A.ID_PRODUTO = B.ID_PRODUTO
	WHERE A.ATIVO = 1;
		
	