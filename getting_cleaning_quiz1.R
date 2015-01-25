# getting and cleaning data quiz 1


file <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv ","porperties.csv")
file_data <- read.csv("./porperties.csv")
file_data_cleaned <- file_data[complete.cases(file_data["VAL"]),]
above_million <-file_data_cleaned[file_data_cleaned$VAL >=24,]

file <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx","gov_data.xlsx",mode ="wp")
colIndex=7:15
rowIndex=18:23
file_data <- read.xlsx("gov_data.xlsx", sheetIndex=1,colIndex=colIndex,rowIndex=rowIndex)
dat=file_data
sum(dat$Zip*dat$Ext,na.rm=T) 

library(XML)
file_url <-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
> doc<-xmlTreeParse(file_url,useInternal=TRUE)
rootNode<-xmlRoot(doc)
zips<- xpathSApply(rootNode,"//zipcode",xmlValue)
zips[zips == 21231]


install.packages("data.table")
library(data.table)
file <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv","survey.csv")
DT <- fread("survey.csv")
system.time(DT[,mean(pwgtp15),by=SEX])




