# Read data from file in current folder
dataset = read.csv("Salary_Data.csv")


# Split data into training and test set
library(caTools)
set.seed(123)
split = sample.split(dataset$Salary, SplitRatio = 2/3)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Fit SLR to training set
regressor = lm(formula = Salary ~ YearsExperience, data = training_set)

# Predict values from test set
y_pred = predict(regressor, newdata = test_set)

# Plot results for training set
ggplot() +
  geom_point(aes(x = training_set$YearsExperience, y = training_set$Salary),
             color = "red") +
  geom_line(aes(x = training_set$YearsExperience, 
                predict(regressor, newdata = training_set)), color = "blue") +
  ggtitle("Salary vs Experience") +
  xlab("Experience") +
  ylab("Salary")


# Plot results for test set
ggplot() +
  geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
             color = "red") +
  geom_line(aes(x = training_set$YearsExperience, 
                predict(regressor, newdata = training_set)), color = "blue") +
  ggtitle("Salary vs Experience") +
  xlab("Experience") +
  ylab("Salary")
