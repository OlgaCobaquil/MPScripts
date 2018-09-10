#Algoritmos R

library(caret)
colnames(verdadmentira)<-c("minLevel","maxLevel", "pkLevel", "rmsLevel", "rmsPk", "rmsTr", "crest", "type")
# crear una lista del 70% para el entrenamiento
validation_index <- createDataPartition(verdadmentira$type, p=0.70, list=FALSE)
# 30% para validation
validation <- verdadmentira[-validation_index,]
# 80% training y testing
dataset <- verdadmentira[validation_index,]
dim(dataset)
sapply(dataset,class)
head(dataset)
#distrubucion de las clases
percentage <- prop.table(table(dataset$type)) * 100
cbind(freq=table(dataset$type), percentage=percentage)
summary(dataset)

#separar input y output
x <- dataset[,1:7]
y <- dataset[,8]

# Diagrama de caja para cada uno de los atributos
par(mfrow=c(1,4))
for(i in 4:7) {
  boxplot(x[,i], main=names(verdadmentira)[i])
}

control <- trainControl(method="cv", number=10)
metric <- "Accuracy"

set.seed(7)
fit.lda <- train(type~., data=dataset, method="lda", metric=metric, trControl=control)
# b) nonlinear algorithms
# CART
set.seed(7)
fit.cart <- train(type~., data=dataset, method="rpart", metric=metric, trControl=control)
# kNN
set.seed(7)
fit.knn <- train(type~., data=dataset, method="knn", metric=metric, trControl=control)
# c) advanced algorithms
# SVM
set.seed(7)
fit.svm <- train(type~., data=dataset, method="svmRadial", metric=metric, trControl=control)
# Random Forest
set.seed(7)
fit.rf <- train(type~., data=dataset, method="rf", metric=metric, trControl=control)

results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))
summary(results)


#faskj R

#Dataset Training
Training
head(Training)
names(Traoining)
library(ggvis)
#plotear 
Training %>% ggvis(~maxLevel, ~crest, fill = type) %>% layer_points()
#matriz de correlaciones (maxLevel, crest)
cor(Training$maxLevel, Training$crest)
#correlacion 0.4331021
table(Training$type) 
round(prop.table(table(Training$type)) * 100, digits = 1)
# 438 - 1 - 50.2,  434 - 2 - 49.8

library(class)
set.seed(1234)
ind <- sample(2, nrow(Training), replace=TRUE, prob=c(0.67, 0.33))
# Compose training set
Training.training <- Training[ind==1, 1:8]

# Inspect training set
head(Training.training)


# Inspect test set
head(Training.test)

# training labels
Training.trainLabels <- Training[ind==1,8]

# Inspect result
print(Training.trainLabels)

# test labels
Training.testLabels <- Training[ind==2, 8]

# Inspect result
print(Training.testLabels)

# Build the model
data_pred <- knn(train = Training.training, test = Training.test, cl = Training.trainLabels, k=3)

# Inspect `data_pred`
data_pred

# Put `Training.testLabels` in a data frame
TrainingTestLabels <- data.frame(Training.testLabels)

# Merge `data_pred` and `Training.testLabels` 
merge <- data.frame(data_pred, Training.testLabels)

# Specify column names for `merge`
names(merge) <- c("Predicted Type", "Observed Type")

# Inspect `merge` 
merge

 