## 6장 연습문제(2)

##1
f <- expression(x^2 + sin(x))
D(f, "x")  # 2 * x + cos(x)

f <- function(x) 2 * x + cos(x)
f(0)  # 1


f <- deriv(~ x^2 + sin(x), "x", func=T)
f(0)


##2
f <- function(x) exp(-x^2)
integrate(f, 0, 1)
integrate(f, 0, Inf)
