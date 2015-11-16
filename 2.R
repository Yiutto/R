library("tm")
setwd("E:\\AllCode\\R")#设置工作空间的位置
getwd()#获取当前工作空间的位置
fdata<- scan("NIPS2014-5222.txt",what="")
fdata<-tolower(fdata)
#计算词的使用频率
ft<-table(fdata)
pie(ft)

library("tm")
stopwords<- unlist(read.table("E:\\AllCode\\R\\stopwords.txt",stringsAsFactors=F))
removeStopWords <- function(x,stopwords) {

temp <- character(0)

index <- 1

xLen <- length(x)

while (index <= xLen) {

if (length(stopwords[stopwords==x[index]]) <1)

temp<- c(temp,x[index])

index <- index +1

}

temp

}
nips <- tm_map(nips, removeStopWords, stopwords)#去停用词
##1.Data Import  导入自己下的3084篇NIPStxt文档
library("tm")#加载tm包
txt<-system.file("texts","txt1",package="tm")#读取tm包里面text\txt下的文档
nips<-Corpus(DirSource(txt),readerControl=list(language="en"))
##2.Transformations
nips <- tm_map(nips, stripWhitespace)#去多余空白 
nips <- tm_map(nips, content_transformer(tolower))#转换为小写

nips <- tm_map(nips, removeWords, stopwords("english"))#去停用词
library("SnowballC")
nips <-tm_map(nips, stemDocument)#采用Porter‘s stemming 算法提取词干
##3.Creating Term-Document Matrices
#将处理后的语料库进行断字处理，生成词频权重矩阵(稀疏矩阵)也叫词汇文档矩阵
dtm <- DocumentTermMatrix(nips)


#查看词汇文档矩阵
inspect(dtm[1:5, 100:105])
#Non-/sparse entries: 1990/22390     ---非0/是0 
#Sparsity           : 92%            ---稀疏性  稀疏元素占全部元素的比例
#Maximal term length: 17             ---切词结果的字符最长那个的长度
#Weighting          : term frequency (tf)
#如果需要考察多个文档中特有词汇的出现频率，可以手工生成字典，
#并将它作为生成矩阵的参数
d<-c("price","crude","oil","use")
inspect(DocumentTermMatrix(reuters,control=list(dictionary=d)))


##6.Operations on Term-Document Matrices
#找出次数超过5的词
findFreqTerms(dtm, 5)
#找出与‘opec’单词相关系数在0.8以上的词
findAssocs(dtm,"opec",0.8)


#因为生成的矩阵是一个稀疏矩阵，再进行降维处理，之后转为标准数据框格式
#我们可以去掉某些出现频次太低的词。
dtm1<- removeSparseTerms(dtm, sparse=0.6)
inspect(dtm1)
data <- as.data.frame(inspect(dtm1))


#再之后就可以利用R语言中任何工具加以研究了，下面用层次聚类试试看
#先进行标准化处理，再生成距离矩阵，再用层次聚类
data.scale <- scale(data)
d <- dist(data.scale, method = "euclidean")
fit <- hclust(d, method="ward.D")
#绘制聚类图
#可以看到在20个文档中，489号和502号聚成一类，与其它文档区别较大。
plot(fit,main ="文件聚类分析")


#主成分分析
ozMat <- TermDocumentMatrix(makeChunks(reuters, 50),
                            list(weighting = weightBin))
k <- princomp(as.matrix(ozMat), features = 2)
screeplot(k,npcs=6,type=‘lines‘)
windows()
biplot(k)  

