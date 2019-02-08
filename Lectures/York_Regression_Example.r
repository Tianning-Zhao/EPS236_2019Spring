#  create a variable with the name of the path to the folder;  
#if you have a space (" ") in your pathname, you may need to put a backslash ( \ ) in front of it
##     ... and don't create any folder names with spaces (R, like most stat packages, inherits from Unix/Linux)
#york_path="/Users/scwofsy/eps236/2019S/REGRESSIONS_YORK"
source(paste(york_path,"York.R",sep="/"))
x0=1:1000
y0=2*x0  #WoOz knows this slope, it is the true value
x=x0+rnorm(1000)*250  #  add variance to x
y=y0+rnorm(1000)*1000  #  add variance to y
plot(x,y) ; 
abline(0,2,col="green",lwd=3)
require(lmodel2)
ff.type.2.2=lmodel2(y ~ x)  ## inspect!  what is this ?
ab.ols= as.numeric( ff.type.2.2$regression.results[1,2:3] )
ab.ma= as.numeric( ff.type.2.2$regression.results[2,2:3] )
ab.sma= as.numeric( ff.type.2.2$regression.results[3,2:3] )
ff.sma.like = YorkFit(x,y,rep(sd(x),length(x)),rep(sd(y),length(y))) 
## the std dev of each measurement is the std dev of the sample
ff.1 = YorkFit(x,y,rep(250,length(x)),rep(1000    ,length(y))) 
## the std dev of each measurement is the std dev from the Wizard
ff.2 = YorkFit(x,y,rep(500,length(x)),rep(1000    ,length(y)))
## the std dev of each measurement is stretched vs from the Wizard
abline(ab.ols,col="red",lty=2,lwd=2)
abline(ab.ma,col="orange",lty=2,lwd=2)
abline(ab.sma,col="purple",lty=2,lwd=2)
abline(a=ff.sma.like[1,1],b=ff.sma.like[2,1],col="cyan",lty=3,lwd=3)
abline(a=ff.1[1,1],b=ff.1[2,1],col="blue",lty=2,lwd=3)
abline(a=ff.2[1,1],b=ff.2[2,1],col="brown",lty=2,lwd=2)
legend("topleft",
       legend=c("W.Oz","OLS","MA","SMA","YorkFit/SMA","YorkFit best","YorkFit stretched"),
   col=c("green","red","orange","purple","cyan","blue","brown"),lty=c(1,2,2,2,2,2,2),lwd=3)


## examine the relationship between OLS slope (from lsfit) and YorkFit slope
## one trial
x.err= rnorm(200)*250
y.err=rnorm(200)*500+x.err
y.err2=rnorm(200)*y0*.05 + rnorm(200)*250

x1=x0[1:200]+x.err
y1=y0[1:200]+y.err
y2=y0[1:200]+y.err2[1:200]
plot(x1,y2)
YorkFit(x1,y2,rep(250,200),abs(y2*.05)+250)
ls.print(lsfit(x1,y2))

##many trials
res=NULL
for(k in 1:1000){
x.err= rnorm(200)*250
y.err2=rnorm(200)*y0*.05 + rnorm(200)*250

x1=x0[1:200]+x.err
y2=y0[1:200]+y.err2[1:200]
z0=YorkFit(x1,y2,rep(250,200),abs(y2*.05)+250)
zz=YorkFit(x1,y2,rep(250,200),rep(500,200))
z1=lsfit(x1,y2)$coef
res=rbind(res,c(zz[,1],z0[,1],z1) )
}

#> median(res[,2]) York with fixed sigma
#[1] 0.1430664
#> median(res[,4]) York with proportional sigma
#[1] 0.9180343
#> median(res[,6]) OLS
#[1] 0.1020457

qqnorm(res[,4])





