#leer la data para entrenamiento
Data <- read.csv("C:/Users/olgac/Desktop/Rmegaproyecto/Data.csv")

#head(Data)
# Division of `tipo`
table(Data$tipo) 
# Percentual division of `tipo`
round(prop.table(table(Data$tipo)) * 100, digits = 1)
#resumen
summary(Data)
library(class)
#Normalización
# Build your own `normalize()` function
normalize <- function(x) {
  num <- x - min(x)
  denom <- max(x) - min(x)
  return (num/denom)
}

# Normalize the data
Data_norm <- as.data.frame(lapply(Data[1:7], normalize))

# Summarize `Data_norm`
summary(Data_norm)
set.seed(1234)
ind <- sample(2, nrow(Data), replace=TRUE, prob=c(0.67, 0.33))

# Compose training set
Data.training <- Data[ind==1, 1:7]

# Inspect training set
head(Data.training)

# Compose test set
Data.test <- Data[ind==2, 1:7]

# Inspect test set
head(Data.test)

# Compose `Data` training labels
Data.trainLabels <- Data[ind==1,8]

# Inspect result
print(Data.trainLabels)

# Compose `iris` test labels
Data.testLabels <- Data[ind==2, 8]

# Inspect result
print(Data.testLabels)


# Build the model
Data_pred <- knn(train = Data.training, test = Data.test, cl = Data.trainLabels, k=3)

# Inspect `iris_pred`
Data_pred

# Put `iris.testLabels` in a data frame
DataTestLabels <- data.frame(Data.testLabels)

# Merge `iris_pred` and `iris.testLabels` 
merge <- data.frame(Data_pred, Data.testLabels)

# Specify column names for `merge`
names(merge) <- c("Predicted Species", "Observed Species")

# Inspect `merge` 
merge

library(gmodels)
CrossTable(x = Data.testLabels, y = Data_pred, prop.chisq=FALSE)
