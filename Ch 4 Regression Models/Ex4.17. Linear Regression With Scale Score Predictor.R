library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.17.RDS', 'rb')
data <- readRDS(connect); close(connect)

# sum score as predictor
mymodel <- rblimp(
   data = data,
   ordinal = 'x1:x7 d1 d2',
   model = '
   focal.model:
   sum_score = x1:+:x7; 
   yscale ~  sum_score d1 d2; 
   predictor.model:
   x1:x7 d1 d2 ~ 1', 
   seed = 90291,
   burn = 5000,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel, 'yscale')

# sum score as predictor and y items as auxiliary variables
mymodel <- rblimp(
  data = data,
  ordinal = 'y1:y5 x1:x7 d1 d2',
  model = '
   focal.model:
   sum_score = x1:+:x7;
   yscale ~  sum_score d1 d2;
   predictor.model:
   x1:x7 d1 d2 ~ 1; 
   auxiliary.models:
   y1:y5 ~ yscale',
  seed = 90291,
  burn = 20000,
  iter = 10000)

output(mymodel)
posterior_plot(mymodel, 'yscale')
