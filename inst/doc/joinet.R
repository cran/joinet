## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
set.seed(1)

## ----eval=FALSE----------------------------------------------------------
#  install.packages("joinet")

## ----eval=FALSE----------------------------------------------------------
#  #install.packages("devtools")
#  devtools::install_github("rauschenberger/joinet")

## ------------------------------------------------------------------------
library(joinet)

## ----eval=FALSE----------------------------------------------------------
#  ?joinet
#  help(joinet)
#  browseVignettes("joinet")

## ------------------------------------------------------------------------
n <- 100
q <- 2
p <- 500

## ------------------------------------------------------------------------
mu <- rep(0,times=p)
rho <- 0.90
Sigma <- rho^abs(col(diag(p))-row(diag(p)))
X <- MASS::mvrnorm(n=n,mu=mu,Sigma=Sigma)

## ------------------------------------------------------------------------
pi <- 0.01
alpha <- 0
beta <- rbinom(n=p,size=1,prob=pi)

## ----results="hide"------------------------------------------------------
eta <- alpha + X %*% beta
eta <- 1.5*scale(eta)
family <- "gaussian"

if(family=="gaussian"){
  mean <- eta
  Y <- replicate(n=q,expr=rnorm(n=n,mean=mean))
}

if(family=="binomial"){
  prob <- 1/(1+exp(-eta))
  Y <- replicate(n=q,expr=rbinom(n=n,size=1,prob=prob))
}

if(family=="poisson"){
  lambda <- exp(eta)
  Y <- replicate(n=q,expr=rpois(n=n,lambda=lambda))
}

cor(Y)

## ------------------------------------------------------------------------
object <- joinet(Y=Y,X=X,family=family)

## ----eval=FALSE----------------------------------------------------------
#  predict(object,newx=X)
#  
#  coef(object)
#  
#  weights(object)

## ------------------------------------------------------------------------
cv.joinet(Y=Y,X=X,family=family)

## ----eval=FALSE----------------------------------------------------------
#  #install.packages("plsgenomics")
#  data(Ecoli,package="plsgenomics")
#  X <- Ecoli$CONNECdata
#  Y <- Ecoli$GEdata
#  loss <- cv.joinet(Y=Y,X=X)
#  
#  #install.packages("BiocManager")
#  #BiocManager::install("mixOmics")
#  data(liver.toxicity,package="mixOmics")
#  X <- liver.toxicity$gene
#  Y <- liver.toxicity$clinic
#  Y$Cholesterol.mg.dL. <- -Y$Cholesterol.mg.dL.
#  loss <- cv.joinet(Y=Y,X=X)

