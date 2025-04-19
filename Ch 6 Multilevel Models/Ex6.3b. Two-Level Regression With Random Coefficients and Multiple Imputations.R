library(rblimp)
library(lme4)
library(mitml)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.3.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   clusterid = 'level2id',
   ordinal = 'd_j',
   fixed = 'd_j',
   center = '
    groupmean = x1_i;
    grandmean = x2_i x3_j d_j',
   model = 'y_i ~ x1_i x2_i x3_j d_j | x1_i',
   seed = 90291,
   burn = 5000,
   iter = 10000,
   chains = 20,
   nimps = 20)

output(mymodel)
posterior_plot(mymodel,'y_i')

# inspect variable names
names(mymodel@imputations[[1]])

# mitml list
implist <- as.mitml(mymodel)

# pooled grand means
mean_x2 <- mean(unlist(lapply(implist, function(data) mean(data$x2_i))))
mean_x3 <- mean(unlist(lapply(implist, function(data) mean(data$x3_j))))
mean_d <- mean(unlist(lapply(implist, function(data) mean(data$d_j))))

# center at latent cluster means
for (i in 1:length(implist)) {
  implist[[i]]$x1cwc_i <- implist[[i]]$x1_i - implist[[i]]$x1_i.mean.level2id.
}

# analysis and pooling with mitml
results <- with(implist, 
                lmer('y_i ~ x1cwc_i + I(x2_i - mean_x2) + I(x3_j - mean_x3) + I(d_j - mean_d) + (1 + x1cwc_i|level2id)', 
                REML = T))
testEstimates(results, extra.pars = T)
