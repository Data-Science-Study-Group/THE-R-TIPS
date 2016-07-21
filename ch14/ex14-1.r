# 14장. 통계분석의 비망록

## 14.1 확률분포와 난수

## 14.1.1 함수의 사용법

## 정규분포(norm)에 관한 확률밀도 f(0)과 정규분포에 따른 난수
dnorm(0)    # 확률밀도(이산분포인 경우에는 확률함수)
rnorm(5)    # 난수

## 확률밀도 그래프
curve(dnorm, -4, 4, type="l")                         # 정규분포
plot(0:10, dbinom(0:10, 10, 0.5), type="h", lwd=5)    # 이항분포

## 자유도가 (2, 3)인 F분포의 상축 5% 점
qf(0.95, 2, 3)
qf(0.05, 2, 3, lower=FALSE)


## 14.1.2 R에 준비된 확률분포

qbirthday(prob=0.5, classes=365, coincident=2)    # 일차확률
pbirthday(10, classes=365, coincident=2)          # 지정된 일차확률에 필요한 관측수
rmultinom(9, size=12, prob=c(0.1, 0.2, 0.8))
rmultinom(9, size=10, prob=c(0.1, 0.2, 0.3, 0.4))   # 다항분포에 따른 난수
dmultinom(1:4, size=10, prob=c(0.1, 0.2, 0.3, 0.4)) # 다항분포의 확률함수


## 14.1.3 난수의 재현: set.seed()

runif(5)                 # 일양난수
runif(5)                 # 당연히 매번 다른 난수가 얻어진다.
set.seed(101); runif(5)  # 난수의 시드(seed)를 지정
set.seed(101); runif(5)  # 난수의 시드를 똑같이 하면 난수를 재현할 수 있다.


## 14.1.4 주변합을 지정한 랜덤한 분할표

x <- r2dtable(2, c(10, 10), c(15, 5))
x


## 14.1.5 랜덤 추출

n <- 20; m <- 5
x <- 1:n                           # 그냥 n으로 해도 된다.
sample(x, m, replace=TRUE)         # 같은 요소가 선택되어도 좋다.
sample(x)                          # m=n으로 랜덤한 치환
sample(c(0,1), 100, replace=TRUE)  # 100개의 베르누이 치환

p <- runif(n);  p <- p/sum(p)
sample(x, m, replace=TRUE, prob=p)


## 14.2 수치 데이터의 요약 통계량

group  <- rep(c("A", "B", "C"), length=20)
weight <- floor(70 + 10 * rnorm(20))
x      <- data.frame(GROUP=group, WEIGHT=weight)
head(x)
summary(x$WEIGHT)    # WEIGHT의 요약 통계량
fivenum(x$WEIGHT)    # WEIGHT의 5수 요약

## 인자의 각 수준별로 요약 통계량을 구할 때, (GROUP별로 WEIGHT의 요약 통계량)
tapply(x$WEIGHT, x$GROUP, summary)
by(x$WEIGHT, x$GROUP, summary)


## 14.3 도수분포표와 줄기잎 그림

## 14.3.1 도수분포표

group  <- rep(c("A", "B", "C"), length=20)
sex    <- c(rep("F", 8), rep("M", 12))
weight <- floor(70 + 10 * rnorm(20))
x      <- data.frame(GROUP=group, SEX=sex, WEIGHT=weight)
head(x)

table(x$SEX)
xtabs(~SEX, data=x)
table(x$SEX, x$GROUP)
xtabs(~SEX+GROUP, data=x)

(y <- xtabs(~SEX+GROUP, data=x))
addmargins(y, margin=1)
addmargins(y, margin=2)
addmargins(y, margin=1:2)


## 14.3.2 비율에 관한 도수분포표

(y <- xtabs(~SEX+GROUP, data=x))
prop.table(y, margin=1)
prop.table(y, margin=2)


## 14.3.3 도수분포표에 관한 막대그래프

y <- xtabs(~SEX+GROUP, data=x)     # 도수분포
barplot(y)

z <- prop.table(y, margin=1)       # 비율
barplot(z)


## 14.3.4 수치 벡터로부터 도수분포표 작성

(x$WEIGHT2 <- cut(x$WEIGHT, breaks=seq(50, 90, by=10)))
table(x$WEIGHT2)
xtabs(~WEIGHT2+GROUP, data=x)


## 14.3.5 줄기잎 그림

stem(x$WEIGHT)


## 14.4 히스토그램과 밀도추정

## 14.4.1 참밀도와 데이터 준비

truedensity <- function(x) {
    0.6 / sqrt(2 * pi) * exp(-(x + 1)^2 / 2) + 0.4 / sqrt(2 * pi) * exp(-(x - 2)^2 / 2)
}
curve(truedensity, xlim=c(-6, 6), ylim=c(0, 0.3))

generator <- function(n) {
    data1 <- rnorm(n) - 1                # Φ(x)에 따른 난수
    data2 <- rnorm(n) + 2                # Ψ(x)에 따른 난수
    data3 <- (runif(n) <= 0.6)           # 확률 0.6으로 data1을 채택하고
    data1 * data3 + data2 * (1 - data3)  # 확률 0.4로 data2를 채택한다.
}


## 14.4.2 히스토그램에 의한 밀도추정

x <- generator(1000)
hist(x)
hist(x, breaks="Scott")

x <- generator(40)
h1 <- seq(-4.5, 5.5, 0.5)
h2 <- seq(-4.2, 5.2, 0.5)
hist(x, breaks=h1)
hist(x, breaks=h2)


## 14.4.3 커널에 의한 추정

x <- generator(100)
plot(density(x), xlim=c(-6, 6), ylim=c(0, 0.3), type="p")
par(new=T)
curve(truedensity, xlim=c(-6, 6), ylim=c(0, 0.3), ann=F)

plot(density(x))
rug(x)
rug(jitter(x, amount=.1), side=3, col="light blue")

curve(truedensity, xlim=c(-6, 6), ylim=c(0, 0.3))
par(new=T)
plot(density(x, bw="SJ"), xlim=c(-6, 6), ylim=c(0, 0.3),
     xlab="", ylab="", type="p")


## 14.4.4 2차원 데이터의 밀도추정

install.packages("gregmisc")
library(gregmisc)
x <- rnorm(2000, sd=4)        # 데이터: 무상관인 2변량 정규난수
y <- rnorm(2000, sd=1)
h2d <- hist2d(x, y, show=F, same.scale=T, nbins=c(20, 30))
persp(h2d$x, h2d$y, h2d$counts,
      ticktype="detailed", theta=60, phi=30,
      expand=0.5, shade=0.5, col="cyan", ltheta=-30)

library(MASS)             # 함수 width.SJ()를 사용하기 위해
library(KernSmooth)       # 함수 bkde2D()를 사용하기 위해
x <- rnorm(2000, sd=4)    # 데이터 준비
y <- rnorm(2000, sd=1)    # 데이터 준비
f1 <- bkde2D(cbind(x, y),
             bandwidth=c(width.SJ(x), width.SJ(y)))
persp(f1$fhat, phi=30, theta=20, d=5)


## 14.5 검정함수 목록

## 14.5.1 검정예(1): 비율검정과 이항검정

nattou <- c(245, 157)
total  <- c(300, 250)
prop.test(nattou, total)

x <- c(3, 1, 1, 2, 4, 2, 4, 5, 3, 2)
y <- c(2, 1, 2, 1, 5, 1, 5, 5, 3, 1)
binom.test(c(length(x[x > y]), length(x[x < y])))


## 14.5.2 검정예(2): 만-휘트니의 U 검정

A <- c(rep(5, 8), rep(4, 11), rep(3, 9), rep(2, 2), rep(1, 3))
B <- c(rep(5, 4), rep(4, 6), rep(3, 10), rep(2, 8), rep(1, 4))
wilcox.test(A, B, exact=F, correct=F)     # exact    = F : 점근정규성을 사용한다.
                                          # correct  = F : 연속성 수정을 하지 않는다. 

wilcox.test(A, B, exact=F, conf.int=TRUE)


## 14.5.3 검정예(3): 카이제곱검정과 피셔의 직접확률검정

x <- matrix(c(14, 8, 4, 17), ncol=2, byrow=T)
chisq.test(x)     # x² 검정
fisher.test(x)    # 피셔의 직접확률검정


## 14.5.4 검정예(4): 상관계수에 대한 검정

x <- c(70, 72, 62, 64, 71, 76, 60, 65, 74, 42)
y <- c(70, 74, 65, 68, 72, 74, 61, 66, 76, 75)
cor.test(x, y, method="pearson")


## 14.5.5 검정예(5): 분산분석

x <- c(1.00, 2.00, 3.00, 4.00, 5.00, 6.00, 7.00, 8.00, 9.00)
y <- c(1.09, 2.12, 2.92, 4.06, 4.90, 6.08, 7.01, 7.92, 8.94)
z <- c(1.10, 1.96, 2.98, 4.09, 4.92, 6.10, 6.88, 7.97, 9.01)
mydata <- c(x, y, z)                           # 데이터
group <- c(rep(1, 9), rep(2, 9), rep(3, 9))    # 집단을 지정
oneway.test(mydata ~ group, var=T)

## 분산분석표 lm(), anova()
anova(lm(mydata ~ group))

tmp <- data.frame(x,y,z)
head(tmp)

mydata <- stack(tmp)
head(mydata, n=10)


## 14.5.6 검정예(6): 정규분포와의 비교

x <- rt(50, df=10)

(y <- ecdf(x))        # 데이터 x의 경험분포함수
plot(y, do.point=FALSE, verticals=TRUE)

par(pty="s")
qqnorm(x)        # 표본의 플롯
qqline(x)        # 이론분포의 직선을 추가한다.

shapiro.test(x)
ks.test(x, "pnorm", mean=mean(x), sd=sd(x))

x <- ecdf(x)
plot(y, do.point=FALSE, verticals=TRUE)
z <- -5:5
lines(z, pcauchy(z, location=0, scale=1))


## 14.5.7 다중비교

p <- c(0.01, 0.05, 0.10)          # p값
p.adjust(p, method="none")        # p값 조정 없음
p.adjust(p, method="bonferroni")  # p값을 bonferroni 방법으로 조정

x <- ToothGrowth
head(x)
pairwise.t.test(x$len, x$dose, p.adj="holm")  # holm 방법으로 조정

result <- t.test(extra ~ group, data=sleep, paired=TRUE)
result
str(result)
result$p.value


## 14.6 검출력 계산과 예수설계

power.t.test(n=50, delta=0.5, sd=1.0)

power.t.test(power=0.8, delta=0.5, sd=1.0)


## 14.7 회귀분석

head(swiss)
help(swiss)    # 데이터 프레임 swiss에 관한 정보


## 14.7.1 함수 lm()의 서식과 인수 지정

(result <- lm(Fertility ~ Education , data=swiss))
AIC(result)    # 모델에 대해 AIC를 구한다.

lm(log(Fertility) ~ log(Education), data=swiss)

result1 <- lm(Fertility ~ Education, data=swiss)
result2 <- update(result1, . ~ . + Agriculture)    # 설명변수를 추가
result3 <- update(result2, sqrt(.) ~ .)            # 제곱근 변환을 시행
result4 <- lm(Fertility ~ . , data=swiss)          # 모든 변수를 이용한다.


## 14.7.2 모델 정보를 추출하는 함수

result <- lm(Fertility ~ Education, data=swiss)
plot(result)       # 회귀진단에 관한 그래프


## 14.7.3 중회귀분석과 모델 선택

result <- lm(Fertility ~ . , data=swiss)
summary(result)        # 결과 표시

result2 <- step(result)


## 14.7.4 모델 선택의 규준

install.packages("wle")
library(wle)
result1 <- mle.cp(Fertility  ~ Agriculture + Education, data=swiss)
result2 <- mle.aic(Fertility ~ Agriculture + Education, data=swiss)
result3 <- mle.cv(Fertility  ~ Agriculture + Education, data=swiss)
summary(result3)          # 교차검증법 규준에 의한 중회귀모델 선택


## 14.7.5 회귀식에서 F통계량의 p값을 계산한다

result <- summary(lm(Fertility ~ . , data=swiss))
str(result$fstatistic)

f.stat <- result$fstatistic
p.value <- 1-pf(f.stat["value"], f.stat["numdf"], f.stat["dendf"])
p.value


## 14.8 그 밖의 분석 방법 소개

## 14.8.1 함수 lsfit()에 의한 최소제곱법

x <- c( 64, 70, 58, 66, 81, 73, 75, 72, 90, 53)
y <- c(177, 175, 162, 176, 184, 170, 179, 177, 188, 157)
z <- lsfit(x, y)   # 추정 결과를 z에 저장
print(z)           # coefficients, residuals, intercept, qr을 출력

y - z$residuals

plot(x, y)
abline(z, col=2)

ls.diag(z)         # std.deb, hat, std.res, stud.rest 등을 출력


## 14.8.2 함수 lowess()에 의한 평할화

data(cars)
plot(cars, main="lowess(cars)")
lines(lowess(cars), col=2)
lines(lowess(cars, f=0.2), col=3)
legend(5, 120, c(paste("f = ", c("2/3", ".2"))), lty=1, col=2:3)


## 14.8.3 비선형회귀분석

f <- function(x) 20 / (1 + 50 * exp(-0.8 * x))
x <- 1:20
y <- f(jitter(x))
(result <- nls(y ~ a / (1 + b * exp(-c * x)), start=c(a=50, b=20, c=0.1)))

predict.c <- predict(result)
plot(x, y, ann=F, xlim=c(0, 20), ylim=c(0, 20))
par(new=T)
plot(predict.c, type="l", xlim=c(0, 20), ylim=c(0, 20))


## 14.8.4 일반화 선형모델과 로지스틱회귀

counts <- c(18, 17, 15, 20, 10, 20, 25, 13, 12)
outcome <- gl(3, 1, 9)
treatment <- gl(3, 3)
result <- glm(counts ~ outcome + treatment, family=poisson())
anova(result)

library(survival)
result <- glm(status ~ x, data=aml, family=binomial)
summary(result)


## 14.8.5 인자분석

v1 <- c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 4, 5, 6)
v2 <- c(1, 2, 1, 1, 1, 1, 2, 1, 2, 1, 3, 4, 3, 3, 3, 4, 6, 5)
v3 <- c(3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 4, 6)
v4 <- c(3, 3, 4, 3, 3, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 5, 6, 4)
v5 <- c(1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 6, 4, 5)
v6 <- c(1, 1, 1, 2, 1, 3, 3, 3, 4, 3, 1, 1, 1, 2, 1, 6, 5, 4)
m1 <- cbind(v1, v2, v3, v4, v5, v6);
cor(m1)
factanal(m1, factors=3)


## 14.8.6 주성분분석

data(USArrests)
prcomp(USArrests)
prcomp(USArrests, scale=TRUE)
plot(prcomp(USArrests))
summary(prcomp(USArrests, scale=TRUE))


## 14.8.7 정준상관분석

data(LifeCycleSavings)
pop <- LifeCycleSavings[, 2:3]
oec <- LifeCycleSavings[, -(2:3)]
cancor(pop, oec)          # 일반적인 통계 교과서에 실려 있는
                          # 출력과는 다르므로 주의


## 14.8.8 판별분석

data(iris3)
Iris <- data.frame(rbind(iris3[,,1], iris3[,,2], iris3[,,3]),
                   Sp = rep(c("s", "c", "v"), rep(50, 3)))
train <- sample(1:150, 75)
table(Iris$Sp[train])
library(MASS)
z <- lda(Sp ~ ., Iris, prior = c(1, 1, 1) / 3, subset=train)
predict(z, Iris[-train, ])$class

data(iris3)
tr <- sample(1:50, 25)
train <- rbind(iris3[tr,,1], iris3[tr,,2], iris3[tr,,3])
test <- rbind(iris3[-tr,,1], iris3[-tr,,2], iris3[-tr,,3])
cl <- factor(c(rep("s", 25), rep("c", 25), rep("v", 25)))
library(MASS)
z <- qda(train, cl)
predict(z, test)$class


## 14.8.9 클러스터분석

data(USArrests)
hc <- hclust(dist(USArrests), "ave")
plot(hc)
plot(hc, hang = -1)
rect.hclust(hc, 5, 4)

x <- rbind(matrix(rnorm(100, sd=0.3), ncol=2),
           matrix(rnorm(100, mean=1, sd=0.3), ncol=2))
cl <- kmeans(x, 2, 20)
plot(x, col=cl$cluster)
points(cl$centers, col=1:2, pch=8)


## 14.8.10 회귀트리

library(rpart)                      # 패키지 호출
data(iris);  attach(iris)           # 데이터 iris 로딩
ir.tr <- rpart(Species ~ . , data=iris, minsplit=5)
summary(ir.tr)                      # 생성한 회귀트리 요약
plot(ir.tr); text(ir.tr)            # 회귀트리 그리기

ir.tr <- prune(ir.tr, cp=0.1)       # cp는 트리의 복잡도
plot(ir.tr); text(ir.tr)            # 회귀트리 그리기


## 14.8.11 시계열분석

data(lh)
tsp(lh)

(result <- ar(lh))
predict(result)

data(UKLungDeaths)
ts.plot(ldeaths, mdeaths, fdeaths,
        gpars=list(xlab="year", ylab="deaths", lty=c(1:3)))


## 14.8.12 생존시간분석

library(survival)
fit <- survfit(Surv(time, status) ~ x, data=aml)   # 캐플런 마이어 추정
plot(fit)                                          # 캐플런 마이어 플롯
summary(fit)
survdiff(Surv(time, status) ~ x, data=aml)         # 로그 순위 겸정
coxph(Surv(time, status) ~ x, data=aml)            # Cox 회귀


## 14.8.13 논파라메트릭회귀

data(cars)
with(cars, {
    plot(speed, dist)
    lines(ksmooth(speed, dist, "normal", bandwidth=2), col=2)
    lines(ksmooth(speed, dist, "normal", bandwidth=5), col=3)
})

data(cars)
attach(cars)
plot(speed, dist, main = "data(cars) & smoothing splines")
(cars.spl <- smooth.spline(speed, dist))
lines(cars.spl, col="blue")
lines(smooth.spline(speed, dist, df=10), lty=2, col="red")
legend(5, 120, c(paste("default [C.V.] => df =",
                       round(cars.spl$df, 1)), "s( * , df= 10)"),
       col=c("blue", "red"), lty=1:2, bg='bisque')

library(survival)
data(cancer)
lfit6 <- survreg(Surv(time, status)~pspline(age, df=2),cancer)
plot(cancer$age, predict(lfit6), xlab='Age', ylab="Spline prediction")
title("Cancer Data")
fit0 <- coxph(Surv(time, status) ~ ph.ecog + age, cancer)
fit1 <- coxph(Surv(time, status) ~ ph.ecog + pspline(age,3), cancer)
fit3 <- coxph(Surv(time, status) ~ ph.ecog + pspline(age,8), cancer)


## 14.8.14 함수의 최대화.최우추정법

LL <- function(p) choose(10, 3) * p^(3) * (1 - p)^(7)    # 동시밀도분포
optim(0, LL, control=list(fnscale=-1), method="BFGS")    # 초깃값(0, 1)

x <- function(x, a)(x - a)^2
xmin <- optimize(f, c(0, 1), tol=0.0001, a = 1 / 3)
xmin


## 14.8.15 함수의 최소화

LL <- function(p) -choose(10, 3) * p^(3) * (1 - p)^(7)   # 동시밀도분포
nlm(LL, 0.5, fscale=-1)                                  # 초깃값 0.5


## 14.8.16 수리계획법

install.packages("lpSolve")
library(lpSolve)
f.obj <- c(1, 9, 1)
f.con <- matrix(c(1, 2, 3, 3, 2, 2), nrow=2, byrow=TRUE)
f.dir <- c("<=", "<=")
f.rhs <- c(9, 15)
lp("max", f.obj, f.con, f.dir, f.rhs)
lp("max", f.obj, f.con, f.dir, f.rhs)$solution
lp("max", f.obj, f.con, f.dir, f.rhs, int.vec=1:3)
lp("max", f.obj, f.con, f.dir, f.rhs, int.vec=1:3)$solution


## 14.8.17 신경망

library(nnet)
tmp <- c(sample(1:50, 25), sample(51:100, 25), sample(101:150, 25))
x <- iris[ tmp, ]    # 학습하기 위한 데이터 75개
y <- iris[-tmp, ]    # 예측하기 위한 데이터 75개
table(x$Species)     # 학습하기 위한 데이터의 내역
table(y$Species)     # 예측하기 위한 데이터의 내역
result <- nnet(Species ~ ., size=2, data=x)    # 실행
result2 <- max.col(predict(result, y))         # 예측
table(y$Species, result2)                      # 예측 정밀도 확인


## 14.8.18 베이즈 추정

install.packages("R2WinBUGS")
library(R2WinBUGS)

n <- 20
x <- 11
data <- list("n", "x")
inits <- function() list(theta=0.2)
parameters <- c("theta")
result <- bugs(data, inits, parameters, model.file="model.txt",
               n.chains=3, n.iter=5000)
print(result)


## 14.8.19 부트스트랩

x <- sort(floor(3 + rnorm(100)))
B <- 1000
result <- c()
for (i in 1:B) {
    (y <- sort(sample(x, replace=T)))
    result <- c(result, mean(y))
}

mean(x)                   # 표본평균
mean(result)              # 부트스트랩 평균
sqrt(var(x) / length(x))  # 표본평균의 표준오차
sd(result)                # 부트스트랩 표준오차
quantile(result, p=c(0.025, 0.975))  # 2.5% 점, 97.5% 점의 계산 -> 95% 신뢰구간의 추정

install.packages("simpleboot")
library(boot)
library(simpleboot)
result2 <- one.boot(x, mean, 1000)    # 부트스트랩 결과
boot.ci(result2)                      # 부트스트랩 신뢰구간


## 14.8.20 스도쿠로 놀기

library(sudoku)
(Q1 <- generateSudoku())       # 문제 생성(배열 형식)
Q2 <- fetchSudokuUK()          # sudoku.org.uk에서 '오늘의 문제' 가져오기
solveSudoku(Q1)                # 문제 Q1을 푼다.
playSudoku()                   # GUI로 스도쿠를 플레이한다.
playSudoku(Q1)                 # GUI로 문제 'Q1'을 플레이한다.
playSudoku(fetchSudokuUK())    # sudoku.org.uk의 '오늘의 문제'를 플레이한다.
writeSudoku(Q1, "Q1.txt")      # 문제 'Q1'을 파일 Q1.txt로 출력한다.
