# Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.cluster import KMeans

# Select variables to be clustered
dataset = pd.read_csv("Mall_Customers.csv")
X = dataset.iloc[:, [3,4]].values

# Choosing right amount of clusters
wcss = []
for i in range(1,11):
    kmeans = KMeans(n_clusters = i, init="k-means++", n_init = 20, 
                    max_iter = 400, random_state = 0)
    kmeans.fit(X)
    wcss.append(kmeans.inertia_)

plt.plot(range(1,11), wcss)
plt.show()

# For this dataset the elbow is at 5
kmeans = KMeans(n_clusters = 5, init="k-means++", n_init = 20, 
                max_iter = 400, random_state = 0)
# dist = kmeans.fit_transform(X)
clustered = kmeans.fit_predict(X)

# Plot groups and centroids
plt.scatter(X[clustered == 0, 0], X[clustered == 0, 1], c = "red", label = "Cluster 1")
plt.scatter(X[clustered == 1, 0], X[clustered == 1, 1], c = "green", label = "Cluster 2")
plt.scatter(X[clustered == 2, 0], X[clustered == 2, 1], c = "blue", label = "Cluster 3")
plt.scatter(X[clustered == 3, 0], X[clustered == 3, 1], c = "grey", label = "Cluster 4")
plt.scatter(X[clustered == 4, 0], X[clustered == 4, 1], c = "purple", label = "Cluster 5")
plt.scatter(kmeans.cluster_centers_[:, 0], kmeans.cluster_centers_[:, 1], 
            c = "pink", label = "Centroids")
plt.xlabel("Income")
plt.ylabel("Spending")
plt.title("Kmeans Chart")
plt.legend()
plt.show()
