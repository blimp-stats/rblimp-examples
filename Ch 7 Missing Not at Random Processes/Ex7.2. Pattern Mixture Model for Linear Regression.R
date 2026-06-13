library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex7.2.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel1 <- rblimp(
  data = data,
  ordinal = 'd1 d2 ymis',
  center = 'x1',
  transform = 'ymis = ismissing(y)',
  model = '
    focal.model:
    y ~ 1@b0obs ymis@b0diff d1 d2 x1 ;
    y@resvar;
    predictor.model:
    ymis ~ 1@ymissmean;
    x1 d1 d2 ~ ymis;
    auxiliary.model:
    x2 x3 ~ y d1 d2 x1',
  parameters = '
    cohensd = .20;
    b0diff = cohensd * sqrt(resvar);
    p_mis = phi(ymissmean);
    p_obs = 1 - p_mis;
    b0_obs = b0obs;
    b0_mis = b0obs + b0diff;
    b0 = (b0_obs * p_obs) + (b0_mis * p_mis)',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel1)
posterior_plot(mymodel1)

mymodel2 <- rblimp(
  data = data,
  ordinal = 'd1 d2 m.y',
  transform = 'm.y = ismissing(y)',
  center = 'x1',
  model = '
    focal.model:
    y ~ 1@b0obs m.y@b0diff d1@b1obs d1*m.y@b1diff d2 x1;
    y@resvar;
    predictor.model:
    m.y ~ 1@ymissmean;
    x1 d1 d2 ~ m.y;
    auxiliary.model:
    x2 x3 ~ y x1 d1 d2',
  parameters = '
    cohensd = .20;
    b0diff = cohensd * sqrt(resvar);
    b1diff = - cohensd * sqrt(resvar);
    p.mis = phi(ymissmean);
    p.obs = 1 - p.mis ;
    b0.obs = b0obs;
    b0.mis = b0obs + b0diff;
    b1.obs = b1obs;
    b1.mis = b1obs + b1diff;
    b0 = (b0.obs * p.obs) + (b0.mis * p.mis);
    b1 = (b1.obs * p.obs) + (b1.mis * p.mis)',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel2)
posterior_plot(mymodel2)
