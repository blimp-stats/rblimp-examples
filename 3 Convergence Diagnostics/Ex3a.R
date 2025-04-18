library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/data8.rda', 'rb')
load(connect); close(connect)

mymodel <- rblimp(
   data = data8,
   clusterid = 'level2id',
   ordinal = 'd1.j',
   fixed = 'd1.j',
   center = 'groupmean = x1.i;
     grandmean = x2.i x7.j d1.j',
   model = ' y.i ~ x1.i x2.i x7.j d1.j | x1.i',
   seed = 90291,
   burn = 10000,
   iter = 10000,
   options = 'labels')

output(mymodel)
posterior_plot(mymodel,'y.1')


