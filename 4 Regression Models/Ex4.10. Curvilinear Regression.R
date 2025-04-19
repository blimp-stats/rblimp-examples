library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.10.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   ordinal = 'd1 d2',
   fixed = 'd1 x2',
   center = 'x1 x2',
   model = 'y ~ x1 (x1^2) x2 d1 d2',
   seed = 12345,
   burn = 1000,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel, 'y')