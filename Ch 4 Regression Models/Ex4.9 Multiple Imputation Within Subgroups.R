library(rblimp)
library(mitml)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.9.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp_fcs(
  data = data,
  ordinal = 'd',
  variables = 'a1:a3 y x d',
  seed = 90291,
  burn = 10000,
  iter = 10000,
  nimps = 20
  ) |> by_group('group')

# view output
lapply(mymodel,output)

# mitml list
implist <- as.mitml(mymodel)

# inspect variable names
names(implist[[1]])

# pooled grand means
mean_x <- mean(unlist(lapply(implist, function(data) mean(data$x))))

# analysis and pooling with mitml
results <- with(implist, lm(y ~ I(x - mean_x) + group + I(x - mean_x):group + d))
testEstimates(results, extra.pars = T, df.com = 295)
