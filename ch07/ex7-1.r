# 7 시뮬레이션 입문

## 7.1 시뮬레이션이란

## 7.2 시뮬레이션 순서

## 7.3 난수(준비 1)

## 7.3.1 일양난수

runif(1)      # 난수를 1개 생성
runif(10)     # 난수를 10개 생성


## 7.3.2 동전 던지기의 난수 만들기

## 7.3.3 각종 난수 만들기

coin <- function() {
    x <- runif(1)
    if (x <= 1/2) men <- 1     # 1: 앞변
    else          men <- 0     # 0: 뒷면
    return(men)
}
coin()

gawibawibo <- function() {
    x <- runif(1)
    if      (x <= 1/3) te <- 1     # 1: 가위
    else if (x <= 2/3) te <- 2     # 2: 바위
    else               te <- 3     # 3: 보
    return(te)
}
gawibawibo()


## 7.4 한 번의 시뮬레이션(준비 2)

mycointoss <- function(n) {
    count <- 0
    for (i in 1:n) {
        x <- runif(1)
        # 동전 던지기 결과를 판정(앞면: 1, 뒷면: 0)
        if (x <= 1/2) coin <- 1
        else          coin <- 0
        # 동전 던지기 결과가 1이면 카운트
        if (coin == 1) count <- count + 1
    }
    return(count)
}
mycointoss(10)

mycointoss <- function(n) {
    count <- 0
    for (i in 1:n) {
        x <- coin()
        if (x == 1) count <- count + 1
    }
    return(count)
}

mycointoss <- function(n) {
    count <- 0
    for (i in 1:n) {
        count <- count + coin()
    }
    return(count)
}


## 7.5 몬테카를로 시뮬레이션

mymontecarlo <- function(n) {
    count <- 0
    for (i in 1:n) {
        count <- count + coin()
    }
    return(count / n)
}
mymontecarlo(10000)


## 7.5.1 확률적인 문제에 대한 시뮬레이션

coin.montecarlo <- function(n) {
    count <- 0
    for (i in 1:n) {
        count <- count + mycointoss(10)
    }
    return(count/n)
}
coin.montecarlo(1000)
coin.montecarlo(10000)
coin.montecarlo(100000)


## 7.5.2 비확률적인 문제에 대한 시뮬레이션

pi.montecarlo <- function(n) {
    count <- 0
    for (i in 1:n) {
        suna <- runif(2)
        if (sqrt(suna[1]^2 + suna[2]^2) < 1) {
            count <- count + 1
        }
    }
    return(4 * count / n)
}
pi.montecarlo(10000)

carlo2 <- function(n) {
    count <- 0
    for (i in 1:n) {
        suna <- runif(2, min=-1, max=1)
        if (sqrt(suna[1]^2 + suna[2]^2) < 1) {
            count <- count + 1
        }
    }
    return(4 * count /n)
}


## 7.6 보충학습

## 7.6.1 복잡한 도형의 체적

myball <- function(n) {
    count <- 0
    for (i in 1:n) {
        u <- runif(3)          # u = (x좌표, y좌표, z좌표)
        pt <- (u[1] - 0.3)^2 + (u[2] - 0.3)^2 + (u[3] - 0.7)^2
        if (pt < 0.3^2) count <- count + 1
        else {
            pt <- (u[1]-0.5)^2 + (u[2]-0.5)^2 + (u[3]-0.5)^2
            if (pt < 0.4^2) count <- count + 1
            else {
                pt <- (u[1]-0.7)^2 + (u[2]-0.7)^2 + (u[3]-0.7)^2
                if (pt < 0.3^2) count <- count + 1
            }
        }
    }
    return(count / n)
}
myball(10000)


## 7.6.2 몬테카를로 시뮬레이션 함수 정의


montecarlo2 <- function(n) {
    count <- 0
    for (i in 1:n) {
        count <- count + fun(k)
    }
    return(count/n)
}

mymontecarlo2(10000, 10, mycointoss)


## 7.6.3 확률분포를 따르는 난수를 이용한 시뮬레이션

rbinom(1, 1, 0.5)         # 1회 동전 던지기
sum(rbinom(10, 1, 0.5))   # 10회 동전 던지
