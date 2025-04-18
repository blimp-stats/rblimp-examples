library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.21.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   ordinal = 'y_i',
   clusterid = 'level2id',
   fixed = 'time_i',
   model = '
   logit(y_i) ~ 1@0 (time_i==1)@alpha1 (time_i==2)@alpha2 (time_i==3)@alpha3
      (time_i==4)@alpha4 (time_i==5)@alpha5 (time_i==6)@alpha6 | 1@0',
   parameters = 'hazard.1 = exp(alpha1) / (1 + exp(alpha1));
   hazard.2 = exp(alpha2) / (1 + exp(alpha2));
   hazard.3 = exp(alpha3) / (1 + exp(alpha3));
   hazard.4 = exp(alpha4) / (1 + exp(alpha4));
   hazard.5 = exp(alpha5) / (1 + exp(alpha5));
   hazard.6 = exp(alpha6) / (1 + exp(alpha6))',
   seed = 90291,
   burn = 2000,
   iter = 10000)

output(mymodel)


posterior_plot(mymodel)
