library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/data3.rda', 'rb')
load(connect); close(connect)

mymodel <- rblimp(
   data = data3,
   ordinal = 'd a3',
   fixed = 'd',
   center = 'x',
   model = ' 
   focal.model:
   y ~ x d;
   auxiliary.model:
   a1 ~ y x d;
   a2 ~ a1 y x d;
   a3 ~ a1 a2 x d',
   seed = 90291,
   burn = 1000,
   iter = 10000)
output(mymodel)


