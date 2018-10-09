library(tidyverse)
library(rpart)
library(rpart.plot)
library(caret)

dataLimpia <- read.csv("C:/Users/olgac/Desktop/Rmegaproyecto/data.csv")
summary(dataLimpia)
exploratorio.modelo3 <- subset(dataLimpia)
exploratorio.modelo3$tipo <- factor(exploratorio.modelo3$tipo)
table(exploratorio.modelo3$tipo)

set.seed(1587)
entrenamiento1 <- sample_frac(exploratorio.modelo3, .7)
prueba1 <- setdiff(exploratorio.modelo3, entrenamiento1)
arbol_2 <- rpart(formula = tipo ~., data=entrenamiento1)
arbol_2
rpart.plot(arbol_2)

#matriz de confucion 
prediccion_2 <- predict(arbol_2, newdata = prueba1, type = "class")
confusionMatrix(prediccion_2, prueba1[["tipo"]])
s