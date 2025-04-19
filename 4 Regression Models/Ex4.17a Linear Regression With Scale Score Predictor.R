library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.17.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   ordinal = 'x1:x7 d1 d2',
   model = '
   focal.model:
   xscale = x1:+:x7; 
   yscale ~  xscale d1 d2; 
   predictor.model:
   x1:x7 d1 d2 ~ 1', 
   seed = 90291,
   burn = 5000,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel, 'yscale')
