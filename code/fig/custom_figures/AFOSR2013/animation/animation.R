data <- read.csv("animation.txt",header=TRUE,skip=2)
Y <- data[,4:7]
q <- data[,8:11]
lower <- data[,2]
upper <- data[,3]

# The code doesn't output the correct value for q[1,], i.e., the value of q at the initial time.
q[1,] = q[1,] / sum(q[1,])

Tmax = nrow(Y)
Ymin = 1.1*min(Y[!is.na(Y)])
Ymax = 1.1*max(Y[!is.na(Y)])

my_col = c("red","blue","dark green","purple")



# This makes a plot with the Y values on top and the q values on the bottom
for (t in 1:Tmax) {

  # For each alternative, count the number of observations up to the current time
  # t, which will be less than t if Y has been eliminated.
  n = rep(NA,4)
  for (i in 1:4) {
    tmp = Y[1:t,i]
    tmp = tmp[!is.na(tmp)]
    n[i] = length(tmp)
  }

  winner = which.max(n)

  pdf(sprintf("pdf1/animation_%04d.pdf",t))
  par(mfrow=c(2,1))

  # Plot the Y values
  plot(1:t, Y[1:t,winner], t="l", xlim=c(1,Tmax), ylim=c(Ymin,Ymax), xlab="t", ylab="Y(t,x)", cex.lab=1.5,cex.axis=1.5,lwd=3, col=my_col[winner],yaxt="n")
  axis(2,at=c(0,500),cex.axis=1.5)
  for (i in 1:4) {
    lines(1:n[i], Y[1:n[i],i], col=my_col[i], lwd=3)
  }

  # Plot the q values
  plot(1:t, q[1:t,winner], t="l", xlim=c(1,Tmax), ylim=c(0,1), xlab="t", ylab="q(t,x)", cex.lab=1.5, cex.axis=1.5, lwd=3, col=my_col[winner],yaxt="n")
  axis(2,at=c(0,1),cex.axis=1.5)
  for (i in 1:4) {
    lines(1:n[i], q[1:n[i],i], col=my_col[i], lwd=3)
  }
  lines(1:t,upper[1:t], lwd=3)
  lines(1:t,lower[1:t], lwd=3)
  dev.off()
}


# This makes a plot with the Y values on top and the q values on the bottom
for (t in 1:Tmax) {

  # For each alternative, count the number of observations up to the current time
  # t, which will be less than t if Y has been eliminated.
  n = rep(NA,4)
  for (i in 1:4) {
    tmp = Y[1:t,i]
    tmp = tmp[!is.na(tmp)]
    n[i] = length(tmp)
  }
  winner = which.max(n)

  pdf(sprintf("pdf2/animation_%04d.pdf",t))
  # Plot the Y values
  plot(1:t, Y[1:t,winner], t="l", xlim=c(1,Tmax), ylim=c(Ymin,Ymax), xlab="t", ylab="Y(t,x)", cex.lab=1.5,cex.axis=1.5,lwd=3, col=my_col[winner],yaxt="n")
  axis(2,at=c(0,500),cex.axis=1.5)
  for (i in 1:4) {
    lines(1:n[i], Y[1:n[i],i], col=my_col[i], lwd=3)
  }

  dev.off()
}
