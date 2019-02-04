# Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.svm import SVC
from sklearn.metrics import confusion_matrix
from matplotlib.colors import ListedColormap


# Importing the dataset
dataset = pd.read_csv('Social_Network_Ads.csv')
# Creating separate variables allows to use universal formulas during charting
x_cols = [2,3]
y_cols = 4
X = dataset.iloc[:, x_cols].values
y = dataset.iloc[:, y_cols].values

# Splitting the dataset into the Training set and Test set
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.25, random_state = 0)

# Scale X
scale_x = StandardScaler()
scale_x.fit(X_train)
X_train = scale_x.transform(X_train)
X_test = scale_x.transform(X_test)

# Fitting dataset to Regression model
classifier = SVC(kernel='rbf', random_state=0)
classifier.fit(X_train, y_train)

# Predict results of test set
y_pred = classifier.predict(X_test)

# Calculate confustion matrix
cm = confusion_matrix(y_test, y_pred)

# Create a chart with results and predictions - training set
x_set, y_set = X_train, y_train
# Basing on the values that are going to constitute x and y axis 
# create a grid that will containt "every" point on the plot
x_1, x_2 = np.meshgrid(np.arange(x_set[:,0].min()-1, x_set[:,0].max()+1, 0.01),
                       np.arange(x_set[:,1].min()-1, x_set[:,1].max()+1, 0.01))
# Plot contour, classifier gets flattened versions of grids (that means it will just get x,y pairs)
# Received values are again fitted to the shape of x_1/x_2
plt.contourf(x_1, x_2, classifier.predict(np.array([x_1.ravel(), x_2.ravel()]).T).reshape(x_1.shape),
            alpha=0.8, cmap = ListedColormap(('red', 'green')))
# Plot real observations
# First plot points that have 0 value corresponding in y_set and choose 
# orange color for them, same for 1 value corresponding in y_set but with
# changed color
for i, j in enumerate(np.unique(y_set)):
    plt.scatter(x_set[y_set == j,0], x_set[y_set == j,1],
                c=ListedColormap(("orange","blue"))(i), label = j)
# Esthetics, x and y axis label basing on the names of columns chosen for x_set
plt.title("Logistic Regression")
plt.xlabel(dataset.columns[x_cols][0])
plt.ylabel(dataset.columns[x_cols][1])
plt.legend()
plt.show()


# Create a chart with results and predictions - test set
x_set, y_set = X_test, y_test
# Basing on the values that are going to constitute x and y axis 
# create a grid that will containt "every" point on the plot
x_1, x_2 = np.meshgrid(np.arange(x_set[:,0].min()-1, x_set[:,0].max()+1, 0.01),
                       np.arange(x_set[:,1].min()-1, x_set[:,1].max()+1, 0.01))
# Plot contour, classifier gets flattened versions of grids (that means it will just get x,y pairs)
# Received values are again fitted to the shape of x_1/x_2
plt.contourf(x_1, x_2, classifier.predict(np.array([x_1.ravel(), x_2.ravel()]).T).reshape(x_1.shape),
            alpha=0.8, cmap = ListedColormap(('red', 'green')))
# Plot real observations
# First plot points that have 0 value corresponding in y_set and choose 
# orange color for them, same for 1 value corresponding in y_set but with
# changed color
for i, j in enumerate(np.unique(y_set)):
    plt.scatter(x_set[y_set == j,0], x_set[y_set == j,1],
                c=ListedColormap(("orange","blue"))(i), label = j)
# Esthetics, x and y axis label basing on the names of columns chosen for x_set
plt.title("Logistic Regression")
plt.xlabel(dataset.columns[x_cols][0])
plt.ylabel(dataset.columns[x_cols][1])
plt.legend()
plt.show()
