setwd("C:/Users/ireneusz.larysz/PycharmProjects/Machine_Learning/Part 3 - Classification/Section 14 - Logistic Regression")
library(caTools)

# Read a dataset and split it into training and test set
dataset <- read.csv("Social_Network_Ads.csv")
dataset <- dataset[, 3:5]
set.seed(123)
split <- sample.split(dataset$Purchased, SplitRatio =  0.75) 
train_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)

# Scale independent variables
train_set[, 1:2] <- scale(train_set[, 1:2])
test_set[, 1:2] <- scale(test_set[, 1:2])

# Create Logistic regression classifier basing on all independent variables
classifier <- glm(formula = Purchased ~., family = binomial, data = training_set)

# Create vector of probabilities for test set, then assuming border value of 0.5 change them to final 0/1 outcomes
prediction <- predict(classifier, type = "response", newdata = test_set[1:2])
prediction <- ifelse(prediction > 0.5, 1, 0)

# Check the accuracy with confusion matrix
confusion_matrix <- table(prediction, test_set$Purchased)

# Create chart with training set for comparison
# Names changing for easy substition
origin <- train_set
# Plot will be represented as points plotted with dividing line and fully colored fields that represent 0/1 areas
# To get the field create thin grid for values in range of dataet along with predictions for it
x_1 <- seq(min(origin[1])-1, max(origin[1])+1, 0.01)
x_2 <- seq(min(origin[2])-1, max(origin[2])+1, 0.01)
xs_grid <- expand.grid(x_1, x_2)
colnames(xs_grid) <- c("Age", "EstimatedSalary")
xs_grid_prediction <- predict(classifier, type="response", newdata = xs_grid)
xs_grid_prediction <- ifelse(xs_grid_prediction < 0.5, 0, 1)
# Contour Z axis has to have shape corresponding to length of x_1 and x_2 vectors
contour(x_1, x_2, matrix(xs_grid_prediction, length(x_1), length(x_2)))
# When grid is ready plot it as points
points(xs_grid, pch=1, col=ifelse(xs_grid_prediction == 1, "#83f441", "#f47f41"))
points(origin[1:2], pch=21, bg=ifelse(origin[3] == 1, "blue", "orange"))


# Create chart with test set for comparison
# Names changing for easy substition
origin <- test_set
# Plot will be represented as points plotted with dividing line and fully colored fields that represent 0/1 areas
# To get the field create thin grid for values in range of dataet along with predictions for it
x_1 <- seq(min(origin[1])-1, max(origin[1])+1, 0.01)
x_2 <- seq(min(origin[2])-1, max(origin[2])+1, 0.01)
xs_grid <- expand.grid(x_1, x_2)
colnames(xs_grid) <- c("Age", "EstimatedSalary")
xs_grid_prediction <- predict(classifier, type="response", newdata = xs_grid)
xs_grid_prediction <- ifelse(xs_grid_prediction < 0.5, 0, 1)
# Contour Z axis has to have shape corresponding to length of x_1 and x_2 vectors
contour(x_1, x_2, matrix(xs_grid_prediction, length(x_1), length(x_2)))
# When grid is ready plot it as points
points(xs_grid, pch=1, col=ifelse(xs_grid_prediction == 1, "#83f441", "#f47f41"))
points(origin[1:2], pch=21, bg=ifelse(origin[3] == 1, "blue", "orange"))






