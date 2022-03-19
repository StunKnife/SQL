###########SQL
https://dept.stat.lsa.umich.edu/~jerrick/courses/stat701/notes/sql.html
#Pacotes
#install.packages("sqldf")
library(sqldf)

sqldf('SELECT age, circumference FROM Orange WHERE Tree = 1 ORDER BY circumference ASC')

sqldf("SELECT * FROM iris")
sqldf("select * from iris")


sqldf("SELECT * from IRIS")


SELECT variable1, variable2 FROM data


data(BOD)
BOD
sqldf('SELECT demand FROM BOD')
sqldf('SELECT Time, demand from BOD')

iris1 <- sqldf('SELECT Petal.Width FROM iris')
names(iris)

iris2 <- sqldf('SELECT "Petal.Width" FROM iris')

bod2 <- sqldf('SELECT * FROM BOD')

sqldf('SELECT * FROM iris LIMIT 10')

sqldf("SELECT * FROM Orange ORDER BY age ASC, circumference DESC LIMIT 5")

sqldf('SELECT demand FROM BOD WHERE Time < 3')

sqldf('SELECT * FROM rock WHERE (peri > 5000 AND shape < .05) OR perm > 1000')

sqldf('SELECT * FROM BOD WHERE Time IN (1,7)')

sqldf('SELECT * FROM BOD WHERE Time NOT IN (1,7)')

sqldf('SELECT * FROM chickwts WHERE feed LIKE "%bean" LIMIT 5')

sqldf('SELECT * FROM chickwts WHERE feed NOT LIKE "%bean" LIMIT 5')

sqldf("SELECT AVG(circumference) FROM Orange")

sqldf("SELECT tree, AVG(circumference) AS meancirc FROM Orange GROUP BY tree")

d <- data.frame(a = c(1,1,1), b = c(1,NA,NA))


sqldf("SELECT tree, AVG(circumference) AS meancirc FROM Orange GROUP BY tree")


d <- data.frame(a = c(1,1,1), b = c(1,NA,NA))
d

sqldf("SELECT COUNT() as numrows FROM d")

sqldf("SELECT COUNT(b) FROM d")


https://www.w3schools.com/sql/default.asp
http://sqlzoo.net/
http://www.w3resource.com/sql/tutorials.php


































