import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.impute import SimpleImputer
from sklearn.preprocessing import LabelEncoder, OneHotEncoder, StandardScaler
from sklearn.model_selection import train_test_split
from time import sleep

# Make all array visible
np.set_printoptions(threshold=np.nan)

# Read the dataset from file
dataset = pd.read_csv("Data.csv")
x = dataset.iloc[:, :-1].values
y = dataset.iloc[:, 3].values

# Overwrite missing variables with mean of whole column
imputer = SimpleImputer(missing_values=np.nan, strategy="mean")
imputer.fit(x[:,1:3])
x[:, 1:3] = imputer.transform(x[:, 1:3])

# LabelEncoder given subsequent numbers to every next categorical value
# labelencoder_x = LabelEncoder()
# x[:,0] = labelencoder_x.fit_transform(x[:,0])

# This can cause problems during ML
# That's why it is  better to use OneHotEncoder and create columns that will be only  notify about category presence
countries = np.unique(x[:, 0])
enc = OneHotEncoder(categories=[countries])
temp = enc.fit_transform(x[:,0].reshape(-1, 1)).toarray()
x = np.append(temp, x[:,1:], axis=1)

# Encode yes/no array with 0,1
labelencoder_y = LabelEncoder()
y = labelencoder_y.fit_transform(y)

# Split x & y arrays in two sets, train test will contain 80% of each array
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=0)

# Standardize the variables
sc_x = StandardScaler()
x_train = sc_x.fit_transform(x_train)
x_test = sc_x.transform(x_test)

sleep(1)