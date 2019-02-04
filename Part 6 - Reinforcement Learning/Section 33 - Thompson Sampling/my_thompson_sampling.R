# Importing the testing dataset
dataset = read.csv('Ads_CTR_Optimisation.csv')

# Initialize variables, test set has 10 ads
N = 10000
d = 10
ads_selected = c()
rewards_1 = integer(d)
rewards_0 = integer(d)
# Carry out test for every observation in test set
for(n in 1:N){
  # Init variables for choice information
  max_random_add = 0
  max_random = 0
  # Calculate random dist for every ad
  for(i in 1:d){
    random_beta = rbeta(n = 1,
                        shape1 = rewards_1[i] + 1,
                        shape2 = rewards_0[i] + 1)
    if(random_beta > max_random){
      max_random = random_beta
      max_random_add = i
    }
  }
  # Check chosen ad, add reward and selection information
  reward = dataset[n,max_random_add]
  ads_selected = append(ads_selected, max_random_add)
  
  if(reward == 1){
    rewards_1[max_random_add] = rewards_1[max_random_add] + 1
  }else{
    rewards_0[max_random_add] = rewards_0[max_random_add] + 1
  }
}

# Check freqeuncy for each ad
hist(ads_selected,
     ylab = "Count",
     xlab = "Ads",
     main = "Selections per ad")
