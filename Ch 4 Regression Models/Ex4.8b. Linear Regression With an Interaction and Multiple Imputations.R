library(rblimp)
library(mitml)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.8.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  ordinal = 'd',
  nominal = 'm',
  fixed = 'm',
  center = 'x',
  model = 'y ~ x m x*m d',
  simple = 'x | m',
  seed = 90291,
  burn = 10000,
  iter = 10000,
  nimps = 20)

output(mymodel)
posterior_plot(mymodel, 'y')
simple_plot(y ~ x | m, mymodel)

implist <- as.mitml(mymodel)

mean_x <- mean(unlist(lapply(implist, function(data) mean(data$x))))

results <- with(implist, lm(y ~ I(x - mean_x) + m + I(x - mean_x):m + d))
testEstimates(results, extra.pars = T, df.com = 295)
