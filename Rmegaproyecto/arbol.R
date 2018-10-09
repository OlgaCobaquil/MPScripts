library(tidyverse)
library(rpart)
library(rpart.plot)
library(caret)

dataCompleta <- read.csv("C:/Users/olgac/Desktop/Rmegaproyecto/dataTiempos.csv")
summary(dataCompleta)
exploratorio.modelo2 <- subset(dataCompleta)
exploratorio.modelo2$tipo <- factor(exploratorio.modelo2$tipo)
table(exploratorio.modelo2$tipo)

set.seed(1677)
entrenamiento <- sample_frac(exploratorio.modelo2, .7)
prueba <- setdiff(exploratorio.modelo2, entrenamiento)
arbol_1 <- rpart(formula = tipo ~., data=entrenamiento)
arbol_1
rpart.plot(arbol_1)

#matriz de confucion 
prediccion_1 <- predict(arbol_1, newdata = prueba, type = "class")
confusionMatrix(prediccion_1, prueba[["tipo"]])
