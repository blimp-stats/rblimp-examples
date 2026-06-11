library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex7.3.RDS', 'rb')
data <- readRDS(connect); close(connect)
names(data)[match(c("d1","d2", "d3", "d4", "d5","d6"), names(data))] <- c("m1","m2", "m3", "m4", "m5","m6")

mymodel <- rblimp(
  data = data,
  ordinal = 'm2:m6',
  latent = 'icept slope',
  model = '
   structural.model:
   icept ~ 1;
   slope ~ 1;
   icept <-> slope;
   measurement.model:
   icept -> y1@1 y2@1 y3@1 y4@1 y5@1 y6@1;
   slope -> y1@0 y2@1 y3@2 y4@3 y5@4 y6@5;
   1 -> y1@0 y2@0 y3@0 y4@0 y5@0 y6@0;
   y1@vconstraint;
   y2@vconstraint;
   y3@vconstraint;
   y4@vconstraint;
   y5@vconstraint;
   y6@vconstraint;
   dropout.model:
   m2 ~ icept@iconstraint slope@sconstraint;
   m3 ~ icept@iconstraint slope@sconstraint;
   m4 ~ icept@iconstraint slope@sconstraint;
   m5 ~ icept@iconstraint slope@sconstraint;
   m6 ~ icept@iconstraint slope@sconstraint',
  seed = 90291,
  burn = 100000,
  iter = 100000)

output(mymodel)
posterior_plot(mymodel)
