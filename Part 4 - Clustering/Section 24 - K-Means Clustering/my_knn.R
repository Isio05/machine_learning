library(cluster)

# Import the dataset
dataset <- read.csv("Mall_Customers.csv")
X <- dataset[4:5]

# Choose the amount of clusters
wcss <- vector()
for(i in 1:10){
  wcss[i] <- sum(kmeans(X, i, iter.max = 400, nstart = 20)$withinss)
}
plot(1:10, wcss, type = "b")

# Elbow is at 5 clusters
clustered <- kmeans(X, 5, iter.max = 400, nstart = 20)

clusplot(X,
         clustered$cluster,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 1,
         plotchar = FALSE,
         span = TRUE,
         main = "Cluster plot",
         xlab = 'Income',
         ylab = 'Spending')
