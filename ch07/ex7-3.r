## 7장 연습문제(2)

##1
dice <- function() {
    x <- runif(1)
    if      (x <= 1/6) te <- 1
    else if (x <= 2/6) te <- 2
    else if (x <= 3/6) te <- 3
    else if (x <= 4/6) te <- 4
    else if (x <= 5/6) te <- 5
    else               te <- 6
    return(te)
}

dice10 <- function(n) {
    count <- 0
    for (i in 1:n) {
        x <- dice()
        if (x == 1) count <- count + 1
    }
    return(count)
}
dice10(10)


##2
weather <- function() {
    x <- runif(1)
    if      (x <= 7/10) te <- 1
    else if (x <= 9/10) te <- 2
    else                te <- 3
    return(te)
}

weather30 <- function(n) {
    count <- 0
    for (i in 1:n) {
        x <- weather()
        if (x == 1) count <- count + 1
    }
    return(count)
}
weather30(30)


##3
mycointoss2 <- function(n) {
    d <- c()
    for (i in 1:n) {
        d <- c(d, dice())
    }
    return(d)
}
mycointoss2(10)

y <- mycointoss2(10)
table(y)


weather2 <- function(n) {
    w <- c()
    for (i in 1:n) {
        w <- c(w, weather())
    }
    return(w)
}

weather2(30)

y <- weather2(30)
table(y)
