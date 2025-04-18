library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.11.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   ordinal = 'y d',
   fixed = 'd',
   center = 'x1 x2',
   model = 'y ~ x1 x2 d',
   seed = 90291,
   burn = 1000,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel, 'y')
