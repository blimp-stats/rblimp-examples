library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.20.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   ordinal = 'd',
   fixed = 'x1',
   center = 'x1 x2',
   model = 'yjt(y - 9) ~ x1 x2 d',
   seed = 90291,
   burn = 1000,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel, 'y')
