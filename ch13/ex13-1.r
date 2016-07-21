# 13장 데이터 핸들링

## 13.1 데이터 프레임

## 13.1.1 데이터 프레임 작성하기

## (1)벡터로부터 데이터 프레임을 작성

id     <- c(1, 2, 3, 4, 5)
sex    <- c("F", "F", "M", "M", "M")
height <- c(160, 165, 170, 175, 180)
weight <- c(50, 65, 60, 55, 70)
MYDATA <- data.frame(ID=id, SEX=sex, HEIGHT=height, WEIGHT=weight)
MYDATA


## (2)행렬로부터 데이터 프레임을 작성

X <- matrix(
    c(1, 1, 60, 50,
      2, 1, 165, 65,
      3, 2, 170, 60,
      4, 2, 175, 55,
      5, 2, 160, 70), 5, by=T)
MYDATA <- data.frame(X)
names(MYDATA) <- c("ID", "SEX", "HEIGHT", "WEIGHT")
MYDATA


## (3)텍스트 파일로부터 데이터 프레임을 작성

setwd("D:/work/THE R TIPS/ch13")
MYDATA <- read.table("mydata.txt", header=TRUE, sep="")
MYDATA

x <- read.table("data01.txt")
x

x <- read.table("data02.txt", header=T)
x

x <- read.table("data02.txt", header=T, nrows=4)
x

x <- read.table("data03.txt", header=T, skip=1)
x

x <- read.table("data04.txt", header=T, sep=",")
x

x <- read.csv("data04.csv")
x

myname <- c("SEX", "HEIGHT", "WEIGHT")
x <- read.csv("data05.csv",
              header=F, col.names=myname)
x


## (4)CSV 파일로부터 데이터 프레임을 작성

MYDATA <- read.csv("mydata.csv", head=T)
MYDATA

MYDATA <- read.delim("mydata2.txt", header=TRUE)
MYDATA


## (5)엑셀 파일로부터 데이터 프레임을 작성

install.packages("RODBC")

library(RODBC)                             # 패키지 호출
tmp <- odbcConnectExcel("mydata.xls")      # 데이터에 접속
sqlTables(tmp)
MYDATA <- sqlQuery(tmp, "select * from [Sheet1$]")  # 읽어 오기
odbcClose(tmp)                                      # 접속 차단
MYDATA

tmp <- odbcConnectExcel("mydata.xls")
MYDATA <- sqlQuery(tmp, "select * from [SHEET1$A1:B4]")
MYDATA


## (6)엑시스 파일로부터 데이터 프레임을 작성

library(RODBC)                             # 패키지 호출
tmp <- odbcConnectAccess("mydata.mdb")     # 데이터에 접속
sqlTables(tmp)                             # 테이블을 표시
MYDATA <- sqlQuery(tmp, "select * from [mytable]")  # 읽어 오기
odbcClose(tmp)                                      # 접속 차단
MYDATA


## (7)그 밖의 데이터 형식의 파일로부터 데이터 프레임을 작성

library(foreign)
read.spss("datafile", use.value.labels=FALSE)


## (8)보충학습

read.table(file.choose())

MYDATA <- read.csv("mydata.csv", head=T)
MYDATA
is.factor(MYDATA$SEX)                   # 변수 SEX는 인자형임.
is.character(MYDATA$SEX)                # 변수 SEX는 문자형이 아님.
MYDATA$SEX <- as.character(MYDATA$SEX)  # 문자형으로 변환
is.character(MYDATA$SEX)

MYDATA <- scan("mydata.txt", what="", skip=1, nlines=6)
MYDATA

MYDATA <- data.frame(
    matrix(scan("mydata.txt", what="", skip=1, nlines=6), 5, by=T)
)
MYDATA

expand.grid(ID=c("A", "B", "C"), SEX=c("M", "F"))

# 열 이름을 복사했을 때
MYDATA <- read.delim("clipboard", header=T)

# 열 이름을 복사하지 않았을 때
MYDATA <- read.delim("clipboard", header=F)


## 13.1.2 데이터 프레임 보기

id     <- c(1, 2, 3, 4, 5)
sex    <- c("F", "F", "M", "M", "M")
height <- c(160, 165, 170, 175, 180)
weight <- c(50, 65, 60, 55, 70)
MYDATA <- data.frame(ID=id, SEX=sex, HEIGHT=height, WEIGHT=weight)
head(MYDATA, 3)        # 데이터 프레임 MYDATA의 처음부터 3행까지 본다.
tail(MYDATA, 3)        # 데이터 프레임 MYDATA의 끝에서 3행까지 본다.

edit(MYDATA)           # 데이터 편집기로 데이터 프레임 MYDATA를 본다.

install.packages("relimp")
library(relimp)
showData(MYDATA)       # 텍스트 윈도우로 데이터 프레임 MYDATA를 본다.

showData(MYDATA[2:4,]) # 2~4행을 표시
showData(MYDATA[,1:2]) # 1~2열을 표시


## 13.1.3 데이터 프레임 집계하기

summary(MYDATA)

plot(MYDATA)

apply(MYDATA[,c(1, 3)], 2, mean)

by(MYDATA[,c(1, 3)], MYDATA$SEX, mean)    # 남녀별 평균

aggregate(MYDATA[,c(1, 3)], list(MYDATA[,2]), mean)

aggregate(MYDATA[,3], list(ID.45=MYDATA$ID>3), mean)


## 13.2 데이터의 편집.가공 방법

id     <- c(1, 2, 3, 4, 5)
sex    <- c("F", "F", "M", "M", "M")
height <- c(160, 165, 170, 175, 180)
weight <- c(50, 65, 60, 55, 70)
(MYDATA <- data.frame(ID=id, SEX=sex, HEIGHT=height))
(MYDATA1 <- data.frame(ID=id, SEX=sex, WEIGHT=weight))
(MYDATA2 <- data.frame(ID=id[1:4], WEIGHT=weight[1:4]))


## 13.2.1 데이터에 액세스하는 방법

head(MYDATA, n=2)    # 데이터 프레임 MYDATA의 처음부터 2행을 표시한다.
subset(MYDATA, HEIGHT>165)  # 변수 HEIGHT가 165보다 큰 행을 표시한다.

MYDATA[,c(-1, -2)]

MYDATA$SEX <- NULL
MYDATA


## 13.2.2 행과 열의 정보 취득과 데이터의 정렬

id       <- c(1, 2, 3, 4, 5)
sex      <- c("F", "F", "M", "M", "M")
weight   <- c(50, 65, 60, 55, 70)
(MYDATA1 <- data.frame(ID=id, SEX=sex, WEIGHT=weight))
x <- order(MYDATA1$WEIGHT)     # WEIGHT를 오름차순으로 정렬했을 때의 행 번호 리스트
(MYDATA1 <- MYDATA1[x,])       # 데이터 정렬

rownames(MYDATA1) <- c(1:nrow(MYDATA1))  # 행 라벨 변경
MYDATA1

x <- order(MYDATA1$SEX, MYDATA1$WEIGHT)  # 순서대로 정렬한다.
MYDATA1 <- MYDATA1[x, ]                  # 데이터 정렬
rownames(MYDATA1) <- c(1:nrow(MYDATA1))  # 행 라벨 변경
MYDATA1


## 13.2.3 데이터 가공.편집

id      <- c(1, 2, 3, 4, 5)
sex     <- c("F", "F", "M", "M", "M")
height  <- c(160, 165, 170, 175, 180)
(MYDATA <- data.frame(ID=id, SEX=sex, HEIGHT=height))
weight  <- c(50, 65, 60, 55, 70)
MYDATA$WEIGHT <- weight
MYDATA

cbind(MYDATA[, c(1, 2)], MYDATA[, c(1, 3)])
data.frame(MYDATA[, c(1, 2)], MYDATA[, c(1, 3)])

merge(MYDATA[, c(1, 2)], MYDATA[, c(1, 3)])
merge(MYDATA[, c(1, 2)], MYDATA[, c(1, 3)], by.x="ID", by.y="ID")

(MYDATA2 <- data.frame(ID=id[1:4], WEIGHT=weight[1:4]))
merge(MYDATA, MYDATA2)

merge(MYDATA, MYDATA2, all=TRUE)      # 모든 행을 남긴다.
merge(MYDATA, MYDATA2, all.y=TRUE)    # 두 번째 인수의 행은 모두 남긴다.

MYDATA$HEIGHT <- ifelse(MYDATA$SEX=="F", NA, MYDATA$HEIGHT)  # 여성의 키를 NA로
MYDATA

df <- data.frame(id=rep(1:4, rep(2, 4)),
                 vlist=I(rep(c("Before", "After"), 4)),
                 x=rnorm(4), y=runif(4))
df
reshape(df, timevar="vlist", idvar="id", direction="wide", v.names=c("x", "y"))

MYDATA <- edit(MYDATA)


## 13.2.4 내장 데이터에 액세스하는 방법

data()                         # 모든 데이터셋을 표시
data(package="survival")       # 패키지 survival의 데이터셋을 표시
data(USArrests, "VADeaths")    # 데이터 USArrests, VADeaths를 로드
help(USArrests)

library(survival)    # 패키지 survival을 호출
data(cancer)         # 데이터 cancer를 호출


## 13.2.5 attach()와 detach()

attach(MYDATA)
SEX

data(sleep)      # R에 표준으로 준비된 데이터(sleep)
sleep            # W.S.Gosset(Student)의 수면제 비교 데이터
attach(sleep)    # attach()를 싱행함으로써
extra            # extra만으로 데이터에 엑세스할 수 있다.

search()         # 어떤 리스트나 데이터 프레임이 있는지 조사한다.
detach(MYDATA)   # MYDATA를 제외시킨다.

data(sleep)
with(sleep, {             # sleep으로부터 전용 환경을 만들어
    x <- extra[group==1]  # 그 안에서 작업:
    y <- extra[group==2]  # 그룹1의 데이터를 x에
    var.test(x, y)        # 그룹2의 데이터를 y에 대입하고
})                        # 분산의 동일성을 검정을 한다.


## 13.3 파일로 데이터 출력

## 13.3.1 데이터 프레임 출력

id      <- c(1, 2, 3, 4, 5)
sex     <- c("F", "F", "M", "M", "M")
height  <- c(160, 165, 170, 175, 180)
(MYDATA <- data.frame(ID=id, SEX=sex, HEIGHT=height))
write.table(MYDATA, "output1.txt",
            quote=FALSE, append=FALSE)

x <- as.matrix(MYDATA)    # MYDATA를 행렬로 변환
write(t(x), "output2.txt", ncolumns=ncol(x))

save(MYDATA, file="output3.data")    # 파일 output3.data는
rm(MYDATA)                           # 텍스트 데이터가 아니다.
MYDATA
load("output3.data")                 # 데이터 호출
MYDATA                               # 내용 확인


## 13.3.2 구분 문자를 붙여서 데이터 출력

x <- c(1:9)
out <- NULL
for (i in 1:(length(x) - 1)) {
    out <- paste(out, x[i], sep="")
    out <- paste(out, ",", sep="")
}
out <- paste(out, x[length(x)], sep="")
write(out, file="output4.txt", ncolumns = 2 * length(x))

out <- file("output5.txt", "w")    # 파일을 쓰기 모드로 연다.
for (i in 1:10) {
    if (i < 5)       writeLines(paste(i), out, sep=",")
    else if (i == 5) writeLines(paste(i), out, sep="\n")
    else if (i < 10) writeLines(paste(i), out, sep=",")
    else             writeLines(paste(i), out, sep="\n")
}
close(out)                         # 파일을 닫는다.


## 13.3.3 데이터를 LaTeX 형식, HTML 형식으로 출력

id      <- c(1, 2, 3, 4, 5)
sex     <- c("F", "F", "M", "M", "M")
height  <- c(160, 165, 170, 175, 180)
(MYDATA <- data.frame(ID=id, SEX=sex, HEIGHT=height))
library(xtable)
x <- xtable(MYDATA)    # MYDATA를 xtable 형식으로 변환
print(x)               # LaTeX 형식으로 출력

print(x, type="html")  # HTML 형식으로 출력
