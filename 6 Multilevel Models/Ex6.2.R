library(fdir)
library(rblimp)
library(lme4)
library(mitml)

set()
load(file = 'data7.rda')

mymodel <- rblimp_fcs(
   data = data7,
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


