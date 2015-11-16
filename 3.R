library("tm")
library("SnowballC")
library("XML")
reut<-system.file("texts","crude",package='tm')
reuters <- Corpus(DirSource(reut), readerControl = list(reader = readReut21578XML))
writeCorpus(reuters)
reuters <- tm_map(reuters, PlainTextDocument)#去除标签
reuters <- tm_map(reuters, stripWhitespace)#去多余空白
reuters <- tm_map(reuters, tolower)#转换小写
reuters <- tm_map(reuters, removeWords, stopwords("english"))
tm_map(reuters, stemDocument)
inspect(reuters[1:3])
dtm <- DocumentTermMatrix(reuters)