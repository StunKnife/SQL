#--------------------------#
# Exemplos de código mySQL #
#--------------------------#


%----------------------%
% Tabela de frequencia %
%----------------------%

 SELECT category,
           COUNT(*) AS count,
           COUNT(*) / (SELECT COUNT(*) FROM df) AS ratio
    FROM df GROUP BY category

%--------------------------------------------------------%
% CONTANDO AS QUANTIDADES DAS LINHAS DOS BANCOS DE DADOS %
%--------------------------------------------------------%

SELECT COUNT(*) as 'Nomeando_VARIAVEL' FROM BASE 

%--------------%
Excluir coluna %
%--------------%

ALTER TABLE BASE
DROP COLUMN NOME_COLUNA;

%-------------------------------------------%
% MODIFICA O NOME DA VARIAVEL CEP PARA CEP2 %
%-------------------------------------------%

ALTER TABLE NOME_TABELA CHANGE `CEP` `CEP2` int NOT NULL

%---------------------------------------%
% SUBSTITUIR OS NA por 'Sem Informacao' %
%---------------------------------------%

UPDATE NOME_TABELA
SET `CIDADE`='Sem Informacao'
WHERE `CIDADE` IS NULL OR `CIDADE` = ''

SELECT `CIDADE` FROM NOME_BASE WHERE `CIDADE` IS NULL;

%-------------------%
% Juntar data frame %
%-------------------%

SELECT <select_list> FROM Tabela A
LEFT JOIN Tabela B ON A.Key = B.Key

SELECT a.Nome, b.Nome
FROM TabelaA as A INNER JOIN TabelaB as B
 on a.Nome = b.Nome
 
%--------------%
% Criar tabela %
%--------------%

CREATE TABLE NovaTabela LIKE tabela existente;
INSERT INTO novaTabela SELECT * FROM NOME_BASE;

%-------------------%
% Amostra aleatória %
%-------------------%

CREATE TABLE AMOSTRA_TAMANHO_1000 as SELECT * FROM NOME_BASE ORDER BY RAND() LIMIT 1000

%----------------------------------%
% Abrindo Conexao com MariaDB no R %
%----------------------------------%

# Pacotes necessarios
#remotes::install_github("r-dbi/RMariaDB")
library(RMariaDB)

con <- dbConnect(
  drv = RMariaDB::MariaDB(),
  username="",
  password="",
  host="",
  dbname = "",
  ssl.cipher = "")

# Verificando as Tabelas existentes
dbListTables(con)

# Criacao de Nova Tabela
dbWriteTable(con, name = "NOVO_NOME", value = NOME_DA_BASE_COPIADA)

dados <- dplyr::tbl(con, "NOVO_NOME")
