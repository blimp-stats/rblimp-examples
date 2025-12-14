library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.24.RDS', 'rb')
data <- readRDS(connect); close(connect)

# random effects meta analysis
mymodel <- rblimp(
  data = data,
  transform = 'log_varj = ln(var_j)',
  clusterid = 'study',
  latent = 'study = beta0_j',
  model = '
    beta0_j ~ intercept;
    es_j ~ intercept@beta0_j;
    var(es_j) ~ 1@0 # fix variance of each study
      (study==1)*log_varj@1
      (study==2)*log_varj@1 
      (study==3)*log_varj@1 
      (study==4)*log_varj@1
      (study==5)*log_varj@1
      (study==6)*log_varj@1
      (study==7)*log_varj@1
      (study==8)*log_varj@1
      (study==9)*log_varj@1
      (study==10)*log_varj@1
      (study==11)*log_varj@1
      (study==12)*log_varj@1
      (study==13)*log_varj@1
      (study==14)*log_varj@1
      (study==15)*log_varj@1
      (study==16)*log_varj@1
      (study==17)*log_varj@1
      (study==18)*log_varj@1
      (study==19)*log_varj@1;',
  seed = 90291,
  burn = 10000,
  iter = 10000
)

output(mymodel)
