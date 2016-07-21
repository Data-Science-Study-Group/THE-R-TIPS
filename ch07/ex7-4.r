## 7장 연습문제(3)

##1
weather.week <- function() {
    for(i in 1:7) {
        x <- runif(1)
        if (x <= 1/10) return(0)
    }
    return(1)
}

weather.week()


##2
weather.montercarlo <- function() {
    count <- 0
    for(i in 1:52) {
        x <- weather.week()
        if (x == 0) count <- count + 1
    }
    return(count)
}

weather.montercarlo()


##3
type2.simulation <- function(n) {
    count <- 0
    before <- coin()
    for (i in 2:n) {
        after <- coin()
        if ((before == 1) && (after == 1)) {
            count <- count + 1
            before <- 0
        }
        else {
            before <- after
        }
    }
    return(count)
}
type2.simulation(10)

type1.simulation <- function(n) {
    count <- 0
    before <- coin()
    for (i in 2:n) {
        after <- coin()
        if ((before == 1) && (after == 1)) {
            count <- count + 1
        }
        before <- after
    }
    return(count)
}
type1.simulation(10)


##4
type1.montecarlo <- function(n) {
    count <- 0
    for (i in 1:n) {
        count <- count + type1.simulation(10)
    }
    return(count / n)
}
type2.montecarlo <- function(n) {
    count <- 0
    for (i in 1:n) {
        count <- count + type2.simulation(10)
    }
    return(count / n)
}
type1.montecarlo(10000)
type2.montecarlo(10000)
