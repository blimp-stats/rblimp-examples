library(fdir)
library(rblimp)

set()

load(file = 'data8.rda')
mymodel <- rblimp(
   data = data8,
   clusterid = 'level2id',
   center = 'groupmean = x1_i;
   grandmean = x2_i',
   model = ' y_i ~ x1_i x2_i | x1_i',
   seed = 90291,
   burn = 5000,
   iter = 10000,
   chains = 20,
   nimps = 20)
output(mymodel)

# inspect variable names in imputed data
names(mymodel@imputations[[1]])

# plot imputations
dat2plot <- do.call(rbind, mymodel@imputations)
# random intercepts
hist(dat2plot$y_i.level2id.,breaks = 50)
plot(density(dat2plot$y_i.level2id.))
# random slopes
hist(dat2plot$y_i.x1_i.level2id.,breaks = 50)
plot(density(dat2plot$y_i.x1_i.level2id.))


