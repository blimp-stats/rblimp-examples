library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex7.1.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   ordinal = 'd1 d2',
   fixed = 'd1 d2',
   center = 'x1',
   model = ' 
   y ~ d1 d2 x1;
   x2 x3 ~ y d1 d2 x1;
   y.missing ~ y d1',
   seed = 90291,
   burn = 2500,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel)
