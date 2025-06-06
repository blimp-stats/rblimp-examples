library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.2.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   ordinal = 'd1 o1',
   model = 'd1 o1 y1 x1 <-> d1 o1 y1 x1',
   seed = 90291,
   burn = 30000,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel)
