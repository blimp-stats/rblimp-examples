library(fdir)
library(rblimp)

set()
load(file = 'RICLPM.rda')

mymodel <- rblimp(
   data = RICLPM,
   ordinal = 'z1',
   latent = 'RIx RIy',
   model = ' 
   x1r = x1 - (RIx + z1*a1);
   x2r = x2 - (RIx + z1*a2);
   x3r = x3 - (RIx + z1*a3);
   x4r = x4 - (RIx + z1*a4);
   y1r = y1 - (RIy + z1*b1);
   y2r = y2 - (RIy + z1*b2);
   y3r = y3 - (RIy + z1*b3);
   y4r = y4 - (RIy + z1*b4);
   random.intercept:
   RIx ~~ RIy;
   x.models:
   x1 ~ RIx@1 z1@a1;
   x2 ~ x1r y1r RIx@1 z1@a2;
   x3 ~ x2r y2r RIx@1 z1@a3;
   x4 ~ x3r y3r RIx@1 z1@a4;
   x5 ~ x4r y4r RIx@1 z1@a5;
   y.models:
   y1 ~ RIy@1 z1@b1;
   y2 ~ x1r y1r RIy@1 z1@b2;
   y3 ~ x2r y2r RIy@1 z1@b3;
   y4 ~ x3r y3r RIy@1 z1@b4;
   y5 ~ x4r y4r RIy@1 z1@b5;
   covariances:
   x1 ~~ y1;
   x2 ~~ y2;
   x3 ~~ y3;
   x4 ~~ y4;
   x5 ~~ y5',
   seed = 90291,
   burn = 5000,
   iter = 10000)
output(mymodel)


