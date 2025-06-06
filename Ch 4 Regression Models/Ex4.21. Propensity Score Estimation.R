library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.21.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   ordinal = 'd',
   fixed = 'x2 x3',
   model = '
   focal.model:
   y ~ d;
   propensity.model:
   logit(d) ~ x1 x2 x3 x4 x1*x2 x1*x3 x1*x4 x2*x3 x2*x4 x3*x4',
   seed = 90291,
   burn = 2000,
   iter = 10000,
   chains = 20,
   nimps = 20)

output(mymodel)
posterior_plot(mymodel)
