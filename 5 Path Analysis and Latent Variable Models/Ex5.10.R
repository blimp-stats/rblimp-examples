connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.10.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(fdir)
library(rblimp)
library(semTools)
library(lavaan)

set()
load(file = 'data4.rda')

mymodel <- rblimp_fcs(
   data = data4,
   ordinal = 'x1:x6 y1:y6',
   variables = 'x1:x6 y1:y6',
   seed = 90291,
   burn = 25000,
   iter = 10000,
   chains = 20,
   nimps = 20)
output(mymodel)

# inspect variable names
names(mymodel@imputations[[1]])

# mitml list
implist <- as.mitml(mymodel)

# specify cfa model with latent response imputations
lavaan_model <- c(
  paste('ylatent =~', paste0('y', 1:6, '.latent', collapse = ' + ')),
  paste('xlatent =~', paste0('x', 1:6, '.latent', collapse = ' + ')),
  'ylatent ~~ xlatent', 'ylatent ~~ 1*ylatent','xlatent ~~ 1*xlatent')

# fit model with semtools and lavaan
results <- cfa.mi(lavaan_model, data = implist, estimator = "ml")
summary(results, standardized = T, fit = T)

# imputation-based modification indices
modindices.mi(results, op = c("~~","=~"), minimum.value = 3, sort. = T)
