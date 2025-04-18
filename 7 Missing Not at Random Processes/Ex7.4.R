library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex7.4.RDS', 'rb')
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
   y1 ~~ y1@vconstraint;
   y2 ~~ y2@vconstraint;
   y3 ~~ y3@vconstraint;
   y4 ~~ y4@vconstraint;
   y5 ~~ y5@vconstraint;
   y6 ~~ y6@vconstraint;
   dropout.model:
   d2 ~ y1@marconstraint y2@mnarconstraint;
   d3 ~ y2@marconstraint y3@mnarconstraint;
   d4 ~ y3@marconstraint y4@mnarconstraint;
   d5 ~ y4@marconstraint y5@mnarconstraint;
   d6 ~ y5@marconstraint y6@mnarconstraint',
   seed = 90291,
   burn = 100000,
   iter = 10000)

output(mymodel)


posterior_plot(mymodel)
