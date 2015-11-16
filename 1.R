hlibrary("tm")
txtdir <- read.table("E:\\AllCode\\R\\NIPS2014-5632.txt")


library("tm")
txt <- system.file("texts", "txt", package = "tm")
reuters <- Corpus(DirSource(txt), readerControl = list(language = "en"))
dtm <- DocumentTermMatrix(reuters)
inspect(dtm)

docs <- c("This is a text.", "This another one.")

Corpus(VectorSource(docs))



setwd("E:\\AllCode\\R")#设置工作空间的位置
getwd()#获取当前工作空间的位置
text <- read.table(file="NIPS2014-5222.txt",header=FALSE) 
text <- readLines("NIPS2014-5222.txt") 
text <- scan("NIPS2014-5632.txt", what = character(0), sep = ".")  #设置成每一句文本作为向量的一个元素