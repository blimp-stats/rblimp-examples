library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/MCNEISH_HAMAKER_2020_TREND.RDS', 'rb')
data <- readRDS(connect); close(connect)

# detrended / residual DSEM (RDSEM)
mymodel <- rblimp(
  data = data,
  clusterid = 'level2id',
  timeid = 'time',
  latent = 'level2id = ymean_j xmean_j phi_j beta_j trend_j',
  model = '
    # definition variable for the predicted value of y_i.lag
    y_i_lag_hat = ymean_j + (time-1)*trend_j + x_i.lag*beta_j; 
    # remove default dsem prior on missing time = 0 outcome
    y_i_lag_res = ifelse(time <= 1, 0, y_i.lag - y_i_lag_hat);
    level2.models:
    1 -> ymean_j xmean_j phi_j beta_j trend_j;
    level1.models:
    x_i ~ 1@xmean_j;
    y_i ~ 1@ymean_j y_i_lag_res@phi_j x_i@beta_j time@trend_j;',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel)
