library(rblimp)
library(mitml)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.4.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
  ordinal = 'd',
  fixed = 'd',
  center = 'x1 x2',
  model = 'y ~ x1 x2 d',
  seed = 90291,
  burn = 1000,
  iter = 10000,
  chains = 20,
  nimps = 20)

output(mymodel)
posterior_plot(mymodel, 'y')

# mitml list
implist <- as.mitml(mymodel)

# pooled grand means
mean_x1 <- mean(unlist(lapply(implist, function(data) mean(data$x1))))
mean_x2 <- mean(unlist(lapply(implist, function(data) mean(data$x2))))

# analysis and pooling with mitml
results <- with(implist, lm(y ~ I(x1 - mean_x1) + I(x2 - mean_x2) + d))
testEstimates(results, extra.pars = T, df.com = 626)
posterior_plot(mymodel)
