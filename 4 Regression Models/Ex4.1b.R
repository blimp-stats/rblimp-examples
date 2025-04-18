library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/data1.rda', 'rb')
load(connect); close(connect)

mymodel <- rblimp(
   data = data1,
   model = '
   x1 y1 y2 ~~ x1 y1 y2',
   seed = 90291,
   burn = 10000,
   iter = 10000,
   options = 'use_phantom')

output(mymodel)
posterior_plot(mymodel)


