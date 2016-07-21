## 8장 연습문제(1)

## 1
x <- c(1, 2, 3, 4, 5)
y <- c(1, 4, 9, 6, 3)
plot(x, y)


## 2
f <- function(x) cos(x) - log(x)
plot(f, 1, 10)


## 3
f <- function(x) {
    return(x^2)
}
curve(f, -3, 3)        # -3 ~ 3의 범위로 플롯

curve(f(x), -3, 3)     # -3 ~ 3의 범위로 플롯


f <- function(x, a) {
    return(x^a)
}
curve(f(x, 2), -3, 3)


f <- function(x, y) 1 /(2 * pi) * exp(-(x^2 + y^2)/2)
curve(f(x, 0), -3, 3)
