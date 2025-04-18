library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex7.2.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   ordinal = 'd1 d2 ymis',
   center = 'x1 d2',
   transform = 'ymis = ismissing(y)',
   model = '
   focal.model:
   y ~ 1@b0obs ymis@b0diff d1 d2 x1 ;
   y ~~ y@resvar;
   predictor.model:
   ymis ~ 1@ymissmean;
   x1 d1 d2 ~ ymis;
   auxiliary.model:
   x2 x3 ~ y d1 d2 x1',
   parameters = 'cohensd = .20;
   b0diff = cohensd * sqrt(resvar);
   p_mis = phi(ymissmean);
   p_obs = 1 - p_mis;
   b0_obs = b0obs;
   b0_mis = b0obs + b0diff;
   b0 = (b0_obs * p_obs) + (b0_mis * p_mis)',
   seed = 90291,
   burn = 2000,
   iter = 10000)

output(mymodel)


posterior_plot(mymodel)
