library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.11.RDS', 'rb')
data <- readRDS(connect); close(connect)

# standard analysis
mymodel <- rblimp(
  data = data,
  ordinal = 'y d',
  fixed = 'd',
  center = 'x1 x2',
  model = 'y ~ x1 x2 d',
  seed = 90291,
  burn = 1000,
  iter = 10000)

output(mymodel)
posterior_plot(mymodel, 'y')

# analysis with predicted probabilities
mymodel <- rblimp(
   data = data,
   ordinal = 'y d',
   fixed = 'd',
   center = 'x1 x2',
   model = 'y ~ 1@b0 x1 x2 d@b3',
   parameters = '
    # conditional predicted probabilities
    pp_d0 = phi(b0);
    pp_d1 = phi(b0 + b3);
    pp_diff = pp_d1 - pp_d0',
   seed = 90291,
   burn = 1000,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel, 'y')

# inspect variable names
names(mymodel@average_imp)

# population-average predicted probabilities
aggregate(y.1.probability ~ round(d), data = mymodel@average_imp, FUN = mean)
