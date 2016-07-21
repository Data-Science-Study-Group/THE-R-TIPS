# CHAPTER 6 수치계산 입문

## 6.1 뉴튼법

f <- function (x) exp(x) - 2    # 1. f(x)를 정의
(result <- uniroot(f, c(0, 1))) # 2. 범위를 c(0, 1)로 지정
result$root


## 6.2 다항식의 해

polyroot(c(2, 3, 1))  # (x+1)(x+2)=0의 해
round(polyroot(c(1, 2, 1)), digits=3)


## 6.3 함수의 미분

f <- expression(a*x^4)
D(f, "x")

DD <- function(expr, name, order = 1) {
    if (order < 1) stop("'order' must be >= 1")
    if (order == 1) D(expr, name)
    else DD(D(expr, name), name, order - 1)
}
DD(f, "x", 3)

f <- deriv(~ x^2, "x", func=T)
f(-2)

g <- deriv(~ x^2*y, c("x","y"), func=TRUE)
g(2, 3)

h <- deriv(~ x^2*y*z, c("x", "y"), function(x, y, z=4){ })
h(3,2)


## 6.4 수치 적분

f <- function(x) x^2
integrate(f, 0, 1)
integrate(sin, 0, pi)
integrate(dnorm, -Inf, 1.96) # dnorm: 정규분포의 밀도함수


## 6.5 행렬 작성과 기본 조작

matrix(1:6, nrow=2, ncol=3)
matrix(1:6, nrow=2, ncol=3, byrow=T)
matrix(1:6, 2, 3, T)
matrix(1:6, 2, , T)


## 6.5.1 행렬 요소 추출

(x <- matrix(1:6, nrow=2, ncol=3))
x[1, 2]        # 1행 2열의 성분 표시
x[c(1, 2), 2]  # 1, 2행에서 2열의 성분을 표시
x[2, c(1, 2)]  # 2행에서 1,2열의 성분을 표시

x[-1, c(T, F, T)]  # 1행은 비표시, 2행에서 1, 3열의 성분은 표시

x[2, ]         # 2행을 추출한다.
x[ ,2]         # 2열을 추출한다.

x[ ,2, drop=F] # 2열을 행렬 형태로 추출한다.

x[c(1, 2), c(1, 3)]  # 1, 2행의 1,3열을 추출한다.
x[,-c(1, 3)]   # 1, 3열을 제외한 행렬을 만든다.
x[matrix(c(1, 2, 2, 3), 2, 2)]  # 행렬로 지정
x[cbind(c(1, 2), c(2, 3))]
x[1:4]                          # 처음 4개 요소가 추출된다.


## 6.5.2 행렬의 결합

(x <- rbind(c(1, 2, 3), c(4, 5, 6)))  # 행 벡터를 지정해서 행렬 생성
(x <- cbind(c(1, 2, 3), c(4, 5, 6)))  # 열 벡터를 지정해서 행렬 생성

(x <- rbind(1:3, c(4, 5, 6), 7:9))  # 3개의 행 벡터를 결합
(x <- cbind(1:3, c(4, 5, 6), 7:9))  # 3개의 열 벡터를 결합


## 6.6 행렬의 계산

a <- matrix(1:4, 2, 2) # 2 * 2 행렬
b <- matrix(0:3, 2, 2) # 2 * 2 행렬
a + b - a %*% b        # 합, 차, 곱
a * b                  # 요소별 곱셈
a %o% b                # 외적
a %x% b                # 크로네커곱

a <- matrix(c(1,2,3,4), 2, 2) # 2 * 2 행렬
a * (1:2)                     # (1:2) * a도 같은 결과
1 / a


## 6.6.1 제로행렬

matrix(0, nrow=2, ncol=3)
diag(0, 3)                # 정방행렬일 때는 diag(0, 크기)


## 6.6.2 전치행렬

(x <- matrix(c(1,2,3,4), 2, 2))
t(x)


## 6.6.3 단위행렬과 대각행렬

(x <- diag(2))  # diag(1, ncol=2, nrow=2), diag(1, 3),
                # diag(rep(1, 3)), diag(c(1,1)) 등으로도 가능

diag(1:3)

x <- matrix(0, ncol=2, nrow=2)  # 모든 성분이 0인 행렬
diag(x) <- 1
x

diag(x) <- c(1, 2)  # 대각성분을 1, 2로 한다.
x


## 6.6.4 삼각행렬

(x <- matrix(1:9, 3))
x[upper.tri(x)] <- 0  # 하삼각행렬(대각 포함)을 만든다.
x
x[upper.tri(x, diag=TRUE)] <- 0  # 대각성분도 0으로 할 때
lower.tri(x)                     # x[row(x)>col(x)] <- 0


## 6.6.5 대칭행렬

(x <- matrix(1:9, 3))
x[upper.tri(x)] <- 0    # 하삼각행렬(대각 포함)을 만든다.
y <- x + t(x)           # 삼각행렬 + 삼각행렬의 전치행렬
diag(y) <- diag(y) / 2  # 대각성분을 원래대로 되돌린다.
y


## 6.6.6 행렬성분의 제곱의 총합

x <- array(runif(8), c(2, 4))
sum(x^2)
sum(diag(t(x) %*% x))


## 6.6.7 연립방정식의 해

a <- matrix(c(0, 1, 2, 3, 4, 5, 6, 7, 9), 3, 3) #      3y + 6z =  1
b <- matrix(c(1, 0, -2))                        #  x + 4y + 7z =  0
solve(a, b)                                     # 2x + 5y + 9z = -2

r <- rbind(c(1, 2, 3),                          # x + 2y + 3z = 8
           c(1, 1, 1),                          #      y +  z = 4
           c(1, 1, 2))                          #          2z = 2
(y <- backsolve(r, x <- c(8, 4, 2)))            #

r %*% y                                         # (8   4  2)
(y2 <- backsolve(r, x, transpose = TRUE))       # (8 -12 -5)
all(t(r) %*% y2 == x)
all(y  == backsolve(t(r), x, upper = FALSE, transpose = TRUE))
all(y2 == backsolve(t(r), x, upper = FALSE, transpose = FALSE))


## 6.6.8 역행렬

A <- array(runif(9), c(3, 3))
B <- solve(A)                    # 역행렬을 구하는 방법(1)
a <- matrix(c(0, 1, 2, 3, 4, 5, 6, 7, 9), 3, 3)
b <- matrix(c(1, 0, 0, 0, 1, 0, 0, 0, 1), 3, 3)
solve(a,b)                       # 역행렬을 구하는 방법(2)


## 6.6.9 일반 역행렬

A <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), c(3, 3))
B <- solve(A)                    # 일반 역행렬을 구하는 명령(오류가 남)

library(MASS)                    # 패키지 호출
B <- ginv(A)                     # 무어 펜로즈형 일반 역행렬
B


## 6.6.10 크로스곱

a <- matrix(c(1, 2, 3, 4))
b <- matrix(c(0, -1, -2, 1))
crossprod(a, b)                  # 크로스곱
crossprod(a)                     # 자신의 크로스곱


## 6.6.11 고윳값과 고유벡터

a <- matrix(c(0, 1, 2, 3, 4, 5, 6, 7, 9), 3, 3)
eigen(a)

z <- eigen(a)
z$values
z$vectors[,1]
z$vectors[,2]


## 6.6.12 QR 분해(행렬의 랭크)

hilbert <- function(n) { i <- 1:n; 1/outer(i-1, i, "+") }
h9 <- hilbert(9)
qr(h9)$rank                  # qr()$rank: 행렬의 랭크
qrh9 <- qr(h9, tol = 1e-10)  # singular value의 어느 값을 0으로
qrh9$rank                    # 간주할지는 tolerance로 결정한다.

y <- 1:9 / 10
x <- qr.solve(h9, y, tol = 1e-10)  # h9 %*% x = y를 푼다.
x <- qr.coef(qrh9, y)              # solve(h9) %*% y와 같지만
                                   # 이 방법이 바람직하다.
h9 %*% x                           # = y


## 6.6.13 콜레스키 분해

(a <- matrix(c(5, 1, 1, 3), 2, 2))
(b <- chol(a))
crossprod(b)                 # t(b) %*% b
cma <- chol(ma <- cbind(1, 1:3, c(1, 3, 7)))
ma %*% chol2inv(cma)


## 6.6.14 특이값 분해

a <- matrix(c(1,0.5,0.5,1),2)
svd(a)
eigen(a)


## 6.6.15 행렬의 제곱근

A <- array(c(2, 1, 1, 1, 2, 1, 1, 1, 2), dim=c(3, 3))
U <- svd(A)$u
V <- svd(A)$v
D <- diag(sqrt(svd(A)$d))
B <- U %*% D %*% t(V)       # 행렬 A의 제급근
A
B
B %*% B


## 6.6.16 정방행렬의 n승, 지수승

matpow <- function(x, pow=2) {
    y <- eigen(x)
    y$vectors %*% diag((y$values)^pow) %*% t(y$vectors)
}
matpow(diag(1:2))       # 행렬 ((1,0), (0,2))의 2승

matexp <- function(x) {
    y <- eigen(x)
    y$vectors %*% diag(exp(y$values)) %*% t(y$vectors)
}
matexp(matrix(0,2,2))   # 제로행렬의 지수승은 단위행렬
matexp(diag(2))         # exp(E) = ((e,0), (0,e))


## 6.6.17 행렬식

a <- matrix(c(0, 1, 2, 3, 4, 5, 6, 7, 9), 3, 3)
prod(svd(a)$d)
det(a)



## 6.7 그 밖의 행렬 조작

## 6.7.1 R에서 행렬이란

## 6.7.2 행렬의 크기

x <- matrix(1:6, nrow=2, ncol=3)  # 2 * 3 행렬을 만든다.
dim(x)       # dim 속성을 조사한다.
nrow(x)      # 행: dim(x)[1]
ncol(x)      # 열: dim(x)[2]

x <- matrix(1:6, nrow=2, ncol=3)     # 2 * 3 행렬을 만든다.
dim(x) <- c(3,2)                     # 3 * 2 행렬을 강제 변환
matrix(as.vector(x), nrow=2, ncol=6) # 2 * 6 행렬로 강제 변환


## 6.7.3 행과 열의 라벨

x <- matrix(1:6, nrow=2, ncol=3)            # 2 * 3 행렬
rownames(x) <- c("up", "down")              # 행의 이름
colnames(x) <- c("left", "center", "right") # 열의 이름
x

rownames(x) <- NULL
colnames(x) <- NULL
dimnames(x) <- NULL

x <- 1:3
y <- 4:6
matname <- c("x", "y")  # x, y의 오브젝트명으로 된 문자 벡터
sapply(matname, get)    # x, y를 행렬로 만든다(오브젝트명 = 열행렬).


## 6.7.4 행렬 요소의 보충, 치환, 추출

x <- matrix(1:6, nrow=3)  # 자동으로 ncol = 2가 된다.
y <- matrix(1:6, ncol=3)  # 자동으로 nrow = 3이 된다.

matrix(1, nrow=2, ncol=3)
matrix(1:2, nrow=2, ncol=3)
matrix(1:3, nrow=2, ncol=3, byrow=T)

x <- matrix(1:6, nrow=2, ncol=3)  # 2 * 3 행렬을 만든다.
row(x)                            # 각 행의 값이 행 번호와 같은 행렬
col(x)                            # 각 열의 값이 열 번호와 같은 행렬

(x <- matrix(1:12, nrow=3, ncol=4))  # 3 * 4 행렬을 만든다.
x[1:2, 3:4] <- c(333, 555, 777, 999) # 대입하는 벡터는
x                                    # 2 * 2 행렬로 변환된다.

(x <- matrix(1:6, nrow=2, ncol=3))
(y <- which(x%%2==0, arr.ind=TRUE))

x[x%%2==0]            # 2의 배수인 x의 모든 요소
x[x%%2==0] <- "*"     # 행렬 x의 짝수 요소를 모두 *로 치환
x


## 6.7.5 행(열)에 대한 연산과 조작

(x <- matrix(1:4, 2, 2))
apply(x, 2, sum)          # 열의 합 -> 함수 colSums(x)와 같다.
apply(x, 1, sum)          # 행의 합 -> 함수 rowSums(x)와 같다.

apply(x, 1, max)          # 각 행의 최댓값을 구한다.
apply(x, 2, min)          # 각 열의 최솟값을 구한다.


## 6.7.6 행렬의 특정 행(열)에 관해 정렬한다

(x <- matrix(runif(4),2,2))
order(x[,2])              # 2열의 순서를 출력
x[order(x[,2]),]          # 2열의 수치가 오름차순이 되게 정렬
x[,order(x[1,])]          # 1행의 수치가 오름차순이 되게 정렬
max.col(x)                # 행렬의 각 행별 최대 요소의 위치


## 6.7.7 팁

x <- matrix(rep(0:1, 81), 9, 9)
image(x, col=c(5, 9))
