library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.5.RDS', 'rb')
data <- readRDS(connect); close(connect)

# prior 2 (the default)
mymodel1 <- rblimp(
   data = data,
   clusterid = 'level2id',
   center = '
    groupmean = x1_i;
    grandmean = x2_i',
   model = 'y_i ~ x1_i x2_i | x1_i',
   seed = 90291,
   burn = 10000,
   iter = 10000,
   options = 'prior2')

output(mymodel1)
posterior_plot(mymodel,'y_i')

# prior 1
mymodel2 <- rblimp(
  data = data,
  clusterid = 'level2id',
  center = '
   groupmean = x1_i;
   grandmean = x2_i',
  model = 'y_i ~ x1_i x2_i | x1_i',
  seed = 90291,
  burn = 10000,
  iter = 10000,
  options = 'prior1')

output(mymodel2)
posterior_plot(mymodel2)

# prior 3
mymodel3 <- rblimp(
  data = data,
  clusterid = 'level2id',
  center = '
   groupmean = x1_i;
   grandmean = x2_i',
  model = 'y_i ~ x1_i x2_i | x1_i',
  seed = 90291,
  burn = 10000,
  iter = 10000,
  options = 'prior3')

output(mymodel3)
posterior_plot(mymodel3)

# separation prior
mymodel4 <- rblimp(
  data = data,
  clusterid = 'level2id',
  latent = 'level2id = beta0_j beta1_j',
  center = '
   groupmean = x1_i;
   grandmean = x2_i',
  model = '
   beta1_j ~ 1;
   beta0_j ~~ beta1_j;
   focal.model:
   y_i ~ 1@beta0_j x1_i@beta1_j x2_i',
  seed = 90291,
  burn = 10000,
  iter = 10000,
  options = 'use_phantom')

output(mymodel4)
posterior_plot(mymodel4)
