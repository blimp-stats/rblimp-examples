library(rblimp)
set_blimp('/applications/blimp/blimp-nightly')

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/MCNEISH_HAMAKER_2020.RDS', 'rb')
data <- readRDS(connect); close(connect)

# equation 7 and 8
mymodel <- rblimp(
  data = data,
  clusterid = 'level2id; timeid: time;',
  latent = 'level2id = xmean_j ymean_j phi1_j phi2_j phi3_j phi4_j yvarlog_j xvarlog_j',
  model = '
   level2.models:
   1 -> xmean_j ymean_j phi1_j phi2_j phi3_j phi4_j;
   xmean_j ~~ ymean_j;
   level1.models:
   x_i ~ 1@xmean_j (x_i.lag - xmean_j)@phi2_j (y_i.lag - ymean_j)@phi3_j;
   y_i ~ 1@ymean_j (y_i.lag - ymean_j)@phi1_j (x_i.lag - xmean_j)@phi4_j;
   x_i ~~ y_i;
   variance.model:
   1 -> xvarlog_j yvarlog_j;
   var(y_i) ~ 1@yvarlog_j;
   var(x_i) ~ 1@xvarlog_j;',
  seed = 90291,
  burn = 20000,
  iter = 20000)

output(mymodel)
