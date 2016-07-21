## 9장 연습문제(1)

## 1
flour <- c( 3, -2, -1,  0,  1, -2)  # 밀가루
diet  <- c(-4,  1, -3, -5, -2, -8)  # 다이어트약
total <- c(flour, diet)             # 12명 전원의 데이터

boxplot(total)
boxplot(total, horizontal=T)
