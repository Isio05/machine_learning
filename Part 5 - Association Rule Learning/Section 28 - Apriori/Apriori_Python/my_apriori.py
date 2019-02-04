# Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from apyori import apriori

# Data Preprocessing
dataset = pd.read_csv('Market_Basket_Optimisation.csv', header = None)
trans = []
for i in range(1,len(dataset)):
    trans.append(dataset.iloc[i,:].apply(lambda x: str(x)).tolist())

# Visualisation
rules = apriori(trans, min_support = 0.003, min_confidence = 0.4, min_lift = 2, min_length = 2)
results = list(rules)