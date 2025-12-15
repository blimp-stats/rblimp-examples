library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.19.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   ordinal = 'y d1 d2',
   fixed = 'd1 x1',
   model = '
   focal.model:
   logit(y) ~ x1 x2 d1 d2;
   predictor.model:
   yjt(x2 - 15.5) ~ x1 d1; 
   d2 ~ x2 x1 d1',
   seed = 90291,
   burn = 1000,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel, 'y')
