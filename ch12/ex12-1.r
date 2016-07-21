# 12장 함수와 프로그래밍

## 12.1 연산자와 인덱스

a <- rnorm(1)        # 정규난수를 하나 생성
b <- rnorm(1)        # 정규난수를 하나 생성
if ((a > 0) && (b > 0)) {
    c <- a * b
} else c <- -a * b
c

a <- rnorm(1)        # 정규난수를 하나 생성
b <- rnorm(1)        # 정규난수를 하나 생성
if ((a < 0) || (b < 0)) {
    c <- -a * b
} else c <- a * b
c

x <- matrix(1:4, 2, 2)
x[1]
x[2, 2]


## 12.2 복합식

## 12.3 조건 분기

## 12.3.1 if ~ else 문

a <- rnorm(1)
if (a >= 0) {
    if (a==0) b <- "zero"
    else b <- a
}
else b <- a        # 이 다음에 오류가 발생한다.

{
    if (a >= 0) {
        if (a==0) b <- "zero"
        else b <- a
    }
    else b <- a        # 오류가 발생하지 않는다.
}

myfunc <- function(a) {
    if (a >= 0) {
        if (a == 0) b <- "zero"
        else b <- a
    }
    else b <- a
    return(c(a, b))
}

x <- 3
if (x<-2) print(x)    # x<-2는 x에 2를 대입한다는 의미
                      # 0이 아니므로 TRUE가 되어 버린다!

if (a < 0) {          # 괄호 } 위치에 주의
    print(0)
} else if (a < 1) {
    print(1)
} else print(2)

myfunc <- function(a) {  # 함수 정의 내부
    if (a < 0) print(0)
    else if (a < 1) print(1)
    else print(2)
}

x <- c(6:-4)
sqrt(x)
sqrt(ifelse(x >= 0, x, NA))


## 12.3.2 switch 문

a <- 1
switch(a,
       "1" = print("one"),
       "2" = print("two"),
       print("?")
       )
a <- 2
switch(a,
       print("one"),
       print("two")
       )


## 12.4 반복문

## 12.4.1 for 문

x <- 0
for (i in 1:5) {
    x <- x + 1
}
x

x <- 1:5
for (i in x) x <- c(x, i)
x

x <- 1:5
for (i in 1:5) x <- c(x, i)
x

x <- 0
y <- matrix(1:10, 2, 5)
for (i in y) x <- x + 1
x

par(mfrow=c(2, 2))
x <- list(1:6, sin, runif(6), dnorm)
for (i in x) plot(i, xlim=c(0, 2*pi))


## 12.4.2 while 문

x <- 0
while (x <= 5) {
    x <- x + 1
}
x


## 12.4.3 break 문: 반복문에서 탈출

x <- 0
for (i in 1:5) {
    x <- x + 1
    if (x == 3) break    # x가 3이 되면 for 문을 빠져 나간다.
}
x


## 12.4.4 next 문: 강제적으로 다음 반복으로 이동

x <- 0
for (i in 1:5) {
    next
    x <- x + 1    # x에 1을 더하기 전에 다음 박복으로 넘어간다.
}
x


## 12.4.5 repeat 문

x <- 0
repeat {
    if (x <= 5) x <- x + 1
    else        break        # x > 5면 repeat 문을 빠져 나간다.
}
x


## 12.5 함수의 정의

sin <- function(x) ifelse(x > 0, 1, -1)    # 경고가 발생하지 않는다.
sin(1)
rm(sin)
sin(1)


## 12.5.1 새로운 함수 정의

mysquare <- function(x) x^2
mysquare(2)

mysquare <- function(x) {
    return (x^2)            # 위와 같은 함수 정의
}
mysquare(2)


## 12.5.2 새로운 연산자의 정의

"%+=%" <- function(x, y) { x <<- x + y }
"%-=%" <- function(x, y) { x <<- x - y }
x <- 0; (x %+=% 3)
(x %-=% 2)


## 12.5.3 함수의 반환값

mysquare <- function(x) {
    if (!is.numeric(x)) return(NA)    # 수치가 아니면 NA를 반환한다.
    return(x^2)                       # 수치라면 x^2을 반환한다.
}

mysquare <- function(x) {
    if (!is.numeric(x)) return(NA)    # 수치가 아니면 NA를 반환한다.
    x^2                               # 수치라면 x^2을 반환한다.
}

mysquare <- function(x) {
    y = x^2
    return(x, y)        # 경고가 발생한다.
}
mysquare(2)

mysquare <- function(x) {
    y = x^2
    return(list(x, y))  # 경고가 발생하지 않는다.
}
mysquare(2)

mysquare <- function(x) {
    y = x^2
    return(list(input=x, output=y))  # 경고가 발생하지 않는다.
}
mysquare(2)

mysquare <- function(x) {
    return(function(y){y^x})
}
result <- mysquare(2)        # result(y)는 함수 y^2
result(3)


## 12.5.4 화면에 계산 결과(반환값)를 표시하지 않는다

mysquare <- function(x) {
    return(invisible(x^2))
}
mysquare(3)        # 아무것도 표시되지 않는다.
y <- mysquare(3)   # 변수에 대입해야 비로소 표시할 수 있다.
y


## 12.5.5 오류와 경고를 표시

mysquare <- function(x) {
    if (!is.numeric(x)) stop("not numeric !")
    return(x^2)                       # 수치라면 x^2을 반환한다.
}
mysquare("a")

mysquare <- function(x) {
    if (!is.numeric(x)){
        warning("not numeric !")      # 수치가 아니면 경고를 표시하고
        return(NA)                    # NA를 반환한다.
    }
    return(x^2)                       # 수치라면 x^2을 반환한다.
}
mysquare("a")


## 12.5.6 오류가 일어나도 작업을 계속한다

mysquare <- function(x) {
    if (x%%2 == 1) stop("error !")    # 홀수면 오류를
    return(x^2)                       # 짝수면 x^2을 반환한다.
}
result <- lapply(1:2, function(x){try(mysquare(x), TRUE)})
result


## 12.5.7 로컬변수와 영속대입 <<-

x <- 10                    # 글로벌변수 x
myfunc <- function(y) {    # y는 인수(형식 파라미터라고 한다)
    x <- y + 999           # x는 함수 myfunc() 안의 로컬변수
    return(x)              # 인수도 로컬변수도 아닌 변수는
}                          # 자유변수라고 불린다.
x                          # 글로벌 변수 x의 값은 10
myfunc(1)                  # 글로벌변수 x에는 영향을 주지 않는다.
x                          # 영향이 없음을 확인한다.

x <- 10                    # 글로벌변수 x
myfunc <- function(y) {
    x <- 777               # 함수 myfunc() 안의 로컬변수 x
    x <<- 99               # 글로벌변수 x에 99를 대입한다.
    return(x)              # 로컬변수 x의 값을 표시한다.
}                          # 글로벌 변수 x의 값은 10
myfunc()                   # myfunc()의 반환(변수 x)
x                          # myfunc() 안에서 글로벌변수 x의 값을 변경했으므로
                           # 글로벌변수 x의 값은 99
x <- 10
myfunc <- function() {
    x <- c(1, 2)        # 이 문을 x <- 1:3 으로 한 경우나
    x[2] <<- 0          # 이 문을 assign(x[2], 2, env=.GlobalEnv)로 한
    print(x)            # 경우의 동작의 차이를 비교해 보기 바란다.
}
myfunc()                # 로컬변수 x의 값(값이 변경되어 있다)
x                       # 글로벌변수 x의 값(어느새 벡터로...)


## 12.5.8 함수 안에서 함수 정의

myfunc <- function(x) {
    y <- 2
    mysquare <- function(a, b) {
        a^b
    }
    mysquare(x, y)
}
myfunc(3)


## 12.5.9 함수에 관한 정보를 본다

f <- function(x) x^2          # 함수 정의
f                             # 함수 정의식을 확인
body(f)                       # 함수 body(f)로도 조사할 수 있다.
formals(f)                    # 함수 f의 형식인수를 조사한다.
formals(f) <- alist(x=, y=2)  # 형식인수 x, y를 설정한다.
f                             # f의 정의를 확인
formals(f) <- alist(x = , y = 2, ... =)  # 그 밖의 인수...
f

methods(mean)

mean.default


## 12.5.10 함수 종료 시의 처리

myfunc <- function(x) {
    oldpar <- par()        # 처음에는 그래픽스 파라미터를 저장한다.
    par(col="red")
    plot(x)
    par(oldpar)            # 마지막에는 그래픽스 파라미터를 원래대로 되돌린다.
}
myfunc(1:10)

myfunc <- function(x) {
    oldpar <- par()        # 처음에는 그래픽스 파라미터를 저장한다.
    on.exit(par(oldpar))   # 함수 종료 시에 par(oldpar)를 실행한다.
    par(col="red")
    plot(x)
}
myfunc(1:10)

on.exit(par(oldpar), add=T)  # 종료 처리: par(oldpar)를 추가
on.exit(par(oldpar), add=F)  # 종료 처리: par(oldpar)만 실행
on.exit()                    # 함수 종료 시의 처리를 무효로 한다.


## 12.6 인수

## 12.6.1 인수 검사

myfunc <- function(n) ifelse(n==0, 1, prod(1:n))
myfunc(0)
myfunc(5)

myprod <- function(n) {
    if (n != floor(n) || n < 0) return()
    else return(gamma(n+1))
}
myprod(3)
myprod(-1)


## 12.6.2 인수의 생략

## (1)인수의 선언부에서 지정하는 방법

myfunc <- function(x, y=1) {
    return(x * y)       # 두 인수의 곱셈
}
myfunc(2, 5)
myfunc(2)               # 인수를 하나만 지정하면 인수를 그대로 반환한다.

myfunc <- function(x, y=x^2) {
    return(x * y)
}
myfunc(2, 5)
myfunc(2)

myfunc <- function(x=2*y, y=x^2) {
    return(x * y)
}
myfunc(2)
myfunc()


## (2)함수 missing()을 사용하는 방법

myfunc <- function(x, y) {
    if( missing(y)) return (x)
    else return(x * y)
}
myfunc(2, 5)
myfunc(2)

myfunc <- function(x, y=1) {
    if (missing(y)) warning("y isn't inputted.")
    return(x * y )
}
myfunc(3, 2)
myfunc(2)


## 12.6.3 임의 개의 인수를 받는다

myfunc1 <- function(x, ...) {
    xlabel <- deparse(substitute(x))    # 첫 번째 인수의 변수명을 취득
    plot(x, xlab=xlabel, ...)           # plot()에도 ...를 지정한다.
}
x <- 1:10
myfunc1(x, ylab="y")
myfunc2 <- function(...) {
    args <- list(...)                   # 인수의 리스트
    return(args)
}
myfunc2(1:10, "title")

myfunc <- function(..., y = 1) {
    2 * y
}


## 12.6.4 인수로 함수를 지정한다

(x <- matrix(1:6, 2))
apply(x, 2, sum)

(x <- matrix(1:6, 2))
apply(x, 2, function(x) { x + 700 })

myfunc <- function(x, f) f(x)
myfunc(2, sqrt)
myfunc <- function(x, f=log) f(x)
myfunc(2)                # 기존 함수 log가 사용된다.

myfunc <- function(x, f=log) f(x)
x <- 1
myfunc(x, f=function(y) 1 / (1 + exp(y)))        # 함수 정의를 직접 지정한다.

myfunc1 <- function(x, alpha=0) mean(x, alpha)
myfunc2 <- function(x, alpha, fun) fun(x, alpha)
myfunc2(c(0, 1, 4, 9, 16), 0.4, myfunc1)


## 12.6.5 인수의 매칭과 선택

plot(sin, xlab = "x-title")    # x축에 타이틀을 붙인다.
plot(sin, xla  = "x-title")    # 'xla'라고 해도 'xlab'라고 인식한다.
plot(sin, xl   = "x-title")    # 'xl'로는 'xlab'라고 인식하지 못한다.

myfunc <- function(a, b, do = c("sum", "minus", "multi", "div")) {
    do <- match.arg(do)
    switch(do, sum   = a + b,      # do(match.arg의 반환값)
               minus = a - b,      # 의 결과로 조건 분기
               multi = a * b,
               div   = a / b)
}
myfunc(3, 2, "minus")
myfunc(3, 2, "mi")        # 인수가 'mi'이더라도 'minus'라는 것을 알 수 있다.
myfunc(3, 2, "m")         # 'm'으로는 'minus'라는 것을 알 수 없다.


## 12.7 재귀호출

myfunc <- function(n) {
    if (n <= 1) return(1)
    else        return(n * myfunc(n - 1))
}
myfunc(5)

myfunc <- function(n) {
    if (n <= 1) return(1)
    else        return(n * Recall(n-1))
}
myfunc(10)


## 12.8 디버그

## 12.8.1 실행 중에 변수의 값을 조사한다: cat(), print()

myfunc <- function(z) {
    x <- rnorm(1)
    y <- rnorm(1)
    cat("x = ", x, "\n")             # 현재의 x값을 조사한다.
    cat("y = ", y, "\n")             # 현재의 y값을 조사한다.
    if ((x < 0) || (y < 0)) s <- -x * y
    else                    s <-  x * y
    cat("s = ", s, "\n")             # 현재의 s값을 조사한다.
    return(s * z)
}
myfunc(10)


## 12.8.2 평가 도중에 변수를 조사한다: browser()

myfunc <- function(z) {
    x <- rnorm(1)
    y <- rnorm(1)
    if ((x < 0) || (y < 0)) s <- -x * y
    else                    s <-  x * y
    browser()                       # 현재 상황을 조사한다.
    return(s * z)
}

myfunc(10)


## 12.8.3 디버그 모드에 들어간다: debug()

debug(myfunc)
myfunc(10)


## 12.8.4 함수 호출을 추적한다: trace()

trace(myfunc, browser, exit = browser)
myfunc(10)

trace(myfunc, recover)
myfunc(5)

untrace("myfunc")
untrace(c("func", "myfunc"))


## 12.9 보충학습

## 12.9.1 파일에 저장된 함수 정의를 불러온다

source("C:/dis.R")


## 12.9.2 함수를 저장해서 재사용할 수 있게 한다.

myfunc <- function(x) x^2
save(myfunc, file="myfunc.Rdata")

load("myfunc.Rdata")


## 12.9.3 연속된 변수를 만든다

for (i in 1:10) {
    assign(paste("x", i, sep=""), i)    # 변수 xi에 i를 대입
}
x1
x2


## 12.9.4 수치 벡터의 대화식 입력: readline()

fun <- function(){
    ANSWER <- readline("Are you a satisfied R user? ")
    if (substr(ANSWER, 1, 1) == "n")
        cat("This is impossible. You LIED!\n")
    else
        cat("I knew it.\n")
}
fun()

myfunc <- function() {
    x <- readline("데이터 입력: ")
    unlist(strsplit(x, " "))
}
y <- myfunc()
y

x <- 1:10
y <- get(readline())
y


## 12.9.5 메뉴에 의한 선택: menu()

switch(menu(c("List letters", "List LETTERS")) + 1,
       cat("Nothing done\n"), letters, LETTERS)


## 12.9.6 객체 지향 프로그래밍

## 12.9.7 배치 처리

R CMD BATCH --vanilla myprogram.r myoutout.txt

system(paste("C:/Program Files/Mozilla FireFox/firefox.exe",
             '-url cran.r-project.org'), wait = FALSE)

shell("명령")         # 지정한 명령을 프롬프트에서 실행한다.
shell.exec("파일")    # 지정한 파일을 적당한 소프트웨어로 연다.
