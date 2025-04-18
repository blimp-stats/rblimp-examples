library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.2.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(lme4)
library(mitml)

mymodel <- rblimp_fcs(
   data = data,
   clusterid = 'level2id',
   ordinal = 'd1_i d2_j',
   fixed = 'x2_i d2_j',
   variables = 'y_i x1_i x2_i d1_i x3_j d2_j',
   seed = 90291,
   burn = 2000,
   iter = 10000,
   chains = 20,
   nimps = 20)

output(mymodel)

# mitml list
implist <- as.mitml(mymodel)

# analysis and pooling with mitml
results <- with(implist, lmer('y_i ~ x1_i + x2_i + d1_i + x3_j + d2_j + (1|level2id)', REML = T))
testEstimates(results, extra.pars = T)


posterior_plot(mymodel)
