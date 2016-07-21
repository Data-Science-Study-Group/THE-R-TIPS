## 8장 연습문제(4)

## 1

f <- function(x, y) sin(sqrt(x^2 + y^2))/sqrt(x^2 + y^2 + 1)
x <- seq(-10, 10, length=101)
y <- x
z <- outer(x, y, f)
persp(x, y, z, theta=30, phi=30, expand=0.5, col="lightblue")


## 2
persp3d(x, y, z, aspect=c(1, 1, 0.5), col="lightblue",
        xlab="X", ylab="Y", zlab="")

