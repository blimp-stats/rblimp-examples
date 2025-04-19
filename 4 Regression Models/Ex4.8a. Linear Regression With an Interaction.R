library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.8.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   ordinal = 'd',
   nominal = 'm',
   fixed = 'm',
   center = 'x d',
   model = 'y ~ x m x*m d',
   simple = 'x | m',
   seed = 90291,
   burn = 1000,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel,'y')
simple_plot(y ~ x | m.1, mymodel)
