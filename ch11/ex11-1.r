# 11장 데이터형과 벡터.배열.리스트

## 11.1 데이터형

x <- c()     # x에 아무것도 들어 있지 않은 벡터를 전달한다.
x

log(-2)
log(-2+0i)

"abc"
""
"I don't agree."
"\""


## 11.2 출력

## 11.2.1 오브젝트란

## 11.2.2 오브젝트의 표시: print()

x <- "one"
x              # 오브텍트명만 입력해도 표시되지만
print(x)       # print()를 사용하면, 인수 digits, justity,
               # max.levels, na.print, quote, width, zero.print
               # 등으로 사용자가 지정해서 출력할 수 있다.
print(x, quote=F)


## 11.2.3 문자열 오브젝트 표시: cat()

cat("cd C:\\Document and Settings\\usr\n")
cat("\123\n")

cat(" a'a\n")
cat(" a\"a\n")


## 11.2.4 서식을 지정한 오브젝트의 표시: sprintf()

sprintf("%s is %f feet tall\n", "Seven", 7)
sprintf("%s is %i feet tall\n", "Seven", 7)


## 11.2.5 오브젝트 요약 표시: str()

x <- c(1, 2, 3, 4, 5)
str(x)
summary(x)


## 11.2.6 오브젝트에 주석을 추가한다: comment()

x <- c(1, 2, 3, 4, 5)
comment(x) <- c("x : 1 x 5 vector", "Oct 05, 2013")
x
comment(x)
str(x)


## 11.2.7 출력을 파일로 보낸다: sink()

sink("output.txt")
sink()


## 11.2.8 옵션: options()

options(digits=15)    # 최대 자릿수를 15자리로 변경

options(scipen=0); print(1e5)
options(scipen=1); print(1e5)

x <- runif(10)
x
options(width=50)
x


## 11.3 벡터

1 + 2      # [1] 3   결과는 벡터


## 11.3.1 벡터의 기본과 작성 방법

(x <- c(1.0, 2.0, 3.0, 4.0, 5.0))    # 길이 5인 벡터 (변수 x에 대입)
length(x)                            # 벡터 x의 길이

1:5                           # 1에서 5까지 1씩 증가하는 벡터를 만든다.
3:-3                          # 3에서 -3까지 1씩 감소하는 벡터를 만든다.
seq(1, 10, length=5)          # 1에서 10까지 등분할한 길이 5인 벡터를 만든다.

(x <- rep(c("A","B","C"), 1:3))
unique(x)                     # 반복된 값을 제거한다.
match(x, c("A", "C"))         # x 안에 A 또는 C가 있는가?


## 11.3.2 비교 연산자에 의한 벡터 연산

c(1, 20, 3) == c(1, 2, 3)        # 1==1, 20==2, 3==3
c(1, 20, 3) == c(1.0, 2.0, 3.0)  # 1==1.0, 20==2.0, 3==3.0

x <- c(1, 2, 3)
((x >= c(1, 1, 1)) | (x < c(3, 3, 3)))
((x >= c(1, 1, 1)) & (x < c(3, 3, 3)))

c(1, 20, 3) > 4               # 1 > 4, 20 > 4, 3 > 4


## 11.3.3 벡터로부터 특정 값에 가장 가까운 요소의 번호를 구한다

x <- rnorm(30)                               # 30개의 정규난수
which(abs(x - 1.0) == min(abs(x - 1.0)))     # 1.0에 가장 가까운 값을 가진 요소의 번호
x[which(abs(x - 1.0) == min(abs(x - 1.0)))]  # 해당하는 요소의 값


## 11.3.4 집합 연산

(x <- c(sort(sample(1:20, 9)), NA))
(y <- c(sort(sample(3:23, 7)), NA))
union(x, y)                    # 합집합
intersect(x, y)                # 곱집합 (교집합)
setdiff(x, y)                  # 차집합(x에서 x와 y의 공통요소를 삭제)
setdiff(y, x)                  # 차집합(y에서 x와 y의 공통요소를 삭제)


## 11.3.5 다양한 벡터(복소형, 논리형, 문자형, 인자형, 날짜형)

## (1)복소형 벡터

c(1+1i, 2+3i)    # 허수 1+i를 나타낼 때는 1+1i라고 표기한다.
c(1, 2+3i)       # 요소에 복소수가 하나라도 있으면 요소 전체가 복소수가 된다.

complex(re=1:3, im=4:6)             # re: 실수부, im: 허수부
complex(mod=c(1, 2), arg=c(0, pi))  # mod: 절댓값, arg: 편각


## (2)논리형 벡터

c(T, F, TRUE, FALSE)

c(T, F, T) | c(TRUE, FALSE, FALSE)
!c(T, F, T)
xor(c(TRUE, FALSE, TRUE), c(TRUE, FALSE, FALSE))
(x <- runif(3))
(0.25 <= x) & (x <= 0.75)          # 0.25 ~ 0.75 범위에 있는가?

(x <- runif(5))
any(x > 0.8)          # x 중에 하나라도 0.8 이상인 요소가 있는가?
all(x < 0.8)          # x의 요소가 모두 0.8 이하인가?


## (3)문자형 벡터

c("a", "b", "c", "d", "e")
c("SEOUL", "BUSAN", "INCHON", "GWANGJU", "DAEJON", "DEAGU")


"SEOUL" > "DAEJON"
"DAEGU" > "DAEJON"

paste("May I", "help you ?")
paste(month.abb, 1:12, c("st", "nd","rd", rep("th",9)))

paste("/usr", "local", "bin", sep = "/")    # /를 사이에 넣어서 연결한다.
(x <- paste(1:4))
paste(x, collapse="abc")
paste(x, collapse="")

substring("abcdefg", 2, 5)

a <- numeric(5); x <- 1:5
for (i in x) eval(parse(text=paste("a[", i,"] <- 10", sep="")))
a

x <- c("sex", "height", "age", "weight", "eight")
grep('^ei', x)    # ei로 시작하는 요소
grep('(ei)', x)   # ei라는 문자열을 포함하는 요소


## (4)순서 있는 인자 벡터와 순서 없는 인자 벡터

data(warpbreaks)        # 한 대의 방직기에서 파손된 실의 수
attach(warpbreaks)      # 사용할 데이터를 고정
(fc <- factor(tension)) # 요소를 그룹화
levels(fc)              # 그룹화되었는지 확인
str(fc)                 # 오브젝트의 요약값을 표시

fc <- ordered(tension)  # 그룹화되었는지 확인
levels(fc)
str(fc)                 # 오브젝트의 요약값을 표시

cut(x, breaks=c(0, 3, 7, 10))

(y <- cut(x, breaks=c(0, 3, 7, 20), labels=c("Low", "Mid", "Hi")))
table(y)

gl(2, 10, 20)
gl(2, 8, label=c("Control", "Treat"))

library(car)
(x <- as.factor(rep(1:4, 2)))
recode(x, "c(1, 2)='A'; else'B'")
(y <- recode(x, "1:2='A'; 3='B'; 4='C'"))
relevel(y, "B")


## (5)날짜형 벡터

as.Date("2013/07/17")
as.Date("07/17/2013", format="%m/%d/%Y")

as.Date("2013/Jul/17", format="%Y/%b/%d")
Sys.setlocale("LC_TIME", "C")
as.Date("2013/Jul/17", format="%Y/%b/%d")

Sys.setlocale("LC_TIME", "C")
strptime("17Jul2013", "%d%b%Y")
format(Sys.time(), "%Y %b %d %H:%M:%S %Z")

x <- as.Date(c("2013/07/01", "2013/07/15", "2013/07/31"))
x[2] - x[1]       # 날짜의 차
diff(x)           # 날짜의 차
mean(x)           # 날짜의 평균

## R의 상수
LETTERS    # 대문자
letters    # 소문자
month.abb  # 월 이름 약칭
month.name # 월 이름
pi         # 원주율

pi / 2
month.abb
LETTERS[1:5]


## 11.3.6 벡터의 조작

(x <- c(1, 2, 3, 4, 5))
x[2]
x[2:5]
x[c(-1, -3)]
x[c(F, T, F, T, F)]

x <- c(10, 20, 30, 40, 50)
x[30 < x]
x[10 < x & x < 40]              # 2개의 조건을 &나 |로 연결한다.
(1:length(x))[10 < x & x < 40]  # 몇 번째 요소가 조건을 만족하는가?
names(x) <- c("A", "B", "C", "D", "E")
x["A"]


## 11.3.7 벡터 요소의 치환.결합.삽입

x <- c(1, 2, 3, 4, 5)              # x <- 1:5로 해도 된다.
(y <- replace(x, c(2,4), c(0,0)))  # x의 2, 4번째의 요소를 0으로 치환한다.
(z <- replace(x, c(2,4), NA))      # 이번에는 NA로 치환한다.
replace(z, which(is.na(z)), 10)    # z의 NA를 10으로 치환한다.

x <- c(1, 2, 3); y <- c(4, 5, 6); z <- c(7, 8, 9)
c(x, y, z)
(w <- append(x, z))        # c(x, z)로 해도 된다.
append(w, y, after=3)      # w의 세 번째 요소 이후에 y를 삽입)


## 11.3.8 NULL.NA.NaN.Inf 다루기

## (1)NULL.NA.NaN.Inf인지 조사한다.

x <- c(1.0, NA, 3.0, 4.0)    # 어떤 것이 NA인지 조사해도...
x == NA                      # NA에 대한 연산은 모두 NA가 된다.

is.na(NA)
is.nan(NA)
x <- c(1, NA, 3, 4)
is.na(x)


## (2)벡터 요소에 있는 NA의 배제.치환

x <- c(1, 2, NA, 4, 5, NA)
x
x <- ifelse(is.na(x), 0, x)       # NA를 0으로 치환한다.
x

x <- c(1, 2, NA, -4, 5, -6, 7, NA, 9, 10)
y <- x[!is.na(x)]                 # NA 이외의 x의 요소를 y에 저장
y


## (3)NULL의 사용법

length(NULL)    # 모드(mode) NULL을 가진다.
names(x)        # names 속성이 없으므로 NULL이 반환된다.

names(x) <- c("a", "b", "c")
x
names(x) <- NULL
x

x <- NULL                              # 길이가 0인 벡터 x를 준비
for (i in 1:10) x <- append(x, i * i)  # x에 i^2을 차례로 저장
x


## 11.3.9 데이터형과 데이터 구조의 변환

x <- c(1, 0, 1, 0, 1)
mode(x)
mode(x) <- "complex"    # storage.mode(x) <- "complex"로도 가능
x
mode(x) <- "logical"
x

## 벡터형 사이의 대소 관계
## character > complex > numeric > logical > NULL

x <- c(1, 0, 1, 0, 1, 0)    # x에 벡터를 저장
is.list(x)                  # 벡터는 리스트가 아니다.
x <- as.list(x)             # x를 리스트로 변환
is.list(x)                  # x는 리스트이며...
is.vector(x)                # 벡터이기도 하다.


## 11.4 배열

## 11.4.1 배열이란

(x <- array(1:8, dim=c(1, 4, 2)))    # 3차원 배열
x[1, 4, ]          # x[행, 열, 3차원째의 요소, ...]


## 11.4.2 행렬.배열의 각 부분에 함수를 적용한다

mean(x[ ,i])
mean(x[i, ])

apply(x, 2, mean)   # 열에 대해서: mean(x[ ,i]) (i=1, 2, ...)와 같은 계산
apply(x, 1, mean)   # 행에 대해서: mean(x[i, ]) (i=1, 2, ...)와 같은 계산

x <- array(1:16, dim=c(2, 4, 2))
apply(x, c(1,2), mean)
addmargins(x, margin=3, FUN=mean)    # 결과는 생략


## 11.4.3 배열의 일반화 전치

( x <- array(1:24, 2:4))
aperm(x, perm=c(2, 1, 3))


## 11.5 리스트

## 11.5.1 리스트 만들기

(x <- list(1:5, list("It's my list.", c(T, F, T))))


## 11.5.2 리스트의 요소에 엑세스

x <- list(1:5, list("It's my list.", c(T, F, T)))
length(x)               # 리스트 x의 길이를 구한다.
x[[1]] <- NULL          # 리스트 1성분을 제거한다.
x[[1]][1]               # x의 2성분(리스트)의 1성분을 추출한다.
x <- as.list(NULL)      # 리스트 x를 초기화한다.
x                       # x의 내용을 확인한다.


## 11.5.3 부분 리스트 추출.치환.연결

x[1:2]         # 1, 2성분을 추출
x[-1]          # 1성분 이외의 것을 추출
x[c(T, F, T)]  # 1, 3성분을 추출

x[2] <- c(1+2i, 3+4i)         # 리스트의 일부를 벡터로 치환하려고 하면 경고가 발생한다.
(x[2] <- list(c(1+2i, 3+4i))) # 리스트로 변환하고 나서 치환한다.

c(list(1:5), list(c(T, F, T))) # append(list(1:5), list(c(T, F, T))) 도 사용가능
rep(list(1:5, "It's my list."), 2)  # 함수 rep()도 사용 가능

(x <- split(1:10, rep(c("odd", "even"), 5)))
unlist(x)


## 11.6 데이터 프레임

id     <- c(1, 2, 3, 4, 5)
sex    <- c("F", "F", "M", "M", "M")
height <- c(158, 162, 177, 173, 166)
weight <- c(51, 55, 72, 57, 64)
(x     <- data.frame(ID=id, SEX=sex, HEIGHT=height, WEIGHT=weight))
x[,c(1, 3)]      # 1열과 3열을 표시
x$SEX            # 열(변수) SEX를 표시


## 11.7 apply 패밀리

## 11.7.1 apply()

(x <- matrix(1:8, ncol=4))
apply(x, 2, sum)         # 각 열의 총합을 구한다.
colSums(x)               # 각 열의 총합을 구한다.
apply(x, c(1, 2), sqrt)  # 각 요소의 제곱근을 구한다.

(x <- matrix(1:8, ncol=4))
apply(x, 1, function(x) var(x) * length(x) / (length(x) - 1))


## 11.7.2 sweep()

(x <- matrix(1:8, ncol=4))
sweep(x, 1, 1:2)        # 열별로 1행에서 1을, 2행에서 2를 뺀다.
sweep(x, 2, 1:2)        # 행별로 c(1:2, 1:2) = c(1, 2, 1, 2)를 뺀다.

x <- matrix(1:8, ncol=4)
sweep(x, 1, apply(x, 1, mean))    # 행 평균을 뺀다.
sweep(x, 2, apply(x, 2, mean))    # 열 평균을 뺀다.


## 11.7.3 lapply(), sapply()

id     <- c(1, 2, 3, 4, 5)
sex    <- c("F", "F", "M", "M", "M")
height <- c(158, 162, 177, 173, 166)
weight <- c(51, 55, 72, 57, 64)
(x     <- data.frame(ID=id, SEX=sex, HEIGHT=height, WEIGHT=weight))
lapply(x[,-2], mean)        # 각 열(각 변수)별 평균값을 구한다.
sapply(x[,-2], mean)        # 각 열(각 변수)별 평균값을 구한다.


## 11.7.4 tapply(), by(), aggregate()

id     <- c(1, 2, 3, 4, 5)
sex    <- c("F", "F", "M", "M", "M")
height <- c(158, 162, 177, 173, 166)
weight <- c(51, 55, 72, 57, 64)
(x     <- data.frame(ID=id, SEX=sex, HEIGHT=height, WEIGHT=weight))
tapply(x$HEIGHT, x$SEX, mean)  # 성별(SEX) HEIGHT의 평균값을 구한다.
by(x[,-2], x$SEX, mean)        # 성별(SEX) 평균값을 구한다.
aggregate(x[,-2], list(SEX=x$SEX), mean)


## 11.7.5 mapply()

id   <- c(1, 2, 3, 4, 5)
wgt1 <- c(51, 55, 72, 57, 64)
wgt2 <- c(53, 54, 70, 57, 69)
(x   <- data.frame(ID=id, WEIGHT1=wgt1, WEIGHT2=wgt2))
mapply(mean, x)        # 각 열(각 변수)별 평균값을 구한다.
sapply(x, mean)        # 각 열(각 변수)별 평균값을 구한다.

mapply(function(a, b) mean(c(a, b)), x[,2], x[,3])

mapply(rep, 1:3, 3:1)    # rep(1, 3), rep(2, 2), rep(3, 1)을 나열한다.
mapply(rep, 3:1, 1:3)    # rep(3, 1), rep(2, 2), rep(1, 3)을 나열한다.


## 11.8 names 속성과 요소의 라벨

x <- 1:5
names(x) <- c("a", "b", "c", "d", "e")
x

names(x)

x["b"]
x["c"][[1]]

x <- list(1:5, "abc")
names(x) <- c("sequence", "letters")
x
x$letters

temp <- "sequence"    # temp에 문자열 "sequence"를 대입
x[[temp]]             # [[ ]] 안의 식은 평가되므로 x[["sequence"]] 로 인식
x$temp                # $ 뒤의 식은 평가되지 않으므로 x$temp로 인식되어 NULL이 반환된다.

list(sequence=1:5, "letters"="abc")

a <- matrix(1:6, nrow=2, ncol=3)
dimnames(a) <- list(c("row1", "row2"), c("col1", "col2", "col3"))
a

a <- array(1:16, dim=c(2, 4, 2))
dimnames(a) <- list(NULL, c("A", "B", "C", "D"), c("a", "b"))
a

dimnames(a) <- list(c("row1", "row2"), NULL)    # 열 라벨을 제거
dimnames(a) <- NULL                             # 모든 라벨을 제거

x <- 1:4
mode(x)          # x의 속성을 조사한다.
attributes(x)    # model와 length 이외의 모든 속성을 조사한다.
attr(x, "dim") <- c(2, 2)
x
