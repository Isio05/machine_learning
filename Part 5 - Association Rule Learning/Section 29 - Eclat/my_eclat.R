library(arules)

# Import the dataset
dataset <- read.transactions("Market_Basket_Optimisation.csv", sep = ",", rm.duplicates = T)
summary(dataset)
itemFrequencyPlot(dataset, topN = 20)

# Check the rules (the buyer also bought with...)
rules = eclat(data = dataset, parameter = list(support = 0.003, minlen = 2))
inspect(sort(rules, by = "support")[1:10])
