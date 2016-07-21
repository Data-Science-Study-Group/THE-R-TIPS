## 5장 연습문제(2)

##1
myone <- function(x) {
    if (x >= 1) {
        return(1)
    }
}

##2
myindex <- function(x) {
    if (x >= 1) {
        return(1)
    } else {
        return(0)
    }
}

##3
mydistance <- function(a,b) {
    if (a > b) {
        return(a-b)
    }
    else {
        return(b-a)
    }
}
mydistance(2, 3) # 1
