## 9장 연습문제(3)

## 1
t.test(flour, mu=0)


## 2
work <- c(8.0, 8.5, 10.0, 7.5, 9.0, 8.0, 9.5)
beer <- c(500, 750, 1250, 350, 850, 850, 1000)
result <- lm(beer ~ work)
summary(result)

plot(work, beer)
abline(result)
