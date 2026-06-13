library(rblimp)
library(mitml)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.13.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel1 <- rblimp(
  data = data,
  ordinal = 'y d',
  fixed = 'd',
  center = 'x1 x2',
  model = 'logit(y) ~ x1 x2 d',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel1)
posterior_plot(mymodel1, 'y')

mymodel2 <- rblimp(
  data = data,
  ordinal = 'd',
  nominal = 'y',
  fixed = 'd',
  center = 'x1 x2',
  model = 'y ~ x1 x2 d',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel2)
posterior_plot(mymodel2, 'y')

mymodel3 <- rblimp(
  data = data,
  ordinal = 'd',
  nominal = 'y',
  fixed = 'd',
  center = 'x1 x2',
  model = 'y ~ 1@b0 x1 x2 d@b3',
  parameters = '
    pp_d0 = exp(b0) / (1 + exp(b0));
    pp_d1 = exp(b0 + b3) / (1 + exp(b0 + b3));
    pp_diff = pp_d1 - pp_d0',
  seed = 90291,
  burn = 10000,
  iter = 10000,
  nimps = 20)

output(mymodel3)
posterior_plot(mymodel3, 'y')

names(mymodel3)

implist <- as.mitml(mymodel3)
results <- with(implist, lm(y.1.probability ~ 0 + d + I(1 - d)))
testEstimates(results)
confint.mitml.testEstimates(testEstimates(results))
testConstraints(results, constraints = c("d - `I(1 - d)`"))
