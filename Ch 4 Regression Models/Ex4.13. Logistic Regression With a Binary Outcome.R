library(rblimp)
library(mitml)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.13.RDS', 'rb')
data <- readRDS(connect); close(connect)

# standard analysis
mymodel <- rblimp(
   data = data,
   ordinal = 'y d',
   fixed = 'd',
   center = 'x1 x2',
   model = 'logit(y) ~ x1 x2 d',
   seed = 90291,
   burn = 2000,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel, 'y')

# analysis with predicted probabilities
mymodel <- rblimp(
  data = data,
  ordinal = 'y d',
  fixed = 'd',
  center = 'x1 x2',
  model = 'logit(y) ~ 1@b0 x1 x2 d@b3',
  parameters = '
  # conditional predicted probabilities
   pp_d0 = exp(b0) / (1 + exp(b0));
   pp_d1 = exp(b0 + b3) / (1 + exp(b0 + b3));
   pp_diff = pp_d1 - pp_d0',
  seed = 90291,
  burn = 2000,
  iter = 10000,
  nimps = 20,
  chains = 20)

output(mymodel)
posterior_plot(mymodel, 'y')

# inspect variable names
names(mymodel@imputations[[1]])

# compare marginal predicted probabilities by group
implist <- as.mitml(mymodel)
results <- with(implist, lm(y.predicted ~ 0 + d + I(1 - d)))
testEstimates(results)
confint.mitml.testEstimates(testEstimates(results))
testConstraints(results, constraints = c("d - `I(1 - d)`"))
