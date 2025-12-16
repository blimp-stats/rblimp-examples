library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex7.3.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  ordinal = 'd2 d3 d4 d5 d6',
  latent = 'icept slope',
  model = '
   structural.model:
   icept ~ 1;
   slope ~ 1;
   icept <-> slope;
   measurement.model:
   y1 ~ 1@0 icept@1 slope@0;
   y2 ~ 1@0 icept@1 slope@1;
   y3 ~ 1@0 icept@1 slope@2;
   y4 ~ 1@0 icept@1 slope@3;
   y5 ~ 1@0 icept@1 slope@4;
   y6 ~ 1@0 icept@1 slope@5;
   y1@vconstraint;
   y2@vconstraint;
   y3@vconstraint;
   y4@vconstraint;
   y5@vconstraint;
   y6@vconstraint;
   dropout.model:
   d2 ~ icept@iconstraint slope@sconstraint;
   d3 ~ icept@iconstraint slope@sconstraint;
   d4 ~ icept@iconstraint slope@sconstraint;
   d5 ~ icept@iconstraint slope@sconstraint;
   d6 ~ icept@iconstraint slope@sconstraint',
  seed = 90291,
  burn = 100000,
  iter = 10000)

output(mymodel)
posterior_plot(mymodel)
