library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.5.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   ordinal = 'd',
   nominal = 'n',
   fixed = 'x',
   center = 'x',
   model = 'y ~ x d n',
   seed = 90291,
   burn = 2000,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel, 'y')
