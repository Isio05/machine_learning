setwd("C:/Users/Ireneusz Larysz/Downloads/Python/Machine_Learning/Part 2 - Regression/Section 9 - Random Forest Regression")
library(caTools)
library(ggplot2)
library(randomForest)

# Importing the dataset
dataset = read.csv('Position_Salaries.csv')
dataset = dataset[2:3]

# Fitting the Regression Model to the dataset
set.seed(1234)
regressor = randomForest(x = dataset[1], y=dataset$Salary, ntree=100)

# Predicting a new result
y_pred = predict(regressor, data.frame(Level = 6.5))

# Visualising the Regression Model results (for higher resolution and smoother curve)
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.01)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Level = x_grid))),
            colour = 'blue') +
  ggtitle('Random Forest Regression') +
  xlab('Level') +
  ylab('Salary')
