library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.16.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   ordinal = 'd1 d2',
   count = 'y',
   transform = 'y = missing(ycnt == 0, ycnt);
     ybin = ifelse(ycnt == 0, 0, 1)',
   fixed = 'd1 x1',
   center = 'x1 x2',
   model = ' 
     y ~ d1 d2 x1 x2;
     ybin ~ d1 d2 x1 x2',
   seed = 90291,
   burn = 5000,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel)
