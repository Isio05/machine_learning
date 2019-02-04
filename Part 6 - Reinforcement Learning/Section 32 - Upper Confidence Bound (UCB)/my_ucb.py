# Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import math

# Importing the testing dataset
dataset = pd.read_csv('Ads_CTR_Optimisation.csv')

# Initialize variables, test set has 10 ads
N = len(dataset)
d = 10
selections = [0] * d
rewards = [0] * d
ads_selected = []
# Carry out test for every observation in test set
for n in range(N):
    # Init variables for choice information
    max_ucb_add = 0
    max_ucb = 0
    # Calculate upper bound for every ad
    # First ten iterations just show subsequent ads
    for i in range(d):
        if selections[i] > 0:
            avg_reward = rewards[i] / selections[i]
            delta_i = math.sqrt(3/2 * (math.log(n + 1)/selections[i]))
            ucb = avg_reward + delta_i
        else:
            ucb = 1e400
        if ucb > max_ucb:
            max_ucb = ucb
            max_ucb_add = i
    # Check chosen ad, add reward and selection information
    ads_selected.append(max_ucb_add)
    selections[max_ucb_add] += 1
    reward = dataset.iloc[n,max_ucb_add]
    rewards[max_ucb_add] += reward
    