## 5.1 함수

date()

x <- 2.71828182845
log(x)

x <- 10
log(x^2, base=10)


## 5.2 함수 정의의 기본

myfunc01 <- function() {
    return(1)
}
myfunc01()

myfunc02 <- function(x) {
    return(x)
}
myfunc02(2)


## 5.3 프로그램의 기본
## 5.3.1 조건 분기: if, else

myabs <- function(x) {
    if (x < 0) {
        return(-x)
    }
    else {
        return(x)
    }
}
myabs(-2)
myabs(3)


## 5.3.2 반복문: for

myloop <- function() {
    a <- 0
    for (i in 1:5) {
        a <- a + 1
    }
    return(a)
}
myloop()

myloop2 <- function() {
    a <- 0
    for (i in 3:7) {
        a <- a + 1
    }
    return(a)
}
myloop2()


## 5.4 보충학습

myfunc <- function(x) return(2 * x)  # 한줄 함수
myabs <- function(x) {
    if (x < 0) return(-x)
    else       return(x)
}

myfunc <- function(x) {
    2 * x
}
myfunc(5)

myfunc <- function(x) {
    if (x < 0)                     return(-x)
    else if ((0 <= x) && (x < 5))  return(5)
    else                           return(x)
}
