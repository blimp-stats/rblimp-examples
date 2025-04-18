library(fdir)
library(rblimp)

set()
load(file = 'data1.rda')

mymodel <- rblimp(
   data = data1,
   model = '
   x1 y1 y2 <-> x1 y1 y2;
   x1 ~~ x1@varx1;
   y1 ~~ y1@vary1;
   y2 ~~ y2@vary2',
   parameters = 'sd_x1 = sqrt(varx1);
   sd_y1 = sqrt(vary1);
   sd_y2 = sqrt(vary2)',
   seed = 90291,
   burn = 10000,
   iter = 10000)
output(mymodel)


