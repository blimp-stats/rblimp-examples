library(rblimp)
library(metafor)

# effect size data from metafor
data <- dat.raudenbush1985

# random effects meta analysis
mymodel <- rblimp(
  data = data,
  transform = 'log_vi = ln(vi)',
  clusterid = 'study',
  latent = 'study = alpha_i',
  model = '
    alpha_i ~ intercept;
    yi ~ intercept@alpha_i;
    var(yi) ~ 1@0 # fix variance of each study
      (study==1)*log_vi@1
      (study==2)*log_vi@1 
      (study==3)*log_vi@1 
      (study==4)*log_vi@1
      (study==5)*log_vi@1
      (study==6)*log_vi@1
      (study==7)*log_vi@1
      (study==8)*log_vi@1
      (study==9)*log_vi@1
      (study==10)*log_vi@1
      (study==11)*log_vi@1
      (study==12)*log_vi@1
      (study==13)*log_vi@1
      (study==14)*log_vi@1
      (study==15)*log_vi@1
      (study==16)*log_vi@1
      (study==17)*log_vi@1
      (study==18)*log_vi@1
      (study==19)*log_vi@1;',
  seed = 90291,
  burn = 10000,
  iter = 10000
)

output(mymodel)
