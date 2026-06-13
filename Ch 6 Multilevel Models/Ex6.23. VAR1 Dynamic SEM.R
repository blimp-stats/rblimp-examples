library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/MCNEISH_HAMAKER_2020.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  clusterid = 'level2id',
  timeid = 'time',
  latent = 'level2id = xmean_j ymean_j phi_yj phi_xj beta_yj beta_xj logvar_yj logvar_xj',
  model = '
    level2.models:
    1 -> xmean_j ymean_j phi_yj phi_xj beta_yj beta_xj;
    xmean_j ~~ ymean_j;
    level1.models:
    x_i ~ 1@xmean_j (x_i.lag - xmean_j)@phi_xj (y_i.lag - ymean_j)@beta_yj;
    y_i ~ 1@ymean_j (y_i.lag - ymean_j)@phi_yj (x_i.lag - xmean_j)@beta_xj;
    x_i ~~ y_i;
    variance.model:
    1 -> logvar_xj logvar_yj;
    var(y_i) ~ 1@logvar_yj;
    var(x_i) ~ 1@logvar_xj;',
  seed = 90291,
  burn = 20000,
  iter = 20000)

output(mymodel)
