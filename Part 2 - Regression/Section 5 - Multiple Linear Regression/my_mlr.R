setwd("C:/Users/Ireneusz Larysz/Downloads/Python/Machine_Learning/Part 2 - Regression/Section 5 - Multiple Linear Regression")
dataset <- read.csv("50_Startups.csv")

# Category data will is going encoded as 0,1
# According to country column a "One Hot Encoding" will be used
dataset$State <- factor(dataset$State,
                          levels = as.vector(unique(dataset$State)),
                          labels = c(1,2,3))

# Split dataset into training and test set
library("caTools")
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
# training_set = dataset$Purchased[split]
# test_set = dataset$Purchased[!split]
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Fit regressor to the training set
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend
              + State, data = dataset)
# Another way to write the formula:

regressor = lm(formula = Profit ~ ., data = dataset)

# Only R&D spend turne out to be signifacnt (p < 0.05)
regressor_2 = lm(formula = Profit ~ R.D.Spend, data = dataset)
y_pred = predict(regressor_2, newdata = test_set)








