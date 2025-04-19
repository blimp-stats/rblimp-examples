library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.18.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   ordinal = 'y1:y5 x1:x7 m',
   model = '
   focal.model:
   xscale = x1:+:x7; 
   yscale ~ xscale m m*xscale; 
   predictor.model:
   x1:x7 m ~ 1; 
   auxiliary.model:
   y1:y5 ~ yscale', 
   seed = 90291,
   burn = 20000,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel, 'yscale')
