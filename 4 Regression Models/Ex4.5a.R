library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/data2.rda', 'rb')
load(connect); close(connect)

mymodel <- rblimp(
   data = data2,
   ordinal = 'd',
   nominal = 'n',
   fixed = 'x',
   center = 'x',
   model = 'y ~ x d n',
   seed = 90291,
   burn = 2000,
   iter = 10000)
output(mymodel)


