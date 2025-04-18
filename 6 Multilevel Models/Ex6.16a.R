library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.16.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   nominal = 'd_k',
   clusterid = 'level2id level3id',
   fixed = 'time_i d_k',
   model = 'y_i ~ time_i d_k time_i*d_k | time_i',
   simple = 'time_i | d_k',
   seed = 90291,
   burn = 15000,
   iter = 10000)

output(mymodel)


posterior_plot(mymodel)
