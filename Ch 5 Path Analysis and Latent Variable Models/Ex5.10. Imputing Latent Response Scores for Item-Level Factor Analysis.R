library(rblimp)
library(lavaan.mi)
library(lavaan)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.10.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp_fcs(
  data = data,
  ordinal = 'x1:x6 y1:y6',
  variables = 'x1:x6 y1:y6',
  seed = 90291,
  burn = 40000,
  iter = 40000,
  nimps = 20)

output(mymodel)

names(mymodel)

implist <- as.mitml(mymodel)

lavaan_model <- c(
  paste('ylatent =~', paste0('y', 1:6, '.latent', collapse = ' + ')),
  paste('xlatent =~', paste0('x', 1:6, '.latent', collapse = ' + ')),
  'ylatent ~~ xlatent', 'ylatent ~~ 1*ylatent','xlatent ~~ 1*xlatent')

results <- cfa.mi(lavaan_model, data = implist, estimator = "ml")
summary(results, standardized = T, fit = T)

modindices.mi(results, op = c("~~","=~"), minimum.value = 3, sort. = T)
