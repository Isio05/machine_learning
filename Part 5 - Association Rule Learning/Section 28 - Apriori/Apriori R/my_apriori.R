library(arules)

# Import the dataset
dataset <- read.transactions("Market_Basket_Optimisation.csv", sep = ",", rm.duplicates = T)
summary(dataset)
itemFrequencyPlot(dataset, topN = 20)

# Check the rules (the buyer also bought with...)
rules = apriori(data = dataset, parameter = list(support = 0.003, confidence = 0.4))
inspect(sort(rules, by = "lift")[1:10])
