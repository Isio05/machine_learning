import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression

# Read the dataset from file
dataset = pd.read_csv("Salary_Data.csv")
X = dataset.iloc[:, :-1].values
y = dataset.iloc[:,1].values

# Split set into training and test
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=1/3, random_state=0)

regressor = LinearRegression()
regressor.fit(X_train, y_train)

y_pred = regressor.predict(X_test)

# Show plot with train set and corresponding points
axis1 = plt.subplot2grid((7,1), (0,0), rowspan=3, colspan=1)
# Training set
axis1.scatter(X_train, y_train, color="red")
# Line estimated with linear regression
axis1.plot(X_train, regressor.predict(X_train), color="blue")
# Chart configuration options
axis1.set_title("Salary based on Experience")
axis1.set_xlabel("Years of experience")
axis1.set_ylabel("Salary")
for tick_point in axis1.get_yticklabels():
    tick_point.set_rotation(45)

# Plot with test set results, chart configuration unchaged with comparison to training set ones
axis2 = plt.subplot2grid((7,1), (4,0), rowspan=3, colspan=1)
axis2.scatter(X_test, y_test, color="red")
axis2.plot(X_train, regressor.predict(X_train), color="blue")
axis2.set_title("Salary based on Experience")
axis2.set_xlabel("Years of experience")
axis2.set_ylabel("Salary")
for tick_point in axis2.get_yticklabels():
    tick_point.set_rotation(45)

plt.show()

print("test")