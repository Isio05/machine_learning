# Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import random
import math

# Importing the dataset
dataset = pd.read_csv('Ads_CTR_Optimisation.csv')

# Implementation of Thompson Sampling
# Init of variables, test dataset has 10k records and 10 ads
N = 10000
d = 10
ads_selected = []
rewards_1 = [0] * d
rewards_0 = [0] * d
for n in range(N):
    # Init variables for choice information
    max_random = 0
    max_random_add = 0
    # Calculate random draw from the distribution
    for i in range(d):
        random_beta = random.betavariate(rewards_1[i]+1, rewards_0[i]+1)
        if random_beta > max_random:
            max_random = random_beta
            max_random_add = i
    # Select ad that has the highest theta in given round
    ads_selected.append(max_random_add)
    reward = dataset.iloc[n,max_random_add]
    if reward == 1:
        rewards_1[max_random_add] += 1
    else:
        rewards_0[max_random_add] += 1
        
print(sum(rewards_1))
