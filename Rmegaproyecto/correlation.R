dataCompleta <- read.csv("C:/Users/olgac/Desktop/Rmegaproyecto/dataTiempos.csv")
data("tipo")
dataCompleta <- tipo[, c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22 )]
head(my_data, 6)
#Correlation matrix
#Coeficientes de correlacion
res <- cor(dataCompleta)
round(res,2)

library("Hmisc")
res2 <- rcorr(as.matrix(dataCompleta))
res2

#dibujar la matriz
library(corrplot)
corrplot(res, type = "upper", order = "hclust", 
         tl.col = "black", tl.srt = 45)
