library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.4b.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  ordinal = 'm',
  center = 'x',
  model = '
    logit(m) ~ 1@m_icept x@alpha;
    y ~ m@beta x;',
  parameters = '
    xvalue1 = -.50;
    xvalue2 = 0;
    xvalue3 = .50;
    ab_xval1 = (alpha*exp(m_icept + alpha*xvalue1)) / 
      (1 + exp(m_icept + alpha*xvalue1))^2 * beta;
    ab_xval2 = (alpha*exp(m_icept + alpha*xvalue2)) / 
      (1 + exp(m_icept + alpha*xvalue2))^2 * beta;
    ab_xval3 = (alpha*exp(m_icept + alpha*xvalue3)) / 
      (1 + exp(m_icept + alpha*xvalue3))^2 * beta',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel)
posterior_plot(mymodel,'ab_xval1')
posterior_plot(mymodel,'ab_xval2')
posterior_plot(mymodel,'ab_xval3')
posterior_plot(mymodel)
