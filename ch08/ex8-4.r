## 8장 연습문제(3)

## 1
y <- c(1, 3, 2, 4, 8, 5, 7, 6, 9)
plot(y, type="h", lwd=5, xlab="", ylab="빈도")


## 2
title("막대그래프")
abline(h=5, col="gray")
arrows(8, 9, 9, 9)
text(7.5, 9, "톱")


## 3
f <- function(x, a) x ^ a


## 4
curve(f(x, 1), lty=1, xlim=c(-2, 2), ylim=c(-2, 2), xlab="", ylab="")
par(new=T)
curve(f(x, 2), lty=2, xlim=c(-2, 2), ylim=c(-2, 2), xlab="", ylab="")
par(new=T)
curve(f(x, 3), lty=3, xlim=c(-2, 2), ylim=c(-2, 2), ylab="f(x, a)")
