library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.8.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   ordinal = 'd',
   nominal = 'm',
   fixed = 'm',
   center = 'x d',
   model = 'y ~ x m x*m d',
   simple = 'x | m',
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
mean_x <- mean(unlist(lapply(implist, function(data) mean(data$x))))
mean_d <- mean(unlist(lapply(implist, function(data) mean(data$d))))

# analysis and pooling with mitml
results <- with(implist, lm(y ~ I(x - mean_x) + m + I(x - mean_x):m + I(d - mean_d)))
testEstimates(results, extra.pars = T, df.com = 295)
