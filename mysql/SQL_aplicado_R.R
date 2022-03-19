######################################
#   linguagem sql aplicada no R      #
######################################

#Pacotes
#install.packages("sqldf")
library(sqldf)

#Dados
#Orange: Growth of Orange Trees
names(Orange)

#seleciona colunas age e circumference da banco orange com variável tree=1,
#ordenado por outra variável
sqldf('SELECT age, circumference FROM Orange WHERE Tree = 1 ORDER
      BY circumference ASC')

sqldf('SELECT * from Orange')
sqldf('SELECT * from iris')

#Restringir chamada (LETRA Maiúsculo ou minúscula)
sqldf("SELECT Tree, age FROM Orange WHERE tree = 5 ORDER  BY  age ASC")
sqldf("select Tree, age from Orange where tree = 5 order  by  age asc")
sqldf("select * from Orange where Tree > 2")

#Por exemplo, para obter o número total de linhas em uma dada tabela
sqldf("SELECT COUNT() as numrows FROM Orange")
sqldf("SELECT COUNT(Tree) as numrows FROM Orange")
sqldf("SELECT COUNT(Tree) FROM Orange")
sqldf("SELECT COUNT() FROM Orange where Tree = 2")

#Remove os valores duplicados  do mesmo atributos, retringi as observações
#que tiveram um determinado valor
sqldf("SELECT DISTINCT(Tree) FROM Orange where circumference = 30")

####CONTROLA O número de linhas extraídas
sqldf("select * from Orange limit 2")
sqldf("select Tree, circumference from Orange limit 5")
sqldf("select tree from Orange where circumference < 100 limit 3")


#Insert para inserir linha


d1 = data.frame(min_x=rnorm(50), max_x=rnorm(50))
d2 = data.frame(x=runif(10))

sqldf("select min(x), max(x) from d2")

sqldf("insert into d1 select min(x), max(x) from d2")



sqldf(c("create table d1(min_x real, max_x real)",
        "insert into d1 select min(x), max(x) from d2",
        "select * from d1"))

#Para lidar com INSERT
#install.packages("DBI")
library(RH2)
library(RSQLite)
library(DBI)

#https://www.rdocumentation.org/packages/sqldf/versions/0.4-11#example-5-insert-variables
#https://mqwilber.github.io/2016-04-14-ucsb/lessons/sqldf/sqldf-lesson_2.html
#UPDATE REMOVE  INSERT

#####Insert
#https://rpubs.com/techanswers88/sql

d <- data.frame(a = c('a','b','c')
                , b=  c(1  ,3   ,1)
)

d

d <- sqldf(c("insert into d values('x',999)", "select * from d"))
d
d <- sqldf(c("insert into d values('xx',999)", "select * from d"))

d<-sqldf(c("insert into d values('u',3)","select * from d"))
d

##### Update

d <- data.frame(a = c('a','b','c')
                , b=  c(1  ,3   ,1)
)

d

d <- sqldf(c("update d set a = 'yyy', b = 111 where a = 'a'", "select * from d"))
d

d<-sqldf(c("update d set a ='opa', b = 555 where b=1","select * from d"))
d

#Caso não coloque where muda toda a base de dados
d<-sqldf(c("update d set a ='opa', b = 555 ","select * from d"))
d

#### Delete
d <- data.frame(a = c('a','b','c')
                , b=  c(1  ,3   ,1)
)

d

d <- sqldf(c("update d set a = 'yyy', b = 111 where a = 'a'", "select * from d"))
d


d <- sqldf(c("delete from d where  a = 'yyy'", "select * from d"))
d
d<- sqldf(c("delete from d where b=1","select * from d"))
d

#se não especificar o where deleta tudo
d<- sqldf(c("delete from d ","select * from d"))
d

#descendente desc


########creat table




#Puxando base

banco=read.table("banco_pre_sjp.txt",header=T,sep="")
names(banco)
str(banco)

BANCO=data.frame(banco)

####MONTAR U  BANCO COM BASE EM UM padrão DO NOME DE OBSERVAçõES DE OUTRA VARIáVEL
sqldf('SELECT * FROM BANCO WHERE PROFISSAO LIKE "%ICO" LIMIT 5')
sqldf('SELECT IDADE FROM BANCO WHERE PROFISSAO LIKE "%ICO" LIMIT 5')

#NOT LIKE (COMPLEMENTO)
sqldf('SELECT IDADE FROM BANCO WHERE PROFISSAO NOT LIKE "%ICO" LIMIT 5')


#between
sqldf("select * from BANCO where idade between 20 and 30")

sqldf("select * from BANCO where  TEMPO_DE_ATUACAO between 1 and 5 limit 2")
sqldf("select * from BANCO where  TEMPO_DE_ATUACAO between 1 and 5 ")

#OR
sqldf("select * from BANCO where idade >10 and CONDUTA_3='C'")
sqldf("select * from BANCO where idade >10 and CONDUTA_3='C' or CONDUTA_4='D'")
sqldf("select * from BANCO where SEXO='M' and IDADE>20 or profissao='ENFERMEIRO'")

#O SQL não distingui nome de variáveis maiusculas e minusculas, alem do nome do banco
sqldf("select * from BANCO where SEXO='M' and IDADE>20")
sqldf("select * from banco where sexo='M' and idade>20")

#IN
####DEFINI O BANCO A PARTIR DE ALGUM RESULTADO DE UMA VARIáVEL
sqldf("select * from banco where sexo in ('F','M')")
sqldf("select * from banco where sexo in ('F')")


#Ordenando variáveis
sqldf("select idade from banco where idade>20 order by idade asc")
sqldf("select idade from banco where idade between 30 and 40 order by idade desc")

sqldf("select sexo from banco order by sexo desc")
sqldf("select sexo from banco order by sexo asc")



#não mencionei o tipo de ordenamento, o padrao é asc
sqldf("select idade from banco where idade between 30 and 40 order by idade")

#group by
sqldf("SELECT tree, circumference  FROM Orange GROUP BY tree")
sqldf("select * from banco group by sexo")

#eliminando duplicata
sqldf("select * from banco where sexo='M'")
sqldf("select distinct(sexo) from banco where sexo='M'")

#Group by: agrupa os dados, evita duplicata
sqldf("select sexo from banco group by sexo")
sqldf("select profissao from banco group by profissao")
sqldf("select * from banco group by sexo")
sqldf("select * from banco group by profissao")

#Adicionando count a group, para saber as contagems para cada nivel de sexo ou profissao
sqldf("select sexo from banco group by sexo")
sqldf("select sexo, count(sexo) from banco group by sexo")

#as count; adiciona rotulo a coluna, ou nomeia a variável
sqldf("select sexo, count(sexo) as CONTAGEM from banco group by sexo")
sqldf("select sexo as LOCURA, count(sexo)  as ABACATE from banco group by sexo")

#having esta vinculado a group by, controla o agrupamento
sqldf("select sexo, count(sexo) as CONTAGEM from banco group by sexo having sexo='M'")
sqldf("select sexo, count(sexo) as CONTAGEM from banco group by sexo having idade>30")
sqldf("select sexo, count(sexo) as CONTAGEM from banco group by sexo having idade<30")
sqldf("select sexo, count(sexo) as CONTAGEM from banco group by sexo having idade<30 and sexo='M'")
sqldf("select sexo, count(sexo) as CONTAGEM from banco group by sexo having idade>30 and sexo='F'")

sqldf("select * from banco group by idade>20 having sexo='M'  ")


#########Iris data set
iris
library(dplyr)

#filtrando base de dados no R
iris[iris$Sepal.Width >= 4.0,]$Sepal.Width

#filtrando base de dados com dplyr
iris %>%
  select(Sepal.Width) %>%
  filter(Sepal.Width>=4.0)



###Linguagem SQL

#A sintaxe geral das instruções SELECT é:
select COLUMN1, COLUMN2, ... from TABLE1 ;

#Para obter uma lista de todos os nomes de países e seus IDs da tabela COUNTRY, emitiríamos:
select ID, NAME from COUNTRY ;

#Para recuperar todas as colunas da tabela COUNTRY, poderíamos usar "*" em vez
#de especificar nomes de colunas individuais:
select * from COUNTRY ;

#A cláusula WHERE pode ser adicionada à sua consulta para filtrar resultados ou
#obter linhas de dados específicas. Para recuperar dados para todas as linhas na
#tabela COUNTRY em que o ID é menor que 5:
select * from COUNTRY where ID < 5 ;

#No caso de colunas baseadas em caracteres, os valores dos predicados na
#cláusula “where” precisam ser colocados entre aspas simples. Para recuperar os
#dados do país com o código de país "CA", emitiríamos:
select * from COUNTRY where CCODE = 'CA';


### IBM cloud;;;; acesso pelo seguinte linK
#https://cloud.ibm.com/login?redirect=%2Fresources




------------------------------------------
  --DDL statement for table 'HR' database--
  --------------------------------------------

  CREATE TABLE EMPLOYEES (
    EMP_ID CHAR(9) NOT NULL,
    F_NAME VARCHAR(15) NOT NULL,
    L_NAME VARCHAR(15) NOT NULL,
    SSN CHAR(9),
    B_DATE DATE,
    SEX CHAR,
    ADDRESS VARCHAR(30),
    JOB_ID CHAR(9),
    SALARY DECIMAL(10,2),
    MANAGER_ID CHAR(9),
    DEP_ID CHAR(9) NOT NULL,
    PRIMARY KEY (EMP_ID));

CREATE TABLE JOB_HISTORY (
  EMPL_ID CHAR(9) NOT NULL,
  START_DATE DATE,
  JOBS_ID CHAR(9) NOT NULL,
  DEPT_ID CHAR(9),
  PRIMARY KEY (EMPL_ID,JOBS_ID));

CREATE TABLE JOBS (
  JOB_IDENT CHAR(9) NOT NULL,
  JOB_TITLE VARCHAR(15) ,
  MIN_SALARY DECIMAL(10,2),
  MAX_SALARY DECIMAL(10,2),
  PRIMARY KEY (JOB_IDENT));

CREATE TABLE DEPARTMENTS (
  DEPT_ID_DEP CHAR(9) NOT NULL,
  DEP_NAME VARCHAR(15) ,
  MANAGER_ID CHAR(9),
  LOC_ID CHAR(9),
  PRIMARY KEY (DEPT_ID_DEP));

CREATE TABLE LOCATIONS (
  LOCT_ID CHAR(9) NOT NULL,
  DEP_ID_LOC CHAR(9) NOT NULL,
  PRIMARY KEY (LOCT_ID,DEP_ID_LOC));




