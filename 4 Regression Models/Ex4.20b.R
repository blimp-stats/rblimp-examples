library(fdir)
library(rblimp)

set()
load(file = 'data2.rda')

mymodel <- rblimp(
   data = data2,
   ordinal = 'd',
   fixed = 'x1',
   center = 'x1 x2',
   model = 'yjt(y - 9) ~ x1 x2 d',
   seed = 90291,
   burn = 1000,
   iter = 10000,
   chains = 20,
   nimps = 20)
output(mymodel)

# inspect variable names
names(mymodel@imputations[[1]])

# mitml list
implist <- as.mitml(mymodel)

# plot raw and transformed scores
dat2plot <- do.call(rbind, implist)
hist(dat2plot$y,breaks = 20)
hist(dat2plot$yjt.yjt.y.9..,breaks = 20)

# pooled grand means
mean_x1 <- mean(unlist(lapply(implist, function(data) mean(data$x1))))
mean_x2 <- mean(unlist(lapply(implist, function(data) mean(data$x2))))

# analyze skewed outcome
results <- with(implist, lm(y ~ I(x1 - mean_x1)  + I(x2 - mean_x2) + d))
testEstimates(results, extra.pars = T, df.com = 1996)

# analyze normalized outcome
results <- with(implist, lm(yjt.yjt.y.9.. ~ I(x1 - mean_x1)  + I(x2 - mean_x2) + d))
mitml::testEstimates(results, extra.pars = T, df.com = 1996)





