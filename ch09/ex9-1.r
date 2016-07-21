# 9장 데이터분석 입문

## 9.1 데이터분석의 흐름

## 9.2 데이터를 R로 읽어 들인다

flour <- c( 3, -2, -1,  0,  1, -2)  # 밀가루
diet  <- c(-4,  1, -3, -5, -2, -8)  # 다이어트약
total <- c(flour, diet)             # 12명 전원의 데이터


## 9.3 데이터를 플롯한다

hist(total)

plot(density(flour), xlim=c(-8, 8), ylim=c(0, 0.2), lty=1, ann=F)
par(new=T)
plot(density(diet), xlim=c(-8, 8), ylim=c(0, 0.2), lty=2)
legend(4, 0.2, c("밀가루", "다이어트약"), lty=1:2, ncol=1)   # 범례를 그린다.

boxplot(flour, diet, names=c("밀가루", "다이어트약"))


## 9.4 데이터의 통계량을 구한다

sum(total)
quantile(total, prob=0.8, name=F)  # 아래로부터 확률이 0.8인 위치의 데이터
fivenum(total)                     # min, 1Q, media, 3Q, max
sum((total - mean(total))^2)       # 평방합

variance <- function(x) var(x) * (length(x) - 1) / length(x)
variance(total)                    # 표본분산
var(total)                         # 불편분산
sd(total)                          # 표준편차 = sqrt((var(total))

var(flour, diet)    # 불편공분산행렬
cor(flour, diet)    # 상관계수


## 9.5 검정 결과 보는 법

## 9.5.1 검정함수의 기본

## 9.5.2 검정 사례(1): 1표본 t검정

t.test(diet, mu=0)                         # 양측검정
t.test(diet, mu=0, alternative="greater")  # 단측검정


## 9.5.3 검정 사례(2): 2표본 t검정

t.test(flour, diet, var.equal=T)


## 9.5.4 함수 t.test()의 인수

## 9.5.5 반환값

## 9.6 직선회귀 . 최소제곱법

## 9.6.1 직선회귀 . 최소제곱법 함수의 기본

## 9.6.2 데이터 입력과 플롯

height <- c(177, 165, 175, 168, 171, 168, 190, 167, 173, 172, 171, 177)
weight <- c(62, 65, 75, 58, 59, 66, 74, 61, 70, 80, 71, 68)
plot(weight, height)

result <- lm(height ~ weight)  # 단회귀분석
abline(result)


## 9.6.3 직선회귀 . 최소제곱법

result <- lm(height ~ weight)  # 단회귀분석
summary(result)                # 분석 결과 요약

new <- data.frame(weight = 68)
predict(result, new, interval="confidence", level=0.95)
predict(result, new, interval="predict", level=0.95)

new <- data.frame(weight=seq(55, 80, 1))
result.pre <- predict(result, new, interval="prediction")
result.con <- predict(result, new, interval="confidence")
matplot(new$weight, cbind(result.pre, result.con), type="l")


## 9.7 보충학습

## 9.7.1 분산이 같은지 다른지 검정하기

var.test(flour, diet)


## 9.7.2 편상관행렬

my.cor <- function(x) {
    tmpcor <- cor(x)
    if (det(tmpcor) != 0) sol <- solve(tmpcor)
    else { library(MASS); sol <- ginv(tmpcor) }
    d <- diag(sol)
    sol <- -sol / sqrt(outer(d, d))
    rownames(sol) <- paste("Var", 1:ncol(x))
    colnames(sol) <- paste("Var", 1:ncol(x))
    return(sol)
}
x <- matrix(c(1:9), ncol=3, byrow=T)
my.cor(x)


## 9.7.3 데이터의 표준화

height <- c(177, 165, 175, 168, 171, 168, 190, 167, 173, 172, 171, 177)
scale(height)
