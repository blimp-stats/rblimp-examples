library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.13.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   clusterid = 'level2id',
   latent = 'level2id = xmean_j mmean_j ymean_j alpha_j beta_j tau_j',
   center = 'grandmean = w_j',
   model = '
   level2.models:
   1 -> xmean_j mmean_j ymean_j tau_j w_j;
   mmean_j ~ w_j;
   alpha_j ~ 1@alpha_mean w_j@product;
   beta_j ~ 1@beta_mean;
   alpha_j ~~ beta_j@ab_cor;
   level1.models:
   x_i ~ 1@xmean_j;
   m_i ~ 1@mmean_j (x_i - xmean_j)@alpha_j;
   y_i ~ 1@ymean_j (m_i - mmean_j)@beta_j (x_i - xmean_j)@tau_j',
   parameters = 'w_stddev = sqrt(w_j.totalvar);
   ab_cov = ab_cor * sqrt(alpha_j.totalvar * beta_j.totalvar);
   ab_low = (alpha_mean - (product * w_stddev)) * 
      beta_mean + ab_cov;
   ab_med = alpha_mean * beta_mean + ab_cov;
   ab_high = (alpha_mean + (product * w_stddev)) * 
      beta_mean + ab_cov',
   seed = 90291,
   burn = 10000,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel,'ab_low')
posterior_plot(mymodel,'ab_med')
posterior_plot(mymodel,'ab_high')
posterior_plot(mymodel)
