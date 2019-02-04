# Importing the testing dataset
dataset = read.csv('Ads_CTR_Optimisation.csv')

# Initialize variables, test set has 10 ads
N = 10000
d = 10
ads_selected = c()
selections_per_ad = integer(d)
rewards_per_ad = integer(d)
# Carry out test for every observation in test set
for(n in 1:N){
  # Init variables for choice information
  max_ucb_add = 0
  max_ucb = 0
  # Calculate upper bound for every ad
  # First ten iterations just show subsequent ads
  for(i in 1:d){
    if(selections_per_ad[i] > 0){
      avg_ad_reward = rewards_per_ad[i] / selections_per_ad[i]
      delta_i = sqrt(3/2 * (log(n)/selections_per_ad[i]))
      ucb = avg_ad_reward + delta_i
    }else{
      ucb = 1e400
    }
    if(ucb > max_ucb){
      max_ucb = ucb
      max_ucb_add = i
    }
  }
  # Check chosen ad, add reward and selection information
  reward = dataset[n,max_ucb_add]
  rewards_per_ad[max_ucb_add] = rewards_per_ad[max_ucb_add] + reward
  selections_per_ad[max_ucb_add] = selections_per_ad[max_ucb_add] + 1
  ads_selected = append(ads_selected, max_ucb_add)
}

# Check freqeuncy for each ad
hist(ads_selected,
     ylab = "Count",
     xlab = "Ads",
     main = "Selections per ad")
