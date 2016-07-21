## 7장 연습문제(1)


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

##2
weather <- function() {
    x <- runif(1)
    if      (x <= 7/10) te <- 1
    else if (x <= 9/10) te <- 2
    else                te <- 3
    return(te)
}
