library(caret)
data <-Data
print(data)
#Training data
validation_index <- createDataPartition(data$tipo, p=0.7, list=FALSE)
validation <- data[-validation_index,]
data <- data[validation_index,]
dim(data)
#tipo de atributos
# summarize the class distribution
percentage <- prop.table(table(data$tipo)) * 100
cbind(freq=table(data$tipo), percentage=percentage)

# summarize attribute distributions
summary(data)

# split input and output
x <- data[,1:7]
y <- data[,8]
# boxplot for each attribute on one image
#funciona si solo se corre esto 
par(mfrow=c(1,4))
for(i in 4:7) {
  boxplot(x[,i], main=names(Data)[i])
}
#hasta aqui
plot(y)

control <- trainControl(method="cv", number=10)
set.seed(7)
fit.knn <- train(tipo~., data=data, method="svmRadial", metric=metric, trControl=control)

#summarize accuracy of models
results <- resamples(list(svm=fit.svm))
summary(results)