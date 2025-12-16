library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.11.RDS', 'rb')
data <- readRDS(connect); close(connect)

# library(semTools)
library(lavaan)
library(lavaan.mi)

mymodel <- rblimp(
  data = data,
  latent = 'latentx latenty',
  model = '
   structural.model:
   latentx@1;
   latenty@1;
   latentx ~~ latenty;
   measurement.models:
   latentx -> x1 x3;
   yjt(x2) ~ latentx;
   yjt(y1) ~ latenty;
   latenty -> y2 y3',
  seed = 90291,
  burn = 10000,
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
hist(dat2plot$y1,breaks = 20)
hist(dat2plot$y1.yjt,breaks = 20)

# specify cfa model with latent response imputations
lavaan_model <- c('ylatent =~ x1 + x2.yjt + x3',
                  'xlatent =~ y1.yjt + y2 + y3',
                  'ylatent ~~ xlatent', 'ylatent ~~ 1*ylatent','xlatent ~~ 1*xlatent')

# fit model with semtools and lavaan
results <- cfa.mi(lavaan_model, data = implist, estimator = "ml")
summary(results, standardized = T, fit = T)

# imputation-based modification indices
modindices.mi(results, op = c("~~","=~"), minimum.value = 3, sort. = T)
