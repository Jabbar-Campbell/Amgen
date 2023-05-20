install.packages("readxl")
install.packages("rlang")
library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)


#THIS IS THE SOURCE  LOCATION OF YOUR FILES ???????????????????????????????????????
SOURCE<-"H:/SPARK/20190905_study_Compilation.xlsx"



sheet2<-read_excel(path = SOURCE, sheet = 2, col_names = TRUE, trim_ws = TRUE, skip = 11)
###REASSIGN COLNAMES
colnames(sheet2)<-sheet2[1,]
#STRIP OUT NA ROWS
sheet2<-sheet2[-c(1,14:20,33:51),]
#STRIP OUT NA COLUMNS
a<-sheet2[,1:12]
b<-sheet2[,16:27]
c<-sheet2[,31:42]
sheet2<-rbind(a,b,c)
sheet2$rep6<-NA
sheet2$rep7<-NA
sheet2$rep8<-NA








sheet3<-read_excel(path = SOURCE, sheet = 3, col_names = TRUE, trim_ws = TRUE, skip = 11)
###REASSIGN COLNAMES
colnames(sheet3)<-sheet3[1,]
#STRIP OUT NA ROWS
sheet3<-sheet3[-c(1,16:18,34:54),]
#STRIP OUT NA COLUMNS
a<-sheet3[,1:12]
b<-sheet3[,16:27]
c<-sheet3[,31:42]
sheet3<-rbind(a,b,c)
sheet3<-na.omit(sheet3)
sheet3$rep6<-NA
sheet3$rep7<-NA
sheet3$rep8<-NA





sheet4<-read_excel(path = SOURCE, sheet = 4, col_names = TRUE, trim_ws = TRUE, skip = 11)
###REASSIGN COLNAMES
colnames(sheet4)<-sheet4[1,]
#STRIP OUT NA ROWS
sheet4<-sheet4[-c(1,14:20,33:51),]
#STRIP OUT NA COLUMNS
a<-sheet4[,1:12]
b<-sheet4[,16:27]
c<-sheet4[,31:42]
sheet4<-rbind(a,b,c)
sheet4$rep6<-NA
sheet4$rep7<-NA
sheet4$rep8<-NA





sheet5<-read_excel(path = SOURCE, sheet = 5, col_names = TRUE, trim_ws = TRUE, skip = 11)
###REASSIGN COLNAMES
colnames(sheet5)<-sheet5[1,]
#STRIP OUT NA ROWS
sheet5<-sheet5[-c(1,15:35),]
#STRIP OUT NA COLUMNS
a<-sheet5[,1:12]
b<-sheet5[,16:27]
c<-sheet5[,31:42]
sheet5<-rbind(a,b,c)
sheet5$rep6<-NA
sheet5$rep7<-NA
sheet5$rep8<-NA












sheet6<-read_excel(path = SOURCE, sheet = 6, col_names = TRUE, trim_ws = TRUE, skip = 11)
###REASSIGN COLNAMES
colnames(sheet6)<-sheet6[1,]
#STRIP OUT NA ROWS
sheet6<-sheet6[-c(1,15:20,34:51),]
#STRIP OUT NA COLUMNS
a<-sheet6[,1:12]
b<-sheet6[,16:27]
c<-sheet6[,31:42]
sheet6<-rbind(a,b,c)
sheet6$rep6<-NA
sheet6$rep7<-NA
sheet6$rep8<-NA










sheet7<-read_excel(path = SOURCE, sheet = 7, col_names = TRUE, trim_ws = TRUE, skip = 11)
###REASSIGN COLNAMES
colnames(sheet7)<-sheet7[1,]
#STRIP OUT NA ROWS
sheet7<-sheet7[-c(1,12:45),]
#STRIP OUT NA COLUMNS
a<-sheet7[,1:12]
b<-sheet7[,16:27]
c<-sheet7[,31:42]
sheet7<-rbind(a,b,c)
sheet7$rep6<-NA
sheet7$rep7<-NA
sheet7$rep8<-NA













sheet8<-read_excel(path = SOURCE, sheet = 8, col_names = TRUE, trim_ws = TRUE, skip = 11)
###REASSIGN COLNAMES
colnames(sheet8)<-sheet8[1,]
#STRIP OUT NA ROWS
sheet8<-sheet8[-c(1,8:20,25:32),]
#STRIP OUT NA COLUMNS
a<-sheet8[,1:12]
b<-sheet8[,16:27]
c<-sheet8[,31:42]
sheet8<-rbind(a,b,c)
sheet8$rep6<-NA
sheet8$rep7<-NA
sheet8$rep8<-NA









sheet9<-read_excel(path = SOURCE, sheet = 9, col_names = TRUE, trim_ws = TRUE, skip = 11)
###REASSIGN COLNAMES
colnames(sheet9)<-sheet9[1,]
#STRIP OUT NA ROWS
sheet9<-sheet9[-c(1,12:20,31:40),]
#STRIP OUT NA COLUMNS
a<-sheet9[,1:12]
b<-sheet9[,14:25]
c<-sheet9[,28:39]
d<-sheet9[,43:54]
e<-sheet9[,58:69]
f<-sheet9[,73:84]
g<-sheet9[,88:99]
h<-sheet9[,103:114]
i<-sheet9[,118:129]
j<-sheet9[,133:144]
k<-sheet9[,147:158]
l<-sheet9[,161:172]
sheet9<-rbind(a,b,c,d,e,f,g,h,i,j,k,l)
sheet9$rep6<-NA
sheet9$rep7<-NA
sheet9$rep8<-NA





sheet10<-read_excel(path = SOURCE, sheet = 10, col_names = TRUE, trim_ws = TRUE, skip = 11)
###REASSIGN COLNAMES
colnames(sheet10)<-sheet10[1,]
#STRIP OUT NA ROWS
sheet10<-sheet10[-c(1,15:20,34:40),]
#where the columns start
which(colnames(sheet10) %in% "dose", arr.ind = TRUE)
#STRIP OUT NA COLUMNS
a<-sheet10[,1:12]
b<-sheet10[,14:25]
c<-sheet10[,28:39]
d<-sheet10[,43:54]
e<-sheet10[,57:68]
f<-sheet10[,71:82]
g<-sheet10[,85:96]
h<-sheet10[,99:110]
sheet10<-rbind(a,b,c,d,e,f,g,h)
sheet10$rep6<-NA
sheet10$rep7<-NA
sheet10$rep8<-NA




which(colnames(sheet10) %in% "dose", arr.ind = TRUE)



sheet11<-read_excel(path = SOURCE, sheet = 11, col_names = TRUE, trim_ws = TRUE, skip = 11)
###REASSIGN COLNAMES
colnames(sheet11)<-sheet11[1,]
#STRIP OUT NA ROWS
sheet11<-sheet11[-c(1,18:20,37:47),]
#STRIP OUT NA COLUMNS
a<-sheet11[,1:15]
b<-sheet11[,18:32]
c<-sheet11[,37:51]
sheet11<-rbind(a,b,c)








sheet12<-read_excel(path = SOURCE, sheet = 12, col_names = TRUE, trim_ws = TRUE, skip = 11)
###REASSIGN COLNAMES
colnames(sheet12)<-sheet12[1,]
#STRIP OUT NA ROWS
sheet12<-sheet12[-c(1,18:20,37:55),]
#STRIP OUT NA COLUMNS
a<-sheet12[,1:15]
b<-sheet12[,18:32]
c<-sheet12[,37:51]
sheet12<-rbind(a,b,c)
sheet12<-na.omit(sheet12)











sheet13<-read_excel(path = SOURCE, sheet = 13, col_names = TRUE, trim_ws = TRUE, skip = 11)
###REASSIGN COLNAMES
colnames(sheet13)<-sheet13[1,]
#STRIP OUT NA ROWS
sheet13<-sheet13[-c(1,17:20,36:62),]
#STRIP OUT NA COLUMNS
a<-sheet13[,1:15]
b<-sheet13[,18:32]
c<-sheet13[,37:51]
sheet13<-rbind(a,b,c)
sheet13[,12:15]<-NULL
sheet13<-na.omit(sheet13)
sheet13$rep5<-NA
sheet13$rep6<-NA
sheet13$rep7<-NA
sheet13$rep8<-NA






sheet14<-read_excel(path = SOURCE, sheet = 14, col_names = TRUE, trim_ws = TRUE, skip = 11)
###REASSIGN COLNAMES
colnames(sheet14)<-sheet14[1,]
#STRIP OUT NA ROWS
sheet14<-sheet14[-c(1,17:20,36:62),]
#STRIP OUT NA COLUMNS
a<-sheet14[,1:11]
b<-sheet14[,14:24]
c<-sheet14[,29:39]
sheet14<-rbind(a,b,c)
sheet14<-na.omit(sheet14)
sheet14$rep5<-NA
sheet14$rep6<-NA
sheet14$rep7<-NA
sheet14$rep8<-NA







df<-rbind(sheet2,sheet3,sheet4,sheet5,sheet6,sheet7,sheet8,sheet9,sheet10,sheet11,sheet12,sheet13,sheet14)

colnames(x)

#c<-na.omit(c)



###prep fpr ggplot into long format
df<-gather(df,key = "REPS", value = "value", c(8:15))
class(df$value)
class(df$hours)

df$hours<-as.integer(df$hours)
df$value<-as.integer(df$value)
breaks<-10^(-10:10)


##check if dose has NA and which row then remove those
blank_rows<-which(is.na(df$dose), arr.ind = TRUE ) 
  df1<-df[-c(blank_rows),]


  
 #####here i can hand in df and grpah a subset of the data 
 df1 %>%  
#subset(. , strand == "AS" & study == "11374" & dose == "10") %>% 
ggplot(., mapping = aes(x= hours, y = value, group = strand ))+
  geom_point(stat = "identity", aes(colour = study))+
  geom_line()+
  #geom_smooth(method = lm)+
  facet_grid(study~strand +dose)+
  theme(axis.text.x=element_text(angle = 90, vjust = 0.5))+
  scale_y_log10(
    breaks = scales::trans_breaks("log10", function(x) 10^x),
    labels = scales::trans_format("log10", scales::math_format(10^.x))
  )

  
  # coord_trans(x = "identity", y = "log10") +
  #annotation_logticks(scaled = FALSE)
  
  
write.csv(df1,file = "H:/SPARK/test.csv")



#####MY ATTEMPT TO FUNCTIIONALIZE MY PLOT ARGUMENT NAMES MUST DIFFER FROM COLUMN HEADINGS HENCE THE UNDERSCORE
install.packages("rlang")
library(rlang)

myplot<-function(study_,dose_,strand_){
df2<-filter(df1,study == study_ & dose == dose_  & strand == strand_)
ggplot(data = df2, mapping = aes(x= hours, y = value, group = strand ))+
  geom_point(stat = "identity", colour = df2$study)+
  geom_line()+
  #geom_smooth(method = lm)+
  facet_grid(study~strand +dose)+
  theme(axis.text.x=element_text(angle = 90, vjust = 0.5))+
  scale_y_log10(
    breaks = scales::trans_breaks("log10", function(x) 10^x),
    labels = scales::trans_format("log10", scales::math_format(10^.x))
  )
  
  
}


myplot("18436","50","SS")




myplot(11374,10, "AS")    ####ARGGGGGGHHHHH!!!



