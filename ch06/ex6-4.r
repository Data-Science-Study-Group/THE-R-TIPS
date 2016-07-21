## 6장 연습문제(3)

##1
A <- matrix(c(1,0,2,1), 2)
A %*% A
A %*% A %*% A


##2
det(A)
solve(A)


##3
a <- matrix(c(1, 2, 2, -1), 2, 2)
b <- matrix(c(4, 3))
solve(a, b)
