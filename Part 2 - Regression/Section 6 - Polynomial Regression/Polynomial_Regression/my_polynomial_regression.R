library(caTools)
library(ggplot2)

# Data preprocessing
setwd("C:/Users/Ireneusz Larysz/Downloads/Python/Machine_Learning/Part 2 - Regression/Section 6 - Polynomial Regression/Polynomial_Regression")
dataset <- read.csv("Position_Salaries.csv")
dataset <- dataset[2:3]


# Fit to linear model - for comparison
regressor <- lm(formula = Salary ~ Level, data = dataset)
y_pred_lin <- predict(regressor, newdata = dataset)

# Plot linear regression result along with base dataset
ggplot(data=dataset, aes(x=Level, y=Salary)) +
  geom_point(color="blue") +
  geom_line(aes(x=dataset$Level, y=predict(regressor, newdata = dataset)), 
            color = "red") +
  ggtitle("Linear Regression Model")

# Fit to polynomial model
dataset$Level2 <- dataset$Level^2
dataset$Level3 <- dataset$Level^3
poly_reg <- lm(formula = Salary ~., data = dataset)

# Plot polynomial regression result along with base dataset
ggplot(data=dataset, aes(x=Level, y=Salary)) +
  geom_point(color="blue") +
  geom_line(aes(x=dataset$Level, y=predict(poly_reg, newdata=dataset)), 
            color = "red") +
  ggtitle("Polynomial Regression Model")

# Predicting specific result
test <- data.frame("Level" = 6.5)
predict(regressor, test)

test$Level2 <- test$Level^2
test$Level3 <- test$Level^3
predict(poly_reg, test)
