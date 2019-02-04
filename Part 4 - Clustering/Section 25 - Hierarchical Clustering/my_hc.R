# Import the dataset
dataset <- read.csv("Mall_Customers.csv")
X <- dataset[4:5]

# Using dendrogram to choose amount of clusters
dendrogram = hclust(dist(X, method = "euclidean"), method = "ward.D")
plot(dendrogram)

# The optimal is 5
# Create 5 clusters
clustered <- hclust(dist(X, method = "euclidean"), method = "ward.D")
clusters <- cutree(clustered, k = 5)

clusplot(X,
         clusters,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 1,
         plotchar = FALSE,
         span = TRUE,
         main = "Cluster plot",
         xlab = 'Income',
         ylab = 'Spending')