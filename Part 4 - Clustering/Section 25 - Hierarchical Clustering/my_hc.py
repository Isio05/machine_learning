import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import scipy.cluster.hierarchy as sch
from sklearn.cluster import AgglomerativeClustering

# %matplotlib qt

# Importing dataset
dataset = pd.read_csv("Mall_Customers.csv")
X = dataset.iloc[:, [3,4]].values

# Creating dendrogram to choose amount of clusters
dendrogram = sch.dendrogram(sch.linkage(X, method = "ward"))
plt.show()

# Choice: 5, perform clustering
hc = AgglomerativeClustering(n_clusters = 5, affinity = "euclidean", 
                             linkage = "ward")
y_pred = hc.fit_predict(X)

plt.scatter(X[y_pred == 0, 0], X[y_pred == 0, 1], c = "red", s = 100)
plt.scatter(X[y_pred == 1, 0], X[y_pred == 1, 1], c = "green", s = 100)
plt.scatter(X[y_pred == 2, 0], X[y_pred == 2, 1], c = "blue", s = 100)
plt.scatter(X[y_pred == 3, 0], X[y_pred == 3, 1], c = "grey", s = 100)
plt.scatter(X[y_pred == 4, 0], X[y_pred == 4, 1], c = "purple", s = 100)
plt.xlabel("Income")
plt.ylabel("Spending")
plt.show()