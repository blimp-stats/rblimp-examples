library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.16.RDS', 'rb')
data <- readRDS(connect); close(connect)

# full covariance matrix at each level
mymodel1 <- rblimp(
   data = data,
   nominal = 'd_k',
   clusterid = 'level2id level3id',
   fixed = 'time_i d_k',
   model = 'y_i ~ time_i d_k time_i*d_k | time_i',
   simple = 'time_i | d_k',
   seed = 90291,
   burn = 15000,
   iter = 10000)

output(mymodel1)
posterior_plot(mymodel1)

# only random intercepts at level-3
mymodel2 <- rblimp(
  data = data,
  nominal = 'd_k',
  clusterid = 'level2id level3id',
  fixed = 'time_i d_k',
  model = 'y_i ~ time_i d_k time_i*d_k | 1[level2id] 1[level3id] time_i[level2id]',
  simple = 'time_i | d_k',
  seed = 90291,
  burn = 15000,
  iter = 10000)

output(mymodel2)
posterior_plot(mymodel2)
