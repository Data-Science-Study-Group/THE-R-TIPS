## 4.1 벡터 작성

sqrt(1.0); sqrt(2.0); sqrt(3.0); sqrt(4.0); sqrt(5.0);
c(1.0, 2.0, 3.0, 4.0, 5.0)

x <- c(1.0, 2.0, 3.0, 4.0, 5.0)
sqrt(x)
log(x)


## 4.2 벡터와 함수

x <- c(0, 1, 4, 9, 16)
mean(x)  # x의 평균

y <- c(1, 2, 3, 4)
z <- c(0, 5, 7, 9)
cor(y, z, method="pearson")  # y와 z의 pearson 상관계수
cor(y, z, method="spearman") # y와 z의 spearman 상관계수


## 4.3 벡터의 요소

x <- c(1, 2, 3, 4, 5)
x[2]
x[4] <- 0
x
c(x, 4)


## 4.4 벡터 연산

c(1, 2, 3) + c(4, 5, 6)
c(1, 2, 3) * c(4, 5, 6)

c(1.0, 2.0, 3.0, 4.0, 5.0) - 1    # 각 요소에서 1을 뺀다.

1:5   # 1에서 5까지 1씩 증가하는 벡터
3:-3  # 3에서 -3까지 1씩 감소하는 벡터