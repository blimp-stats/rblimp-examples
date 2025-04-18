library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.22.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   weight = 'wght',
   model = 'y ~ x1 x2 x3',
   seed = 90291,
   burn = 1000,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel, 'y')
