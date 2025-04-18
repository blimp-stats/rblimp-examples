library(rblimp)

mymodel <- rblimp(
   data = data,
   ordinal = 'y1:y6',
   latent = 'ability',
   model = '
   ability ~ 1@0;
   ability ~~ ability@1;
   y1 ~ 1@icept1 ability@load1;
   y2 ~ 1@icept2 ability@load2;
   y3 ~ 1@icept3 ability@load3;
   y4 ~ 1@icept4 ability@load4;
   y5 ~ 1@icept5 ability@load5;
   y6 ~ 1@icept6 ability@load6',
   parameters = 'discrim1 = load1;
   discrim2 = load2;
   discrim3 = load3;
   discrim4 = load4;
   discrim5 = load5;
   discrim6 = load6;
   difficulty1 = - icept1 / load1;
   difficulty2 = - icept2 / load2;
   difficulty3 = - icept3 / load3;
   difficulty4 = - icept4 / load4;
   difficulty5 = - icept5 / load5;
   difficulty6 = - icept6 / load6',
   seed = 90291,
   burn = 3000,
   iter = 10000)

output(mymodel)


posterior_plot(mymodel)
