library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/MCNEISH_HAMAKER_2020_TREND.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  clusterid = 'level2id',
  timeid = 'time',
  latent = 'level2id = ymean_j xmean_j phi_j beta_1j beta_2j',
  model = '
    lag_yhat = ymean_j + (time - 1)*beta_2j + (x_i.lag - xmean_j)*beta_1j;
    lag_yres = ifelse(time <= 1, 0, y_i.lag - lag_yhat);
    level2.models:
    1 -> ymean_j xmean_j phi_j beta_1j beta_2j;
    level1.models:
    x_i ~ 1@xmean_j;
    y_i ~ 1@ymean_j lag_yres@phi_j (x_i - xmean_j)@beta_1j time@beta_2j;',
  seed = 90291,
  burn = 10000,
  iter = 10000
)

output(mymodel)
posterior_plot(mymodel)
