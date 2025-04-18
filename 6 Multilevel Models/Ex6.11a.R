library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.11.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   clusterid = 'level2id',
   center = 'groupmean = x_i;
   grandmean = m_j',
   model = 'y_i ~ x_i m_j x_i*m_j | x_i',
   simple = 'x_i | m_j',
   seed = 90291,
   burn = 10000,
   iter = 10000)

output(mymodel)


posterior_plot(mymodel)
