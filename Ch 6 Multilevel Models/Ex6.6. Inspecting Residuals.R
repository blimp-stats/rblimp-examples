library(rblimp)
library(ggplot2)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.6.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   clusterid = 'level2id',
   center = '
    groupmean = x1_i;
    grandmean = x2_i',
   model = 'y_i ~ x1_i x2_i | x1_i',
   seed = 90291,
   burn = 10000,
   iter = 10000,
   nimps = 20)

output(mymodel)
posterior_plot(mymodel,'y_i')

# plot y residuals across x
residual_plot(mymodel,'y_i')

# inspect variable names
names(mymodel)

# unlist imputed data sets into a stacked file
dat2plot <- do.call(rbind, mymodel@imputations)
# plot level-1 residuals
hist(dat2plot$y_i.residual,breaks = 50)
# plot random intercepts
hist(dat2plot$"y_i[level2id]",breaks = 50)
# plot random slopes
hist(dat2plot$"y_i$x1_i[level2id]",breaks = 50)
