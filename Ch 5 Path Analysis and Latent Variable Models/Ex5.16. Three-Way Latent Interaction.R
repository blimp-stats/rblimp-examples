library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.16.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  ordinal = 'x1:x10 z1:z10 m1:m10 y1:y23',
  latent = 'latentx latentm latentz latenty',
  model = '
    y.model:
    latenty ~ latentx@b1 latentz@b2 latentm@b3
      latentx*latentz@b4 latentx*latentm@b5 latentz*latentm@b6
      latentx*latentz*latentm@b7;
    latenty@1;
    predictor.model:
    latentx latentz latentm ~~ latentx latentz latentm;
    latentx@1;
    latentz@1;
    latentm@1;
    measurement.models:
    latentx -> x1@xload_prior x2:x10;
    latentz -> z1@zload_prior z2:z10;
    latentm -> m1@mload_prior m2:m10;
    latenty -> y1@yload_prior y2:y10',
  simple = 'latentx | latentm and latentz',
  parameters = '
    xload_prior ~ truncate(0, Inf);
    zload_prior ~ truncate(0, Inf);
    mload_prior ~ truncate(0, Inf);
    yload_prior ~ truncate(0, Inf);',
  seed = 90291,
  burn = 50000,
  iter = 50000
)

output(mymodel)
posterior_plot(mymodel)
simple_plot(latenty ~ latentx | latentm + latentz, mymodel)
