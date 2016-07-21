## 7장 연습문제(4)

##1
circle.montecarlo <- function(n) {
    count <- 0
    for (i in 1:n) {
        suna <- runif(2)
        if      (sqrt((suna[1]-0.3)^2 + (suna[2]-0.3)^2) < 0.3) count <- count + 1
        else if (sqrt((suna[1]-0.6)^2 + (suna[2]-0.6)^2) < 0.4) count <- count + 1
    }
    return(count /n)
}
circle.montecarlo(10000)


##2
exp.montecarlo <- function(n) {
    count <- 0
    for (i in 1:n) {
        suna <- runif(2)
        fx   <- exp(-suna[1]^2)
        if(suna[2] < fx) {
            count <- count + 1
        }
    }
    return(count /n)
}
exp.montecarlo(10000)

exp.montecarlo1 <- function(n) {
    count <- 0
    for (i in 1:n) {
        suna <- runif(2, min=-1, max=1)
        fx   <- exp(-suna[1]^2)
        if(suna[2] < fx) {
            count <- count + 1
        }
    }
    return(count /n)
}
exp.montecarlo1(10000)

