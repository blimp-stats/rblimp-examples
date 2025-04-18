connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.14.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(fdir)
library(rblimp)

set()
load(file = 'data1.rda')

mymodel <- rblimp(
   data = data1,
   clusterid = 'level2id',
   latent = 'level2id = xmean_j mmean_j ymean_j alpha_j beta_j tau_j',
   model = '
   level2.mediation:
   mmean_j ~ xmean_j@alpha_b;
   ymean_j ~ mmean_j@beta_b xmean_j@tau_b;
   level1.mediation:
   m_i ~ 1@mmean_j (x_i - xmean_j)@alpha_j;
   y_i ~ 1@ymean_j (m_i - mmean_j)@beta_j (x_i - xmean_j)@tau_j;
   level2.models:
   1 -> xmean_j mmean_j ymean_j tau_j;
   alpha_j ~ 1@alpha_mean;
   beta_j ~ 1@beta_mean;
   alpha_j ~~ beta_j@ab_cor;
   level1.models:
   x_i ~ 1@xmean_j',
   parameters = 'ab_cov = ab_cor * sqrt(alpha_j.totalvar * beta_j.totalvar);
   ab_w = alpha_mean * beta_mean + ab_cov;
   ab_b = alpha_b * beta_b',
   seed = 90291,
   burn = 10000,
   iter = 10000)
output(mymodel)


