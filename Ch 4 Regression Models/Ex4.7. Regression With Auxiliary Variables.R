library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.7.RDS', 'rb')
data <- readRDS(connect); close(connect)

# manual sequential specification of auxiliary variables
mymodel <- rblimp(
  data = data,
  ordinal = 'd a3',
  fixed = 'd',
  center = 'x',
  model = ' 
   focal.model:
   y ~ x d;
   auxiliary.model:
   a1 ~ y x d;
   a2 ~ a1 y x d;
   a3 ~ a1 a2 x d',
  seed = 90291,
  burn = 1000,
  iter = 10000)

# automatic sequential specification
mymodel <- rblimp(
   data = data,
   ordinal = 'd a3',
   fixed = 'd',
   center = 'x',
   model = ' 
   focal.model:
   y ~ x d;
   auxiliary.model:
   a3 a2 a1 ~ y x d',
   seed = 90291,
   burn = 1000,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel, 'y')
