library(rblimp)
library(mitml)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.20.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  ordinal = 'd',
  fixed = 'x1',
  center = 'x1 x2',
  model = 'yjt(y - 9) ~ x1 x2 d',
  seed = 90291,
  burn = 10000,
  iter = 10000,
  nimps = 20)

output(mymodel)
posterior_plot(mymodel, 'y')

names(mymodel)

implist <- as.mitml(mymodel)

dat2plot <- do.call(rbind, implist)
hist(dat2plot$y,breaks = 20)
hist(dat2plot$y.yjt,breaks = 20)

mean_x1 <- mean(unlist(lapply(implist, function(data) mean(data$x1))))
mean_x2 <- mean(unlist(lapply(implist, function(data) mean(data$x2))))

results <- with(implist, lm(y ~ I(x1 - mean_x1)  + I(x2 - mean_x2) + d))
testEstimates(results, extra.pars = T, df.com = 1996)

results <- with(implist, lm(y.yjt ~ I(x1 - mean_x1)  + I(x2 - mean_x2) + d))
testEstimates(results, extra.pars = T, df.com = 1996)

