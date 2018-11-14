import numpy as np
import pandas as pd
from sklearn.preprocessing import OneHotEncoder
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
import statsmodels.formula.api as sm

# Load the data and separate x and y
dataset = pd.read_csv("50_Startups.csv")
x = dataset.iloc[:, :-1].values
y = dataset.iloc[:, 4].values

# One-hot encode the categorical variable (State)
categories = np.unique(x[:, 3])
enc = OneHotEncoder(categories=[categories])
encoded_values = enc.fit_transform(x[:, 3].reshape(-1, 1)).toarray()
x = np.append(encoded_values.astype(int), x[:, :-1].astype(float), axis=1)

# Avoid Dummy Variable Trap
x = x[:, 1:]

# Split dataset into train and test - 20%
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=0)

# Fit Multiple Linear Regression to the set
regressor = LinearRegression()
regressor.fit(x_train, y_train)
y_pred = regressor.predict(X=x_test)

# Compare the results
comparison = np.append(y_test.reshape(-1, 1), y_pred.reshape(-1, 1), axis=1)
print(comparison, "sum of differences: ", np.sum(abs(y_test - y_pred)))

# Add ones to the beginning of the x (acts as coefficient for constant)
x = np.append(arr=np.ones((50, 1)).astype(int), values=x, axis=1)

# Remove insignificant values
X_opt = x[:, [0, 3]]
regressor_OLS = sm.OLS(endog=y, exog=X_opt).fit()
print(regressor_OLS.summary())

# New predictions with less variables
regressor_2 = LinearRegression()
regressor_2.fit(x_train[:, [0, 3]], y_train)
y_pred_2 = regressor_2.predict(X=x_test[:, [0, 3]])

# Compare results
comparison = np.append(y_test.reshape(-1, 1), y_pred_2.reshape(-1, 1), axis=1)
print(comparison, "sum of differences: ", np.sum(abs(y_test - y_pred_2)))
