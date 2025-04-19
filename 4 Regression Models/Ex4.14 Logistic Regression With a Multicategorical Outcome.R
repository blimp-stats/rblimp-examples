library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.14.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   nominal = 'y',
   fixed = 'x2 x3',
   center = 'x1 x2 x3',
   model = 'logit(y) ~ x1 x2 x3',
   seed = 90291,
   burn = 2000,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel, 'y')
