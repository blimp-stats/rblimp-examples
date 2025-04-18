connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.6.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(fdir)
library(rblimp)

set()
load(file = 'data2.rda')

mymodel <- rblimp_fcs(
   data = data2,
   ordinal = 'd1 d2',
   nominal = 'n1',
   fixed = 'x1 d2',
   variables = 'y1 x1 d1 d2 n1 x2',
   seed = 90291,
   burn = 1000,
   iter = 1000,
   chains = 20,
   nimps = 20)
output(mymodel)

# mitml list
implist <- as.mitml(mymodel)

# pooled grand means
mean_x1 <- mean(unlist(lapply(implist, function(data) mean(data$x1))))

# analysis and pooling with mitml
results <- with(implist, lm(y1 ~ I(x1 - mean_x1) + d1 + factor(n1)))
testEstimates(results, extra.pars = T, df.com = 1994)
                


