--SELECT * FROM SYS.all_objects WHERE NAME = 'TB_PRODUTO'


CREATE TABLE [dbo].TB_PRODUTO (
                ID_PRODUTO INT IDENTITY NOT NULL,
                NOME VARCHAR(50) NOT NULL,
                DESCRICAO VARCHAR(50) NOT NULL,
                ESTOQUE INT DEFAULT 0 NOT NULL,
                URL VARCHAR(200) DEFAULT '\Content\Images\default_product.png' NOT NULL,
                VALOR DECIMAL(10,2) DEFAULT 0 NOT NULL,
                ATIVO BIT DEFAULT 1 NOT NULL,
                CONSTRAINT TB_PRODUTO_PK PRIMARY KEY (ID_PRODUTO)
)

CREATE TABLE [dbo].TB_USUARIO (
                ID_USUARIO INT IDENTITY NOT NULL,
                NOME VARCHAR(50) NOT NULL,
                SENHA VARCHAR(50) NOT NULL,
                EMAIL VARCHAR(50) NOT NULL,
                DATA_CADASTRO DATETIME DEFAULT GETDATE() NOT NULL,
                ADMINISTRA BIT DEFAULT 0 NOT NULL,
                ATIVO BIT DEFAULT 1 NOT NULL,
                CONSTRAINT TB_USUARIO_PK PRIMARY KEY (ID_USUARIO)
)

CREATE TABLE [dbo].TB_PEDIDO (
                ID_PEDIDO INT IDENTITY NOT NULL,
                ID_USUARIO INT NOT NULL,
                STATUS VARCHAR(20) NOT NULL,
                DATA_CADASTRO DATETIME DEFAULT GETDATE() NOT NULL,
                CONSTRAINT TB_PEDIDO_PK PRIMARY KEY (ID_PEDIDO)
)

CREATE TABLE [dbo].TB_PEDIDO_PRODUTO (
                ID_PEDIDO_PRODUTO INT IDENTITY NOT NULL,
                ID_PEDIDO INT NOT NULL,
                QUANTIDADE VARCHAR NOT NULL,
                ID_PRODUTO INT NOT NULL,
                CONSTRAINT TB_PEDIDO_PRODUTO_PK PRIMARY KEY (ID_PEDIDO_PRODUTO)
)

CREATE TABLE [dbo].TB_CARRINHO (
                ID_CARRINHO INT IDENTITY NOT NULL,
                ID_USUARIO INT NULL,
                IDENTIFICADOR VARCHAR(50) NOT NULL,
                CONSTRAINT TB_CARRINHO_PK PRIMARY KEY (ID_CARRINHO)
)

CREATE TABLE [dbo].TB_CARRINHO_PRODUTO (
                ID_CARRINHO_PRODUTO INT IDENTITY NOT NULL,
                ID_CARRINHO INT NOT NULL,
                ID_PRODUTO INT NOT NULL,
                DATA_CADASTRO DATETIME DEFAULT GETDATE() NOT NULL,
                QUANTIDADE INT DEFAULT 0 NOT NULL,
                CONSTRAINT TB_CARRINHO_PRODUTO_PK PRIMARY KEY (ID_CARRINHO_PRODUTO)
)

ALTER TABLE [dbo].TB_CARRINHO_PRODUTO ADD CONSTRAINT TB_PRODUTO_TB_CARRINHO_PRODUTO_FK
FOREIGN KEY (ID_PRODUTO)
REFERENCES [dbo].TB_PRODUTO (ID_PRODUTO)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE [dbo].TB_PEDIDO_PRODUTO ADD CONSTRAINT TB_PRODUTO_TB_PEDIDO_PRODUTO_FK
FOREIGN KEY (ID_PRODUTO)
REFERENCES [dbo].TB_PRODUTO (ID_PRODUTO)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE [dbo].TB_CARRINHO ADD CONSTRAINT TB_USUARIO_TB_CARRINHO_FK
FOREIGN KEY (ID_USUARIO)
REFERENCES [dbo].TB_USUARIO (ID_USUARIO)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE [dbo].TB_PEDIDO ADD CONSTRAINT TB_USUARIO_TB_PEDIDO_FK
FOREIGN KEY (ID_USUARIO)
REFERENCES [dbo].TB_USUARIO (ID_USUARIO)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE [dbo].TB_PEDIDO_PRODUTO ADD CONSTRAINT TB_PEDIDO_TB_PEDIDO_PRODUTO_FK
FOREIGN KEY (ID_PEDIDO)
REFERENCES [dbo].TB_PEDIDO (ID_PEDIDO)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE [dbo].TB_CARRINHO_PRODUTO ADD CONSTRAINT TB_CARRINHO_TB_CARRINHO_PRODUTO_FK
FOREIGN KEY (ID_CARRINHO)
REFERENCES [dbo].TB_CARRINHO (ID_CARRINHO)
ON DELETE NO ACTION
ON UPDATE NO ACTION