library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex7.7.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  ordinal = 'd_j m_j',
  clusterid = 'level2id',
  fixed = 'time_i',
  model = '
   focal.model:
   y_i ~ 1@beta0_obs time_i@beta1_obs d_j@beta2_obs
    (time_i*d_j)@beta3_obs m_j@beta0_dif (m_j*time_i)@beta1_dif
    (m_j*d_j)@beta2_dif (m_j*time_i*d_j)@beta3_dif | time_i;
   predictor.model:
   m_j ~ 1@ymissmean;
   d_j ~ m_j',
  parameters = 'p_mis = phi(ymissmean);
   p_obs = 1 - p_mis ;
   beta0 = p_obs * beta0_obs + p_mis * (beta0_obs + beta0_dif);
   beta1 = p_obs * beta1_obs + p_mis * (beta1_obs + beta1_dif);
   beta2 = p_obs * beta2_obs + p_mis * (beta2_obs + beta2_dif);
   beta3 = p_obs * beta3_obs + p_mis * (beta3_obs + beta3_dif)',
  seed = 90291,
  burn = 5000,
  iter = 10000)

output(mymodel)
posterior_plot(mymodel)
