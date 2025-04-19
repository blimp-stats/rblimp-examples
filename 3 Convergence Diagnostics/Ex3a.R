library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex3.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  clusterid = 'level2id',
  ordinal = 'd1_j',
  fixed = 'd1_j',
  center = '
   groupmean = x1_i;
   grandmean = x2_i x3_j d1_j',
  model = ' y_i ~ x1_i x2_i x3_j d1_j | x1_i',
  seed = 90291,
  burn = 10000,
  iter = 10000,
  options = 'labels')

output(mymodel)


