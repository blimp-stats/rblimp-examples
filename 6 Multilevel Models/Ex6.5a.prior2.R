library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.5.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   clusterid = 'level2id',
   center = 'groupmean = x1_i;
   grandmean = x2_i',
   model = 'y_i ~ x1_i x2_i | x1_i',
   seed = 90291,
   burn = 10000,
   iter = 10000,
   options = 'prior2')

output(mymodel)


posterior_plot(mymodel)
