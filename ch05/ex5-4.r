## 5장 연습문제(3)

##1
x <- 0
for (i in 1:5) x <- x + i
x

##2
x <- c()
for (i in 1:5) x <- c(x, i)
x

##3
myeven <- function(x) {
    s <- 0
    for (i in 1:x) {
        if (i %% 2 == 0) s <- s + i
    }
    return(s)
}

##4
x <- c(1, 2, 3, NA, 4, 5, NA)
myplus <- function() {
    s <- 0
    for (i in 1:length(x)) {
        if (!is.na(x[i])) {
            s <- s + x[i]
        }
    }
    return(s)
}

            
