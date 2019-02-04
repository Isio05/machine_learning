# Import the libraries
library(e1071)
library(ElemStatLearn)
library(caret)
library(caTools)

set.seed(123)

# Read a dataset and split it into training and test set
dataset <- read.csv("Wine.csv")
split <- sample.split(dataset$Customer_Segment, SplitRatio =  0.75) 
train_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)

# Scale independent variables
train_set[-14] <- scale(train_set[-14])
test_set[-14] <- scale(test_set[-14])

# Apply PCA
pca = preProcess(x = train_set[-14], method = "pca", pcaComp = 2)
train_set = predict(pca, train_set)
train_set = train_set[c(2,3,1)]
test_set = predict(pca, test_set)
test_set = test_set[c(2,3,1)]

# Create Logistic regression classifier basing on all independent variables
classifier <- svm(formula = Customer_Segment ~., data = train_set, type = "C-classification", kernel = "linear")

# Create vector of probabilities for test set, then assuming border value of 0.5 change them to final 0/1 outcomes
prediction <- predict(classifier, type = "response", newdata = test_set[1:2])

# Check the accuracy with confusion matrix
confusion_matrix <- table(prediction, test_set$Customer_Segment)


# Visualising the Training set results
library(ElemStatLearn)
set = train_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('PC1', 'PC2')
y_grid = predict(classifier, newdata = grid_set)
plot(set[, -3],
     main = 'SVM (Training set)',
     xlab = 'PC1', ylab = 'PC2',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 2, 'deepskyblue', ifelse(y_grid == 1, 'springgreen3', 'tomato')))
points(set, pch = 21, bg = ifelse(set[, 3] == 2, 'blue3', ifelse(set[, 3] == 1, 'green4', 'red3')))

# Visualising the Test set results
library(ElemStatLearn)
set = test_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('PC1', 'PC2')
y_grid = predict(classifier, newdata = grid_set)
plot(set[, -3], main = 'SVM (Test set)',
     xlab = 'PC1', ylab = 'PC2',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 2, 'deepskyblue', ifelse(y_grid == 1, 'springgreen3', 'tomato')))
points(set, pch = 21, bg = ifelse(set[, 3] == 2, 'blue3', ifelse(set[, 3] == 1, 'green4', 'red3')))