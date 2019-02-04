library(caTools)
library(ggplot2)
library(rpart)
setwd("C:/Users/Ireneusz Larysz/Downloads/Python/Machine_Learning/Part 2 - Regression/Section 8 - Decision Tree Regression")

# Importing the dataset
dataset = read.csv('Position_Salaries.csv')
dataset = dataset[2:3]

# Fitting the Regression Model to the dataset
regressor = rpart(formula = Salary~., data=dataset, 
                  control = rpart.control(minsplit = 1))

# Predicting a new result
y_pred = predict(regressor, data.frame(Level = 6.5))

# Visualising the Regression Model results
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.01)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Level = x_grid))),
            colour = 'blue') +
  ggtitle('DTR') +
  xlab('Level') +
  ylab('Salary')
