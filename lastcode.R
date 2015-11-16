##1.Data Import  导入自己下的3084篇NIPStxt文档
library("tm")#加载tm包
stopwords<- unlist(read.table("E:\\AllCode\\R\\stopwords.txt",stringsAsFactors=F))
txt<-system.file("texts","txt",package="tm")#读取tm包里面text\txt下的文档
nips<-Corpus(DirSource(txt),readerControl=list(language="en"))
##2.Transformations
nips <- tm_map(nips, stripWhitespace)#去多余空白 
nips <- tm_map(nips, content_transformer(tolower))#转换为小写
nips <- tm_map(nips, removeWords, stopwords)#去停用词
library("SnowballC")
nips <-tm_map(nips, stemDocument)#采用Porter‘s stemming 算法提取词干
##3.Creating Term-Document Matrices
#将处理后的语料库进行断字处理，生成词频权重矩阵(稀疏矩阵)也叫词汇文档矩阵
dtm <- DocumentTermMatrix(nips)