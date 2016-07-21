# 8장 그래프 작성 입문

## 8.1 그래픽스와 R

## 8.2 고수준 작도함수

## 8.2.1 plot()함수

y <- c(1, 1, 2, 2, 3, 3, 4, 4, 5, 5)  # 1. 데이터를 준비한다.
plot(y)                               # 2. 그래프를 그린다(범위는 자동으로 정해진다).

x <- 1:10                             # 1. x축 데이터를 준비한다.
y <- 1:10                             # 1. y축 데이터를 준비한다.
plot(x, y)                            # 2. 그래프를 그린다(범위는 자동으로 정해진다).

plot(sin, -pi, 2 * pi)                # 2. 정현함수를 그린다.
curve(sin, -pi, 2 * pi)               # 2. curve() 함수: 위와 동일한 그래프.

gauss.density <- function(x) {        # 1. 표준정규분포의 밀도함수를 정의한다.
    1 / sqrt(2 * pi) * exp(-x^2 / 2)  #
}                                     #
plot(gauss.density, -3, 3)            # 2. 표준 정규분포를 그린다.
curve(gauss.density, -3, 3)           # 2. curve() 함수: 위와 동일한 그래프.


## 8.2.2 함수 plot()의 인수

x <- 1:10                             # 1. x축 데이터를 준비한다.
y <- 1:10                             # 1. y축 데이터를 준비한다.
plot(x, y, xlim=c(0, 11))             # 2. 그래프를 그린다(범위를 xlim으로 정한다).

plot(x, y, xlim=c(11, 0))             # 2. 그래프를 그린다(범위를 xlim으로 정한다).


y <- c(1, 3, 2, 4, 8, 5, 7, 6, 9)
plot(y, main="Simple Time Series")


y <- c(1, 3, 2, 4, 8, 5, 7, 6, 9)
plot(y, ylim=c(0,10), type="l")


plot(5:9, ylim=c(0,10), type="p", ylab=""); par(new=T)
plot(4:8, ylim=c(0,10), type="l", ylab=""); par(new=T)
plot(3:7, ylim=c(0,10), type="b", ylab=""); par(new=T)
plot(2:6, ylim=c(0,10), type="c", ylab=""); par(new=T)
plot(1:5, ylim=c(0,10), type="o", ylab="")
legend(4, 2.5, paste("type = ", c("p", "l", "b", "c", "o"), "    "))


x <- runif(100)
y <- runif(100)
plot(x, y, pch = ifelse(y>0.5, 1, 18))


## 8.3 저수준 작도함수와 그래프의 중첩

## 8.3.1 저수준 작도함수

plot(1:10)                               # 산포도를 그린다.
abline(h=5)                              # 직선: y=5를 추가한다.
rect(1, 6, 4, 9)                         # 왼쪽 상단에 사각형을 추가한다.
arrows(1, 1, 4, 4)                       # 왼쪽 하단에 화살표를 추가한다.
text(8, 9, "ABCD")                       # 오른쪽 상단에 문자를 추가한다.
title("main", "sub")                     # 제목과 부제목을 추가한다.
legend(8, 3, lty=1:3, c("P", "Q", "R"))  # 오른쪽 하단에 범례를 추가한다.


## 8.3.2 그래프의 중첩

plot(sin, -pi, pi, xlab="", ylab="", lty=2)    # sin(x)를 그린다.
par(new=T)                                     # 겹쳐서 그리기 지정
plot(cos, -pi, pi, xlab="x", ylab="y")         # cos(x)를 겹쳐서 그린다.
plot(sin, -pi, pi, xlab="x", ylab="y", lty=2)  # 새로 그래프를 그린다.
plot(cos, -pi, pi, add=T)                      # cos(x)를 겹쳐서 그린다.

F <- function(x, a){ 1 / (1 + exp(-a - x)) }    # 작도할 함수
curve(F(x, -1), col=1)
par(new=T)              # 앞의 그래프를 남겨둔 채로 다음 그래프를 그린다.
curve(F(x, 1), col=2)   # x축과 y축이 각각 중복되어 엉망이 됨

curve(F(x, -1), col=1, xlim=c(-5, 5), ylim=c(0,1))
par(new=T)
curve(F(x, 1), col=2, xlim=c(-5, 5), ylim=c(0,1)) # 좌표는 맞지만 y축 라벨은 겹침

curve(F(x, -1), col=1, xlim=c(-5, 5), ylim=c(0,1), ylab="")
par(new=T)
curve(F(x, 1), col=2, xlim=c(-5, 5), ylim=c(0,1), ylab="F(x, a)")

curve(F(x, -1), col=1, xlim=c(-5, 5), ylim=c(0,1), ylab="")
par(new=T)
curve(F(x, 1), col=2, xlim=c(-5, 5), ylim=c(0,1), ylab="F(x, a)")
legend(3, 0.4, c("a = -1", "a = 1"), lty=1, col=1:2) # 범례 추가


## 8.4 그래프의 저장

## 8.4.1 작업 디렉터리의 변경

setwd("d:/work/THE R TIPS/ch08")
getwd()


## 8.4.2 작도디바이스와 그래프의 저장

help("Devices")  # 작도 디바이스 조사

png(filename="filename.png", width=480, height=480,
    pointsize=12, b="white")

pdf(file="filename.pdf")  # pdf 디바이스를 연다.
plot(1:10)                # 플롯한다.
dev.off()                 # 디바이스를 닫는다.

postscript(file="filename.eps", horizontal=FALSE, onefile=FALSE,
           paper="special", height=9, width=14)
plot(1:10)                # 플롯한다.
dev.off()                 # 디바이스를 닫는다.

plot(1:10)                        # 그래프를 그린 다음
dev.copy(pdf, "filename.pdf")     # PDF로 출력하고
dev.copy2eps(file="filename.eps") # eps로 출력하고
dev.off()                         # 디바이스를 닫는다.


## 8.5 보충학습

## 8.5.1 그래프 제거

frame()
plot.new()


## 8.5.2 확률분포의 플롯

## 이항분포 확률함수
x <- 0:10
plot(x, dbinom(x, 10, 0.5), type="h", lwd=5)

## 정규분포 밀도함수
curve(dnorm, -4, 4, type="l")  # 플롯
xvals <- seq(2, 4, length=10)  # 음영을 추가
dvals <- dnorm(xvals)
polygon(c(xvals, rev(xvals)), c(rep(0, 10), rev(dvals)), col="gray")


## 8.5.3 3차원 플롯

x <- seq(-3, 3, length=61)  # x방향의 분점
y <- x                      # y방향의 분점
f <- function(x, y) {       # 2차원 정규분포의 함수
    return(1 / (2 * pi) *exp(-(x^2 + y^2) / 2))
}
z <- outer(x, y, f)         # z방향의 크기를 구한다.
persp(x, y, z, theta=30, phi=30, expand=0.5, col="lightblue")


## 8.5.4 rgl 패키지

options(repos="http://biostat.cau.ac.kr/CRAN/")
install.packages("rgl")

library(rgl)

example(rgl.surface)
for(i in 1:360) rgl.viewpoint(i, i/4)

clear3d()               # 도형 제거
clear3d(type="lights")  # 광원 설정 제거
clear3d(type="all")     # 바운딩 박스 설정 제거

x <- rnorm(100)         # x축 데이터 준비
y <- rnorm(100) * 2     # y축 데이터 준비
z <- rnorm(100) * 3     # z축 데이터 준비
plot3d(x, y, z)         # 3차원 산포도 그리기

x <- seq(-10, 10, length=51)
y <- x
f <- function(x, y) { r <- sqrt(x^2 + y^2); 10 * sin(r) / r }
z <- outer(x, y, f)
persp3d(x, y, z, aspect=c(1, 1, 0.5), col="lightblue", xlab="X", ylab="Y", zlab="")

snapshot3d("filename.png")
rgl.postscript("filename.pdf", "pdf", drawText=FALSE)
