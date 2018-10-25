library(tidyverse)
library(rpart)
library(rpart.plot)
library(caret)

dataCompleta <- read.csv("C:/Users/olgac/Desktop/Rmegaproyecto/dataTiempos.csv")
summary(dataCompleta)
exploratorio.modelo2 <- subset(dataCompleta)
exploratorio.modelo2$tipo <- factor(exploratorio.modelo2$tipo)
table(exploratorio.modelo2$tipo)
#primera iteración
set.seed(1677)
entrenamiento <- sample_frac(exploratorio.modelo2, .7)
prueba <- setdiff(exploratorio.modelo2, entrenamiento)
arbol_1 <- rpart(formula = tipo ~., data=entrenamiento)
arbol_1
rpart.plot(arbol_1)

#segunda iteración 
set.seed(1677)
entrenamiento_2 <- sample_frac(exploratorio.modelo2, .7)
prueba_2 <- setdiff(exploratorio.modelo2, entrenamiento_2)
arbol_2 <- rpart(formula = tipo ~., data=entrenamiento_2)
arbol_2
rpart.plot(arbol_2)

#tercera iteración 
set.seed(1212)
entrenamiento_3 <- sample_frac(exploratorio.modelo2, .7)
prueba_3 <- setdiff(exploratorio.modelo2, entrenamiento_3)
arbol_3 <- rpart(formula = tipo ~., data=entrenamiento_3)
arbol_3
rpart.plot(arbol_3)

#matriz de confucion acc de los arboles
prediccion_1 <- predict(arbol_1, newdata = prueba, type = "class")
confusionMatrix(prediccion_1, prueba[["tipo"]])

#logit 
exploration.model <- subset(dataCompleta)
exploration.model$tipo <- factor(exploration.model$tipo)
modelo.logit <- glm(tipo ~ sexo+edad+escolaridad+pebl+dsmt+hare+ciep+cief+ciec+ciem+ciex+cies+cie+rmsTr+pkLevel+crest+rmsPk+minLevel+maxLevel+rmsLevel+tiempo+respuesta,data=exploration.model,family="binomial")
summary(modelo.logit)