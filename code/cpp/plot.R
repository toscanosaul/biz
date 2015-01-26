d=read.table("ex2.txt")
library("Hmisc")

d = data.frame(
  x  = d[,2]
  , y  = d[,3]
  , sd = d[,4]
)


plot(d$x, d$y, type="n",ylim=c(0.95,0.983),xlab="delta",ylab="PCS",main="k=10; pstar=0.95; n=5000; sigma=50")
with (
  data = d
  , expr = errbar(x, y, y+sd, y-sd, add=T, pch=1, cap=.1)
)
abline(h=0.95)

