## ----start,include=FALSE------------------------------------------------------
knitr::opts_chunk$set(echo=TRUE,eval=FALSE)
#setwd("~/Desktop/joinet")
#source("~/Desktop/joinet/package/R/functions.R")
#pkgs <- c("devtools","missRanger","mice","mvtnorm","glmnet","earth","spls","MTPS","RMTL","MultivariateRandomForest","mcen","MRCE","remMap","SiER","GPM","MLPUGS","benchmarkme")
#install.packages(pkgs)
#devtools::install_github("rauschenberger/joinet")
#devtools::install_github("cran/QUIC")
#devtools::install_github("cran/MRCE")
#devtools::install_github("cran/remMap")
#install.packages("joinet_0.0.X.tar.gz",repos=NULL,type="source")
library(joinet)

## ----figure_ABS---------------------------------------------------------------
#  box <- function(x,y,w=0.2,h=0.2,labels="",col="black",turn=FALSE,...){
#    xs <- x + 0.5*c(-1,-1,1,1)*w
#    ys <- y + 0.5*c(-1,1,1,-1)*h
#    graphics::polygon(x=xs,y=ys,border=col,col=grey(ifelse(col=="grey",0.99,0.99)),lwd=2,...)
#    graphics::text(x=x,y=y,labels=labels,col=col,srt=ifelse(turn,90,0))
#  }
#  
#  #grDevices::pdf(file="manuscript/figure_ABS.pdf",width=4,height=2.5)
#  grDevices::setEPS()
#  grDevices::postscript(file="manuscript/figure_ABS.eps",width=4,height=2.5)
#  graphics::par(mar=c(0,0,0,0))
#  graphics::plot.new()
#  graphics::plot.window(xlim=c(0,2),ylim=c(-0.1,1.1))
#  
#  n <- 0.45; p <- 0.4; q <- 0.4
#  h <- w <- 0.4
#  
#  y0 <- 0.10; y1 <- 0.50; y2 <- 0.90
#  x0 <- 0.20; x1 <- 1.00; x2 <- 1.80
#  y <- seq(from=1,to=0,length.out=5)
#  
#  w <- 0.15
#  d <- seq(from=0.06,to=-0.06,length.out=4)[c(1,2,3,Inf,4)]
#  for(i in 1:5){
#    if(i==4){graphics::text(x=c(x1,x2),y=y[4],labels="...",srt=90,font=2,cex=1.2);next}
#    graphics::arrows(x0=x0+p/2,x1=x1-q/2-0.02,y0=y1,y1=y[i],lwd=2,length=0.1,col="grey")
#    labels <- paste("target",ifelse(i==5,"q",i))
#    for(j in 1:5){
#      if(j==4){next}
#        graphics::arrows(x0=x1+p/2,x1=x2-q/2-0.02,y0=y[i],y1=y[j]+d[i],lwd=2,length=0.1,col=ifelse(i==j,"grey","grey"))
#    }
#    box(x=x1,y=y[i],h=0.5*h,w=q,labels=labels)
#    box(x=x2,y=y[i],h=0.5*h,w=q,labels=labels)
#  }
#  box(x=x0,y=y1,h=0.5*h,w=p,labels="features")
#  
#  grDevices::dev.off()

## ----figure_OUT---------------------------------------------------------------
#  #grDevices::pdf(file="manuscript/figure_OUT.pdf",width=5,height=3)
#  grDevices::postscript(file="manuscript/figure_OUT.eps",width=5,height=3)
#  
#  ellipse <- function(x,y,text=NULL,a=0.5,b=0.5,border="black",col=NULL,txt.col="black",...){
#      n <- max(c(length(x),length(y)))
#      if(is.null(col)){col <- rep(grey(0.9),times=n)}
#      if(length(col)==1){col <- rep(col,times=n)}
#      if(length(x)==1){x <- rep(x,times=n)}
#      if(length(y)==1){y <- rep(y,times=n)}
#      if(length(text)==1){text <- rep(text,times=n)}
#      if(length(border)==1){border <- rep(border,times=n)}
#      for(i in seq_len(n)){
#          angle <- seq(from=0,to=2*pi,length=100)
#          xs <- x[i] + a * cos(angle)
#          ys <- y[i] + b * sin(angle)
#          graphics::polygon(x=xs,y=ys,col=col[i],border=border[i])
#          graphics::text(labels=text[i],x=x[i],y=y[i],col=txt.col,...)
#      }
#  }
#  
#  txt <- list()
#  txt$x <- expression(x[j])
#  txt$y <- eval(parse(text=paste0("expression(",paste0("y[",c(1:3,"k","q"),"]",collapse=","),")")))
#  txt$beta <- eval(parse(text=paste0("expression(",paste0("beta[j",c(1:3,"k","q"),"]",collapse=","),")")))
#  txt$omega <- eval(parse(text=paste0("expression(",paste0("omega[\"",c(1:3,"k","q"),"k\"]",collapse=","),")")))
#  txt$dots <- expression(cdots)
#  
#  pos <- list()
#  pos$x <- 4
#  pos$y <- c(1,2,3,5,7)
#  pos$beta <- median(pos$x)+(pos$y-median(pos$x))/2
#  pos$omega <- 5+(pos$y-5)/2
#  
#  a <- b <- 0.3
#  graphics::plot.new()
#  graphics::par(mar=c(0,0,0,0))
#  graphics::plot.window(xlim=c(0.5,7.5),ylim=c(0.5,5.5))
#  
#  # beta
#  segments(x0=4,y0=5-a,x1=pos$y,y1=3+a,lwd=2,col="blue")
#  ellipse(x=pos$beta,y=4,text=txt$beta,a=0.21,b=0.21,cex=1.2,col="white",border="white",txt.col="blue")
#  
#  # omega
#  segments(x0=rep(pos$y,each=4),y0=3-a,x1=rep(pos$y,times=4),y1=1+a,lwd=2,col="grey")
#  segments(x0=pos$y,y0=3-a,y1=1+a,x1=5,lwd=2,col="red")
#  ellipse(x=pos$omega,y=2,text=txt$omega,a=0.25,b=0.18,cex=1.2,col="white",border="white",txt.col="red")
#  
#  # x and y
#  ellipse(x=pos$x,y=5,text=txt$x,a=a,b=b,cex=1.2)
#  text(x=c(3,5),y=5,labels=txt$dots,cex=1.2)
#  ellipse(x=pos$y,y=3,text=txt$y,a=a,b=b,cex=1.2)
#  text(x=c(4,6),y=3,labels=txt$dots,cex=1.2)
#  ellipse(x=pos$y,y=1,text=txt$y,a=a,b=b,cex=1.2)
#  text(x=c(4,6),y=1,labels=txt$dots,cex=1.2)
#  
#  grDevices::dev.off()

## ----simulation,eval=FALSE----------------------------------------------------
#  #<<start>>
#  library(joinet)
#  
#  grid <- list()
#  grid$rho_x <- c(0.00,0.10,0.30)
#  grid$rho_b <- c(0.00,0.50,0.90)
#  delta <- 0.8
#  grid <- expand.grid(grid)
#  grid <- rbind(grid,grid,grid)
#  grid$p <- rep(c(10,500,500),each=nrow(grid)/3)
#  grid$nzero <- rep(c(5,5,100),each=nrow(grid)/3)
#  grid <- grid[rep(1:nrow(grid),times=10),]
#  
#  n0 <- 100; n1 <- 10000
#  n <- n0 + n1
#  q <- 3
#  foldid.ext <- rep(c(0,1),times=c(n0,n1))
#  
#  loss <- list(); cor <- numeric(); seed <- list()
#  set.seed(1) # new
#  for(i in seq_len(nrow(grid))){
#    p <- grid$p[i]
#    #set.seed(i) # old
#    seed[[i]] <- .Random.seed # new
#    cat("i =",i,"\n")
#  
#    #--- features ---
#    mean <- rep(0,times=p)
#    sigma <- matrix(grid$rho_x[i],nrow=p,ncol=p)
#    diag(sigma) <- 1
#    X <- mvtnorm::rmvnorm(n=n,mean=mean,sigma=sigma)
#  
#    #--- effects --- (multivariate Gaussian)
#    mean <- rep(0,times=q)
#    sigma <- matrix(data=grid$rho_b[i],nrow=q,ncol=q)
#    diag(sigma) <- 1
#    beta <- mvtnorm::rmvnorm(n=p,mean=mean,sigma=sigma)
#    #beta <- 1*apply(beta,2,function(x) x>(sort(x,decreasing=TRUE)[grid$nzero[i]])) # old (either zero or one)
#    beta <- 1*apply(beta,2,function(x) ifelse(x>sort(x,decreasing=TRUE)[grid$nzero[i]],x,0)) # new (either zero or non-zero)
#  
#    #-- effects --- (multivariate binomial)
#    #sigma <- matrix(grid$rho_b[i],nrow=q,ncol=q); diag(sigma) <- 1
#    #beta <- bindata::rmvbin(n=p,margprob=rep(grid$prop[i],times=q),bincorr=sigma)
#  
#    #--- outcomes ---
#    signal <- scale(X%*%beta)
#    signal[is.na(signal)] <- 0
#    noise <- matrix(rnorm(n*q),nrow=n,ncol=q)
#    Y <- sqrt(delta)*signal + sqrt(1-delta)*noise
#    # binomial: Y <- round(exp(Y)/(1+exp(Y)))
#    cors <- stats::cor(Y)
#    diag(cors) <- NA
#    cor[i] <- mean(cors,na.rm=TRUE)
#  
#    #--- holdout ---
#    alpha.base <- 1*(grid$nzero[i] <= 10) # sparse vs dense
#    compare <- TRUE
#    loss[[i]] <- tryCatch(expr=cv.joinet(Y=Y,X=X,family="gaussian",compare=compare,foldid.ext=foldid.ext,alpha.base=alpha.base,alpha.meta=1,times=TRUE,sign=1),error=function(x) NA)
#  }
#  save(grid,loss,cor,seed,file="results/simulation.RData")
#  writeLines(text=capture.output(utils::sessionInfo(),cat("\n"),sessioninfo::session_info()),con="results/info_sim.txt")

## ----figure_SIM,results="hide"------------------------------------------------
#  #<<start>>
#  load("results/simulation.RData")
#  
#  cond <- lapply(loss,length)==2
#  if(any(!cond)){
#    warning("At least one error.",call.=FALSE)
#    grid <- grid[cond,]; loss <- loss[cond]
#  }
#  
#  #--- computation time ---
#  time <- sapply(loss,function(x) unlist(x$time))
#  #round(sort(colMeans(apply(time,1,function(x) x/time["meta",]))),digits=1)
#  sort(round(rowMeans(time),digits=1))
#  
#  #--- average ---
#  loss <- lapply(loss,function(x) x$loss)
#  
#  #prop <- sapply(loss[cond],function(x) rowMeans(100*x/matrix(x["none",],nrow=nrow(x),ncol=ncol(x),byrow=TRUE))[-nrow(x)]) # old (first re-scale, then average)
#  mean <- sapply(loss,function(x) rowMeans(x)) # new (first average)
#  prop <- 100*mean[rownames(mean)!="none",]/matrix(mean["none",],nrow=nrow(mean)-1,ncol=ncol(mean),byrow=TRUE) # new (then re-scale)
#  
#  mode <- ifelse(grid$p==10,"ld",ifelse(grid$nzero==5,"hd-s","hd-d"))
#  set <- as.numeric(sapply(rownames(grid),function(x) strsplit(x,split="\\.")[[1]][[1]]))
#  
#  #--- mean rank ---
#  mult <- rownames(prop)!="base"
#  sort(round(rowMeans(apply(prop[mult,mode=="ld"],2,rank)),digits=1))
#  sort(round(rowMeans(apply(prop[mult,mode=="hd-s"],2,rank)),digits=1))
#  sort(round(rowMeans(apply(prop[mult,mode=="hd-d"],2,rank)),digits=1))
#  
#  #--- testing ---
#  apply(prop[mult,],1,function(x) sum(tapply(X=x-prop["base",],INDEX=set,FUN=function(x) wilcox.test(x,alternative="less",exact=FALSE)$p.value<0.05),na.rm=TRUE))
#  
#  colSums(tapply(X=prop["meta",]-prop["base",],INDEX=list(set=set,mode=mode),FUN=function(x) wilcox.test(x,alternative="less",exact=FALSE)$p.value<0.05),na.rm=TRUE)
#  colSums(tapply(X=prop["spls",]-prop["base",],INDEX=list(set=set,mode=mode),FUN=function(x) wilcox.test(x,alternative="less",exact=FALSE)$p.value<0.05),na.rm=TRUE)

## ----table_SIM,results="asis"-------------------------------------------------
#  beta <- sapply(unique(set),function(i) rowMeans(prop[,set==i]))
#  cor <- sapply(unique(set),function(i) mean(cor[set==i]))
#  
#  rownames(beta)[rownames(beta)=="mnorm"] <- "mvn"
#  sign <- apply(beta,2,function(x) sign(x["base"]-x))
#  #min <- apply(beta,2,function(x) which.min(x)) # incorrect (old)
#  min <- apply(beta,2,function(x) which(x==min(x))) # correct (new)
#  beta <- format(round(beta,digits=1),trim=TRUE)
#  beta[sign<=0] <- paste0("\\textcolor{gray}{",beta[sign<=0],"}")
#  index <- cbind(min,1:ncol(beta))
#  beta[index] <- paste0("\\underline{",beta[index],"}")
#  unique <- unique(grid)
#  info <- format(round(cbind("$\\rho_x$"=unique$rho_x,"$\\rho_b$"=unique$rho_b,"$\\rho_y$"=cor),digits=1))
#  temp <- paste0("\\cran{",sapply(rownames(beta),function(x) switch(x,base="glmnet",meta="joinet",mvn="glmnet",mars="earth",spls="spls",mrce="MRCE",map="remMap",mrf="MultivariateRandomForest",sier="SiER",mcen="mcen",gpm="GPM",rmtl="RMTL",mtps="MTPS",NULL)),"}")
#  temp[1] <- paste0(temp[1],"$^1$")
#  temp[3] <- paste0(temp[3],"$^2$")
#  temp[8] <- "\\href{https://CRAN.R-project.org/package=MultivariateRandomForest}{\\texttt{MRF}}$^3$"
#  rownames(beta) <- paste0("\\begin{sideways}",temp,"\\end{sideways}")
#  xtable <- xtable::xtable(cbind(info,t(beta)),align=paste0("rccc",paste0(rep("c",times=nrow(beta)),collapse=""),collapse=""),caption="")
#  xtable::print.xtable(xtable,comment=FALSE,floating=TRUE,sanitize.text.function=identity,hline.after=c(0,9,18,ncol(beta)),include.rownames=FALSE,size="\\footnotesize",caption.placement="top")

## ----data,eval=FALSE----------------------------------------------------------
#  # clinical features
#  X <- read.csv("data/PPMI_Baseline_Data_02Jul2018.csv",row.names="PATNO",na.strings=c(".",""))
#  colnames(X) <- tolower(colnames(X))
#  X <- X[X$apprdx==1,] # Parkinson's disease
#  X[c("site","apprdx","event_id","symptom5_comment")] <- NULL
#  for(i in seq_len(ncol(X))){
#    if(is.factor(X[[i]])){levels(X[[i]]) <- paste0("-",levels(X[[i]]))}
#  }
#  100*mean(is.na(X)) # proportion missingness
#  x <- lapply(seq_len(1),function(x) missRanger::missRanger(data=X,pmm.k=3,
#          num.trees=100,verbose=0,seed=1))
#  x <- lapply(x,function(x) model.matrix(~.-1,data=x))
#  
#  # genomic features
#  load("data/ppmi_rnaseq_bl_pd_hc-2019-01-11.Rdata",verbose=TRUE)
#  counts <- t(ppmi_rnaseq_bl_pdhc)
#  mean(grepl(pattern="ENSG0000|ENSGR0000",x=colnames(counts)))
#  cond <- apply(counts,2,function(x) sd(x)>0) & !grepl(pattern="ENSG0000|ENSGR0000",x=colnames(counts))
#  Z <- palasso:::.prepare(counts[,cond],filter=10,cutoff="knee")$X
#  
#  # outcome
#  Y <- read.csv("data/PPMI_Year_1-3_Data_02Jul2018.csv",na.strings=".")
#  Y <- Y[Y$APPRDX==1 & Y$EVENT_ID %in% c("V04","V06","V08"),]
#  colnames(Y)[colnames(Y)=="updrs_totscore"] <- "updrs"
#  vars <- c("moca","quip","updrs","gds","scopa","ess","bjlot","rem")
#  # too few levels: "NP1HALL","NP1DPRS"
#  Y <- Y[,c("EVENT_ID","PATNO",vars)]
#  Y <- reshape(Y,idvar="PATNO",timevar="EVENT_ID",direction="wide")
#  rownames(Y) <- Y$PATNO; Y$PATNO <- NULL
#  
#  # overlap
#  names <- Reduce(intersect,list(rownames(X),rownames(Y),rownames(Z)))
#  Z <- Z[names,]
#  Y <- Y[names,]
#  Y <- sapply(vars,function(x) Y[,grepl(pattern=x,x=colnames(Y))],simplify=FALSE)
#  for(i in seq_along(Y)){
#    colnames(Y[[i]]) <- c("V04","V06","V08")
#  }
#  x <- lapply(x,function(x) x[names,]); rm(names)
#  X <- x[[1]]; rm(x) # impute multiple times!
#  
#  # inversion for positive correlation
#  Y$moca <- -Y$moca # "wrong" sign
#  Y$bjlot <- -Y$bjlot # "wrong" sign
#  sapply(Y,function(x) range(unlist(x),na.rm=TRUE))
#  
#  save(Y,X,Z,file="results/data.RData")
#  writeLines(text=capture.output(utils::sessionInfo(),cat("\n"),sessioninfo::session_info()),con="results/info_dat.txt")

## ----figure_COR---------------------------------------------------------------
#  load("results/data.RData",verbose=TRUE)
#  
#  #grDevices::pdf(file="manuscript/figure_COR.pdf",width=6,height=3)
#  grDevices::postscript(file="manuscript/figure_COR.eps",width=6,height=3)
#  graphics::par(mar=c(0.5,3,2,0.5))
#  graphics::layout(mat=matrix(c(1,2),nrow=1,ncol=2),width=c(0.2,0.8))
#  
#  # correlation between years
#  cor <- cbind(sapply(Y,function(x) cor(x[,1],x[,2],use="complete.obs",method="spearman")),
#  sapply(Y,function(x) cor(x[,2],x[,3],use="complete.obs",method="spearman")),
#  sapply(Y,function(x) cor(x[,1],x[,3],use="complete.obs",method="spearman")))
#  colnames(cor) <- c("1-2","2-3","1-3")
#  cor <- rowMeans(cor)
#  joinet:::plot.matrix(cor,range=c(-3,3),margin=1,cex=0.7)
#  
#  # correlation between variables
#  cor <- 1/3*cor(sapply(Y,function(x) x[,1]),use="complete.obs",method="spearman")+
#  1/3*cor(sapply(Y,function(x) x[,2]),use="complete.obs",method="spearman")+
#  1/3*cor(sapply(Y,function(x) x[,3]),use="complete.obs",method="spearman")
#  joinet:::plot.matrix(cor,range=c(-3,3),margin=c(1,2),cex=0.7)
#  grDevices::dev.off()
#  
#  # other information
#  sapply(Y,colMeans,na.rm=TRUE) # increasing values
#  sapply(Y,function(x) apply(x,2,sd,na.rm=TRUE)) # increasing variance
#  sapply(Y,function(x) colSums(is.na(x))) # increasing numbers of NAs

## ----application,eval=FALSE---------------------------------------------------
#  #<<start>>
#  library(joinet)
#  
#  set.seed(1)
#  load("results/data.RData",verbose=TRUE)
#  
#  set.seed(1)
#  foldid.ext <- rep(1:5,length.out=nrow(Y$moca))
#  foldid.int <- rep(rep(1:10,each=5),length.out=nrow(Y$moca))
#  table(foldid.ext,foldid.int)
#  
#  #- - - - - - - - - - - - -
#  #- - internal coaching - -
#  #- - - - - - - - - - - - -
#  
#  table <- list()
#  table$alpha <- c("lasso","ridge")
#  table$data <- c("clinic","omics","both")
#  table$var <- names(Y)
#  table <- rev(expand.grid(table,stringsAsFactors=FALSE))
#  
#  loss <- fit <- list()
#  for(i in seq_len(nrow(table))){
#    cat(rep("*",times=5),"setting",i,rep("*",times=5),"\n")
#    y <- Y[[table$var[i]]]
#    x <- list(clinic=X,omics=Z,both=cbind(X,Z))[[table$data[i]]]
#    alpha <- 1*(table$alpha[i]=="lasso")
#    loss[[i]] <- cv.joinet(Y=y,X=x,alpha.base=alpha,foldid.ext=foldid.ext,
#            foldid.int=foldid.int,sign=1) # add joinet::
#    #fit[[i]] <- joinet(Y=y,X=x,alpha.base=alpha,foldid=foldid.int,sign=1)
#  }
#  
#  save(table,loss,file="results/internal.RData")
#  
#  #- - - - - - - - - - - - -
#  #- - external coaching - -
#  #- - - - - - - - - - - - -
#  
#  table <- list()
#  temp <- utils::combn(x=names(Y),m=2)
#  table$comb <- paste0(temp[1,],"-",temp[2,])
#  table$step <-  c("V04","V06","V08")
#  table$alpha <- c("lasso","ridge")
#  table$data <- c("clinic","omics","both")
#  table <- rev(expand.grid(table,stringsAsFactors=FALSE))
#  temp <- strsplit(table$comb,split="-"); table$comb <- NULL
#  table$var1 <- sapply(temp,function(x) x[[1]])
#  table$var2 <- sapply(temp,function(x) x[[2]])
#  
#  loss <- fit <- list()
#  for(i in seq_len(nrow(table))){
#    cat(rep("*",times=5),"setting",i,rep("*",times=5),"\n")
#    y <- cbind(Y[[table$var1[i]]][,table$step[i]],
#               Y[[table$var2[i]]][,table$step[i]])
#    x <- list(clinic=X,omics=Z,both=cbind(X,Z))[[table$data[i]]]
#    alpha <- 1*(table$alpha[i]=="lasso")
#    loss[[i]] <- cv.joinet(Y=y,X=x,alpha.base=alpha,
#                  foldid.ext=foldid.ext,foldid.int=foldid.int,sign=1) # add joinet::
#    #fit[[i]] <- joinet(Y=y,X=x,alpha.base=alpha,foldid=foldid.int,sign=1)
#  }
#  
#  save(table,loss,file="results/external.RData")
#  writeLines(text=capture.output(utils::sessionInfo(),cat("\n"),sessioninfo::session_info()),con="results/info_app.txt")

## ----figure_INT---------------------------------------------------------------
#  load("results/internal.RData")
#  
#  # standardised loss
#  vars <- unique(table$var)
#  former <- t(sapply(loss,function(x) x["base",]))
#  min <- sapply(vars,function(x) min(former[table$var==x,]))
#  max <- sapply(vars,function(x) max(former[table$var==x,]))
#  index <- match(x=table$var,table=vars)
#  former <- (former-min[index])/(max[index]-min[index])
#  dimnames(former) <- list(table$var,seq_len(3))
#  
#  # percentage change
#  change <- t(sapply(loss,function(x) 100*(x["meta",]-x["base",])/x["base",]))
#  dimnames(change) <- list(table$var,c("1st","2nd","3rd"))
#  
#  # overview
#  #grDevices::pdf(file="manuscript/figure_INT.pdf",width=6,height=3,pointsize=12)
#  grDevices::postscript(file="manuscript/figure_INT.eps",width=6,height=3,pointsize=12)
#  graphics::par(mfrow=c(2,3),mar=c(0.1,3,2,0.1),oma=c(0,1.1,1,0))
#  for(alpha in c("lasso","ridge")){
#    for(data in c("clinic","omics","both")){
#      cond <- table$alpha==alpha & table$data==data
#      joinet:::plot.matrix(X=change[cond,],range=c(-50,50),cex=0.7)
#      #graphics::title(main=paste0(alpha,"-",data),col.main="red",line=0) # check
#      if(alpha=="lasso"){graphics::mtext(text=data,side=3,line=1.5,cex=0.8)}
#      if(data=="clinic"){graphics::mtext(text=alpha,side=2,line=3,cex=0.8)}
#    }
#  }
#  grDevices::dev.off()
#  
#  TEMP <- tapply(X=rowMeans(change),INDEX=table$var,FUN=mean)[vars]
#  mean(change<0)
#  round(tapply(X=rowMeans(change),INDEX=table$data,FUN=mean),digits=2)
#  round(tapply(X=rowMeans(change),INDEX=table$alpha,FUN=mean),digits=2)
#  round(colMeans(change),digits=2)

## ----figure_EXT---------------------------------------------------------------
#  load("results/external.RData")
#  
#  data <- c("clinic","omics","both")
#  alpha <- c("lasso","ridge")
#  step <- c("V04","V06","V08")
#  
#  # percentage change
#  change <- t(sapply(loss,function(x) 100*(x["meta",]-x["base",])/x["base",]))
#  
#  # overview
#  vars <- unique(c(table$var1,table$var2))
#  temp <- matrix(NA,nrow=length(vars),ncol=length(vars),dimnames=list(vars,vars))
#  array <- array(data=list(temp),dim=c(3,2,3),dimnames=list(data,alpha,step))
#  #grDevices::pdf(file="manuscript/figure_EXT.pdf",width=7.5,height=10,pointsize=14)
#  grDevices::postscript(file="manuscript/figure_EXT.eps",width=7.5,height=10,pointsize=14)
#  graphics::par(mfrow=c(6,3),mar=c(0.1,2.5,2.5,0.1),oma=c(0,1,2,0))
#  for(i in data){
#    for(j in alpha){
#      for(k in step){
#        cond <- table$data==i & table$alpha==j & table$step==k
#        array[i,j,k][[1]][cbind(table$var1,table$var2)[cond,]] <- change[cond,1]
#        array[i,j,k][[1]][cbind(table$var2,table$var1)[cond,]] <- change[cond,2]
#        joinet:::plot.matrix(array[i,j,k][[1]],margin=0,las=2,range=c(-20,20),cex=0.6)
#        #graphics::title(main=paste0(i,"-",j,"-",k),col.main="red",line=0) # check
#        if(i=="clinic" & j=="lasso"){graphics::mtext(text=ifelse(k=="V04","1st",ifelse(k=="V06","2nd","3rd")),side=3,line=2.5,cex=0.8)}
#        if(k=="V04"){graphics::mtext(text=paste0(i,"-",j),side=2,line=2.5,cex=0.8)}
#      }
#    }
#  }
#  grDevices::dev.off()
#  
#  # check
#  i <- sample(seq_len(nrow(table)),size=1)
#  table[i,]
#  x <- loss[[i]]
#  100*(x["meta",]-x["base",])/x["base",]

## ----figure_ALL---------------------------------------------------------------
#  #grDevices::pdf(file="manuscript/figure_ALL.pdf",height=3,width=6)
#  grDevices::postscript(file="manuscript/figure_ALL.eps",height=3,width=6)
#  
#  graphics::par(mar=c(0.5,3,2,0.5))
#  graphics::layout(mat=matrix(c(1,2),nrow=1,ncol=2),width=c(0.2,0.8))
#  joinet:::plot.matrix(as.matrix(TEMP),margin=1,las=1,range=c(-20,20),cex=0.7)
#  
#  sum(unlist(array)<0,na.rm=TRUE)/sum(!is.na(unlist(array)))
#  means <- apply(array,c(1,2,3),function(x) mean(x[[1]],na.rm=TRUE))
#  lapply(seq_len(3),function(x) apply(means,x,mean))
#  mean <- 1/length(array)*Reduce(f="+",x=array)
#  joinet:::plot.matrix(mean,margin=1,las=1,range=c(-20,20),cex=0.7)
#  # rows: target variable, columns: coaching variable
#  
#  grDevices::dev.off()

## ----figure_DIF---------------------------------------------------------------
#  #grDevices::pdf(file="manuscript/figure_DIF.pdf",height=1.2,width=5)
#  grDevices::postscript(file="manuscript/figure_DIF.eps",height=1.2,width=5)
#  
#  load("results/internal.RData")
#  vars <- unique(table$var)
#  base <- t(sapply(loss,function(x) 100*(x["base",]-x["none",])/x["none",]))
#  meta <- t(sapply(loss,function(x) 100*(x["meta",]-x["none",])/x["none",]))
#  dimnames(meta) <- dimnames(base) <- list(table$var,c("1st","2nd","3rd"))
#  standard <- tapply(X=rowMeans(base),INDEX=table$var,FUN=mean)[vars]
#  internal <- tapply(X=rowMeans(meta),INDEX=table$var,FUN=mean)[vars]
#  
#  load("results/external.RData")
#  vars <- unique(c(table$var1,table$var2))
#  base <- meta <- list()
#  for(i in seq_len(2)){
#    base[[i]] <- sapply(loss,function(x) 100*(x["base",i]-x["none",i])/x["none",i])
#    meta[[i]] <- sapply(loss,function(x) 100*(x["meta",i]-x["none",i])/x["none",i])
#  }
#  index <- c(table$var1,table$var2)
#  base <- unlist(base); meta <- unlist(meta)
#  #standard <- tapply(X=base,INDEX=index,FUN=mean)[vars]
#  external <- tapply(X=meta,INDEX=index,FUN=mean)[vars]
#  
#  matrix <- round(rbind(standard,internal,external),digits=2)
#  rownames(matrix) <- c("","","")
#  graphics::par(mfrow=c(1,1),mar=c(0.5,3,1.5,1))
#  joinet:::plot.matrix(matrix,margin=c(1,2),las=1,range=c(-100,0),cex=0.7,digits=3)
#  
#  grDevices::dev.off()

