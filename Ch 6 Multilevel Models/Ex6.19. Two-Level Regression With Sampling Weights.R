library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.19.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   clusterid = 'level2id',
   weights = 'level1wgt level2wgt',
   model = 'y_i ~ x1_i x2_i x3_i',
   seed = 90291,
   burn = 2000,
   iter = 10000)

output(mymodel)


posterior_plot(mymodel)
