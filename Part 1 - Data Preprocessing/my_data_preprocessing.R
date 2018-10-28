setwd("C:/Users/Ireneusz Larysz/Downloads/Python/Machine_Learning/Part 1 - Data Preprocessing")
dataset <- read.csv("Data.csv")

# Fill nan with mean of each column
dataset$Age <- ifelse(is.na(dataset$Age),
    ave(dataset$Age, FUN = function(x) mean(x, na.rm=TRUE)),
    dataset$Age)

dataset$Salary <- ifelse(is.na(dataset$Salary),
    ave(dataset$Salary, FUN = function(x) mean(x, na.rm = TRUE)),
    dataset$Salary)

# Category data will is going encoded as 0,1
# According to country column a "One Hot Encoding" will be used
dataset$Country <- factor(dataset$Country,
                          levels = c("France", "Spain", "Germany"),
                          labels = c(1,2,3))

dataset$Purchased <- factor(dataset$Purchased,
                            levels = c("No", "Yes"),
                            labels = c(0,1))

# Split dataset into training and test set
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.8)
# training_set = dataset$Purchased[split]
# test_set = dataset$Purchased[!split]
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Standardize values in the set
# Exclude categories, factors are not considered as numeric values
training_set[,2:3] = scale(training_set[,s2:3])
test_set[,2:3] = scale(test_set[,2:3])