library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.11.RDS', 'rb')
data <- readRDS(connect); close(connect)

# mixed model specification
mymodel1 <- rblimp(
   data = data,
   clusterid = 'level2id',
   center = '
    groupmean = x_i;
    grandmean = m_j',
   model = 'y_i ~ x_i m_j x_i*m_j | x_i',
   simple = 'x_i | m_j',
   seed = 90291,
   burn = 10000,
   iter = 10000)

output(mymodel1)
posterior_plot(mymodel1)

# latent variable specification
mymodel2 <- rblimp(
  data = data,
  clusterid = 'level2id',
  latent = 'level2id = beta0_j beta1_j',
  center = '
   groupmean = x_i;
   grandmean = m_j',
  model = ' 
   level2.model:
   beta0_j ~ 1 m_j;
   beta1_j ~ 1 m_j;
   beta0_j ~~ beta1_j;
   level1.model:
   y_i ~ 1@beta0_j x_i@beta1_j',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel2)
posterior_plot(mymodel2)
