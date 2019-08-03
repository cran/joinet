## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval=FALSE----------------------------------------------------------
#  install.packages("joinet")

## ----eval=FALSE----------------------------------------------------------
#  #install.packages("devtools")
#  devtools::install_github("rauschenberger/joinet")

## ----eval=FALSE----------------------------------------------------------
#  ?joinet
#  help(joinet)

## ----eval=FALSE----------------------------------------------------------
#  #install.packages("plsgenomics")
#  data(Ecoli,package="plsgenomics")
#  X <- Ecoli$CONNECdata
#  Y <- Ecoli$GEdata
#  loss <- joinet:::cv.joinet(Y=Y,X=X)

## ----eval=FALSE----------------------------------------------------------
#  #install.packages("BiocManager")
#  #BiocManager::install("mixOmics")
#  data(liver.toxicity,package="mixOmics")
#  X <- liver.toxicity$gene
#  Y <- liver.toxicity$clinic
#  Y$Cholesterol.mg.dL. <- -Y$Cholesterol.mg.dL.
#  loss <- joinet:::cv.joinet(Y=Y,X=X)

