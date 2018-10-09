#Regresion logistica

data <- read.csv("C:/Users/olgac/Desktop/Rmegaproyecto/Data.csv")
class(data)
summary(data)
exploratorio.modelo <- subset(data)
exploratorio.modelo$tipo <- factor(exploratorio.modelo$tipo)
table(exploratorio.modelo$tipo)
#glm logistic regresion
modelo.logistica <- glm(tipo~ rmsTr+ pkLevel + crest + rmsPk + minLevel + maxLevel + rmsLevel, data = exploratorio.modelo, family = "binomial")
summary(modelo.logistica)
