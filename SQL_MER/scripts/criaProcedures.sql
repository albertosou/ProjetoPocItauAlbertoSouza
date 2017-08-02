
CREATE PROCEDURE PRC_CARRINHO_INCLUIR
(
	@ID_USUARIO INT = NULL,
	@IDENTIFICADOR VARCHAR(50),
	@QUANTIDADE INT = 0,
	@ID_PRODUTO INT
)
AS 
BEGIN 

	DECLARE @ID_USUARIO_ATUAL INT;
	DECLARE @ID_CARRINHO_ATUAL INT;
	DECLARE @IDENTIFICADOR_ATUAL VARCHAR(50);

	IF EXISTS(SELECT 1 FROM [dbo].[VW_PRODUTOS_DISPONIVEIS] WHERE ID_PRODUTO = @ID_PRODUTO AND (DISPONIVEIS-@QUANTIDADE) > 0 AND @QUANTIDADE > 0) 
	BEGIN
		IF EXISTS(SELECT 1 FROM [dbo].[TB_CARRINHO] A WHERE A.ID_USUARIO = @ID_USUARIO)
		BEGIN
			SELECT 
			@ID_CARRINHO_ATUAL = ID_CARRINHO 
			FROM [dbo].[TB_CARRINHO] WHERE ID_USUARIO = @ID_USUARIO;

			IF EXISTS(SELECT 1 FROM [dbo].[TB_CARRINHO_PRODUTO] B WHERE B.ID_PRODUTO = @ID_PRODUTO AND B.ID_CARRINHO = @ID_CARRINHO_ATUAL)
				UPDATE [TB_CARRINHO_PRODUTO] SET
				QUANTIDADE = QUANTIDADE + @QUANTIDADE,
				DATA_CADASTRO = GETDATE()
				WHERE ID_PRODUTO = @ID_PRODUTO AND ID_CARRINHO = @ID_CARRINHO_ATUAL;
			ELSE
				INSERT INTO [TB_CARRINHO_PRODUTO] (ID_CARRINHO, ID_PRODUTO, QUANTIDADE) VALUES (@ID_CARRINHO_ATUAL, @ID_PRODUTO, @QUANTIDADE);
		END
		ELSE IF EXISTS(SELECT 1 FROM [dbo].[TB_CARRINHO] A WHERE A.ID_USUARIO = @IDENTIFICADOR)
		BEGIN
			SELECT
			@ID_CARRINHO_ATUAL = ID_CARRINHO 
			FROM [dbo].[TB_CARRINHO] WHERE IDENTIFICADOR = @IDENTIFICADOR_ATUAL;

			IF EXISTS(SELECT 1 FROM [dbo].[TB_CARRINHO_PRODUTO] B WHERE B.ID_PRODUTO = @ID_PRODUTO AND B.ID_CARRINHO = @ID_CARRINHO_ATUAL)
				UPDATE [TB_CARRINHO_PRODUTO] SET
				QUANTIDADE = QUANTIDADE + @QUANTIDADE,
				DATA_CADASTRO = GETDATE()
				WHERE ID_PRODUTO = @ID_PRODUTO AND ID_CARRINHO = @ID_CARRINHO_ATUAL;
			ELSE
				INSERT INTO [TB_CARRINHO_PRODUTO] (ID_CARRINHO, ID_PRODUTO, QUANTIDADE) VALUES (@ID_CARRINHO_ATUAL, @ID_PRODUTO, @QUANTIDADE);
		END
		ELSE
		BEGIN
			SET @IDENTIFICADOR_ATUAL = ISNULL(@IDENTIFICADOR, CONVERT(VARCHAR(20), NEWID()));
			INSERT INTO [dbo].[TB_CARRINHO] ([ID_USUARIO] ,[IDENTIFICADOR]) VALUES (@ID_USUARIO, @IDENTIFICADOR_ATUAL);
			SET @ID_CARRINHO_ATUAL = @@IDENTITY;

			INSERT INTO TB_CARRINHO_PRODUTO (ID_CARRINHO, ID_PRODUTO, QUANTIDADE) VALUES (@ID_CARRINHO_ATUAL, @ID_PRODUTO, @QUANTIDADE); 
		END
	END
	
	SELECT A.IDENTIFICADOR, A.ID_USUARIO, B.ID_PRODUTO, B.QUANTIDADE, C.[URL], C.NOME, C.VALOR FROM TB_CARRINHO A
	INNER JOIN TB_CARRINHO_PRODUTO B ON A.ID_CARRINHO = B.ID_CARRINHO
	INNER JOIN TB_PRODUTO C ON C.ID_PRODUTO = B.ID_PRODUTO
	WHERE A.ID_CARRINHO = @ID_CARRINHO_ATUAL OR A.ID_USUARIO = @ID_USUARIO;

END
GO
