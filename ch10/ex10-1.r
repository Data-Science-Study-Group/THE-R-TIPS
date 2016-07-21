# 10장 그밖의 기본사항

## 10.1 도움말 보기

## 10.1.1 명령을 입력해서 도움말을 본다.

help(log)
?log
args(log)    # 함수의 인자를 알고자 할 때

help("for")
?"for"

help.search("solve")

example(solve)


## 10.1.2 HTML 파일로 도움말을 본다

## 10.2 패키지

## 10.2.1 패키지 읽어 들이기

library()

library(rgl)


## 10.2.2 패키지 조작

## 10.2.3 패키지 설치

## 미러사이트 설정 (중앙대학교)
options(repos="http://biostat.cau.ac.kr/CRAN/")

## rgl패키지 설치
install.packages("rgl")

## 압축파일로 설치
install.packages("/path/to/rgl_0.82.zip", repos=NULL)

## CRAN 패키지 업데이트
update.packages(ask=F, destdir=".")


## 10.3 R에 의한 계산과 수학함수

## 10.3.1 대입

x <- pi / 2    # 이 방식을 추천
pi / 2 -> x
x = pi / 2
assign("x", pi / 2)


## 10.3.2 R의 수학함수

sqrt(c(1, 2, 3, 4, 5))    # 1 ~ 5 각각에 대해 제곱근을 구한다.


## 10.3.3 감마함수

## 10.3.4 계승의 계산

factorial(3)


## 10.3.5 베셀함수

## 10.4 사용한 변수(오브젝트)의 확인과 제거

objects()
objects(all=TRUE)     # 도트로 싲가하는 파일(숨은 오브젝트)도 표시한다.
rm(x)                 # 오브젝트 x를 삭제한다.
rm(list=ls(all=TRUE)) # 모든 오브젝트를 삭제한다.


## 10.5 함수와 연산자

## 10.5.1 함수의 정의를 본다

sd

mean

methods(mean)

mean.default


## 10.5.2 비교 연산자

x <- 1; y <- 1; z <- 1.00000000001;
(x==y)                              # 일반적인 일치검사
identical(all.equal(x, z), TRUE)    # R에서 권장하는 일치검사
identical(1, 1.)                    # 1과 1.은 모두 배정도 실수
identical(1, as.integer(1))         # as.integer(1)은 정수형이므로 FALSE가 된다.

x <- 1; y <- 1.; u <- 2;
all.equal(x, y)
all.equal(x, u)


## 10.5.3 논리 연산자

(2 > 0)    # 조건: 2는 0보다 큰가?
(2 > 5)    # 조건: 2는 5보다 큰가?

x <- 1; y <- 2;
(x > 0) && (y > 0)

z <- c(3, 4, 5)
(z > c(4, 4, 4)) | ( z < c(3, 3, 3))

xor(c(TRUE, TRUE, FALSE), c(TRUE, FALSE, FALSE))


## 10.5.4 인수의 생략

log(x)                   # base 생략 시는 base=2.71828182845905로 계산
log(x, 2.718281828)
log(base=2.718281828, x)
log(x <- 2)


## 10.6 반올림, 올림, 내림과 수치연산오차

## 10.6.1 반올림, 올림, 내림

## 10.6.2 수치연산오차

0.6 - 0.3 - 0.3
0.6 - 0.4 - 0.2
round(0.6 - 0.4 - 0.2)


## 10.7 계산 방법과 계산 속도

n <- 1000000
x <- runif(n)
y <- runif(n)
system.time(x * y)[3]
system.time(for (i in 1:n) x[i] * y[i])[3]

n <- 1000000
m <- sqrt(n)
x <- matrix(runif(n), m)
y <- matrix(runif(n), m)
task1 <- function() { x * y }
task2 <- function() for (i in 1:m) for(j in 1:m) x[i,j] * y[i,j]
system.time(task1())[3]
system.time(task2())[3]

mymontecarlo2 <- function(n, k, fun) {
    count <- 0
    for (i in 1:n) {
        count <- count + fun(k)
    }
    return(count/n)
}
system.time( mymontecarlo2(100000, 1, rnorm)) [3]
system.time(mean(rnorm(100000)) )[3]

n <- 10000000
coin <- function() {
    x <- runif(1)
    if (x <= 1/2) men <- 1     # 1: 앞변
    else          men <- 0     # 0: 뒷면
    return(men)
}
mycointoss1 <- function(n) {
    count <- 0
    for(i in 1:n) if (coin() == 1) count <- count + 1
    return(count)
}
mycointoss2 <- function(n) {
    count <- 0
    for (i in 1:n) count <- count + coin()
    return(count)
}
system.time(mycointoss1(n))[3]
system.time(mycointoss2(n))[3]

mycointoss3 <- function(n) {
    count <- runif(n)
    return(length(count[count <= 0.5]))
}
system.time(mycointoss3(n))[3]
