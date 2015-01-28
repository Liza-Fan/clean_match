load("C:\\frmD\\data-epresc\\drug_map13112014.RData")
is.factor(tt)
paste(' ',tt,' ')->tts
as.data.frame(tts)->tts

gsub('[[:punct:]]',' ',tts)->tts2
read.csv("Registered Drugs All.csv",header=T)->druglist
cha=levels(druglist[,4])
as.data.frame(tts)->tts


gsub("(^[[:space:]]+|[[:space:]]+$)", "", druglist[,2])->druglist[,2]
druglist[,2]->chb
> unique[str(chb)]->chb
chb[order(-nchar(chb),chb)]->tes

> tes->chb

nd=NULL
tts2[,3]<- ""
for (i in 1: length(chb))  {
	
indx<-grep(paste(' ',chb[i],' ',sep=""),tts2[,1], ignore.case=TRUE)
indx2<-grep('stop | stop|stopped| needles',tts2[,1], ignore.case=TRUE)
nd<-setdiff(indx,indx2)

tts2[nd,3]=paste(tts2[nd,3],chb[i],sep="-") 
}

sub("^-+","",tts2[,3])->tts2$brand_clean
> cbind(fs,tts2$brand_clean)->drug_map
> write.csv(drug_map,"drug_match.csv",row.names=F)

read.csv("Registered Drugs All.csv",header=T)->druglist
druglist[,c(2,4)]->hsa
colnames(hsa)[1]<-"trim_brand"

read.csv("drug_match.csv",header=T)->test
str(test)
test[,1]<-NULL
colnames(test)
colnames(test)[1]<-"trim_ingredient"
colnames(test)[2]<-"trim_brand"
test$hsa_ig<-hsa$HSA_registered_active_ingred_trim[match(test$trim_brand,hsa$trim_brand)]

test$hsa_ig2<-sapply(test$hsa_ig,as.character)
test$trim_ingredient2<-sapply(test$trim_ingredient,as.character)

test[,7]<-ifelse(is.na(test$trim_ingredient2),test$hsa_ig2,test$trim_ingredient2)
test[is.na(test)] <-""
test[,7][is.na(test[,7])] <-""
cbind(as.character(drug_map$tt),test$V7)->clean_drug
###test$V7 is cleaned drug ,map with ingredient and brand name
> write.csv(clean_drug,"cleaned_drug_26012015.csv",row.names=F)
