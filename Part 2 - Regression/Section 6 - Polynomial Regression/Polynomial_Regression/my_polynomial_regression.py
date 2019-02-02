# Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, PolynomialFeatures
from sklearn.linear_model import LinearRegression


# Importing the dataset
dataset = pd.read_csv('Position_Salaries.csv')
# "1:2" to ensure that X is treated as matrix
X = dataset.iloc[:, 1:2].values
y = dataset.iloc[:, 2].values

# Splitting the dataset into the Training set and Test set
# Here not needed due to usage and amount of data
"""
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0)
"""

# Feature Scaling, currently not needed
"""
sc_X = StandardScaler()
X_train = sc_X.fit_transform(X_train)
X_test = sc_X.transform(X_test)
sc_y = StandardScaler()
y_train = sc_y.fit_transform(y_train)
"""

# Linear part
# Fit linear regression to data - reference
lin_reg = LinearRegression()
lin_reg.fit(X, y)

# Compare prediction results with data
ax1 = plt.subplot2grid((7,1), (0,0), rowspan=3, colspan=1)
ax2 = plt.subplot2grid((7,1), (4,0), rowspan=3, colspan=1, sharex=ax1)
ax1.scatter(X, y, color='blue')
ax1.plot(X, lin_reg.predict(X), color='red')
ax1.set_ylabel("Predictions vs Real data")

# Polynomial part
# Fit polynomial regression to the dataset
poly_reg = PolynomialFeatures(degree=4)
X_poly = poly_reg.fit_transform(X)
lin_reg_2 = LinearRegression()
lin_reg_2.fit(X_poly, y)

# Compare prediction results with data
# Smooth the curve
X_smooth = np.arange(min(X), max(X), 0.1).reshape((-1,1))
ax2.scatter(X,y, color="blue")
ax2.plot(X_smooth,lin_reg_2.predict(poly_reg.fit_transform(X_smooth)), color="red")
ax2.set_ylabel("Predictions vs Real data")
ax2.set_xlabel("Years of experience")
plt.title("SLR vs Polynomial")
plt.show()
