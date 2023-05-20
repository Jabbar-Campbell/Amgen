library(tidyverse)
#READ IN FILE NAMES
FILES<-list.files(path = "C:/Users/jabbarc/Desktop/New folder", full.names = TRUE)


#READ IN THE DATA AND TAG A COLUMN WITH A DATE THAT OCURS IN THE FILENAME
df<-lapply(FILES, function(FILES){
             df<-read.csv(file = FILES, header = TRUE ,sep = "," , fill = TRUE)
             n = nrow(df)
             df<-df[1:(n-2),]
             df$date<-substr(FILES, 37,44)
             df
}  )
           


#BIND ALL THE FILES INTO ONE DATAFRAME
df<-rbind_all(df)

#MAKE A TABLE FOR THE DIFFERENT DAYS AND DATES SO NOMENCLATURE IS EASIER. LOOPING THRU THE DATAFRAME WOULD BE REALLY HARD
day<- c("day 1", "day 2", "day 3", "day 4")
date<- c( "20170822", "20170824", "20170825","20170828")
x<-cbind(day,date)
df<-merge(x,df)





#MAKE A NEW TABLE THAT SUMMARIZES THE AVERAGE IC50S BASED ON UNIQUE COMPOUND. MERGE THIS BACK INTO THE DATAFRAME FOR FURTHER COMPUTATION
#SUCH AS A COLUMN THAT LOOKS AT FOLD DIFFERENCE
df2<-df%>% 
  group_by(Compound.ID) %>% 
summarize( avg = mean(AC50..M.), stand_dev= sd(AC50..M.), log_avg = mean(log10(AC50..M.)), log_stand_dev= sd(  log10(AC50..M.) ))  

df<-merge(df2,df)


df<-mutate(df, three_fold =  df$avg/df$AC50..M., Stand_dev = sd(AC50 )

#GIVE ME ANYTHING IN THAT COLUMN THAT IS THREE FOLD ABOVE OR BELOW
outside_QC<-subset(df, three_fold >= 3 | three_fold <= .3)











#GRAPH THE DATA CALLING ON VARIABLES BY NAME LETS DO THIS IN THREE DIFFERENT WAYS

ggplot(df, aes(y=AC50..M.,x= Compound.ID))+
  geom_point(aes(color= day))+
  facet_wrap(~Compound.ID)+
  scale_y_log10()+
  scale_x_discrete(breaks = NULL)



ggplot(df, aes(y=log10(AC50..M.),x= Compound.ID))+
  geom_boxplot(aes(fill = Compound.ID) , alpha = 0.5)+
  geom_point(aes(color= Compound.ID))+
  #facet_wrap(~Compound.ID)+
  #scale_y_log10()+
  scale_x_discrete(breaks = NULL)



ggplot(df2, aes(x= Compound.ID,y=log_stand_dev))+
  geom_point(size = 3)+
  scale_x_discrete(breaks = NULL)+
  scale_y_continuous(limits = c(0,1))+
  geom_hline(aes(yintercept = 0.5), linetype = 2, color = "red"   , size = 1  )+
  theme_bw()+
  geom_text(aes(x = "1276055#2", y = 0.6, label = "1276055#2" ))+
  #geom_rect(aes(xmin = "1062090#1", xmax =   "1276030#1"     , ymin = 0.45, ymax = 0.65), fill = "NULL")
  geom_point( data = subset(df2,Compound.ID == "1276055#2" ) , shape = 17, size = 6 , color = "red"  )+
  labs( caption = "greater then three fold data in red ")


ggplot(df2, aes(x= Compound.ID,y=log_stand_dev))+
  geom_point(size = 3 , aes(color = Compound.ID))+
  scale_x_discrete(breaks = NULL)+
  scale_y_continuous(limits = c(0,1))+
  geom_hline(aes(yintercept = 0.5), linetype = 2, color = "red"   , size = 1  )+
  theme_bw()+
  geom_text(aes(label=ifelse(log_stand_dev>.25,as.character(Compound.ID),'')),hjust=0,vjust=0)+
  #geom_text(aes(x = "1276055#2", y = 0.53, label = "1276055#2" ))+
  #geom_rect(aes(xmin = "1062090#1", xmax =   "1276030#1"     , ymin = 0.45, ymax = 0.65), fill = "NULL")
  #geom_point( data = subset(df2,Compound.ID == "1276055#2" ) , shape = 17, size = 6 , color = "red"  )+
  labs( caption = "greater then three fold data in red ")
  
ggplot(df, aes(x= Compound.ID,y=log10(AC50..M.)) )+
  geom_point(size = 3 , aes(color = Compound.ID))+
  #scale_x_discrete(breaks = NULL)+
  #scale_y_continuous(limits = c(0,1))+
  #geom_hline(aes(yintercept = 0.5), linetype = 2, color = "red"   , size = 1  )+
  theme_bw()+
  theme(legend.position ="NULL")+
  #geom_text(aes(label=ifelse(log_stand_dev>.25,as.character(Compound.ID),'')),hjust=0,vjust=0)+
  #geom_text(aes(x = "1276055#2", y = 0.53, label = "1276055#2" ))+
  #geom_rect(aes(xmin = "1062090#1", xmax =   "1276030#1"     , ymin = 0.45, ymax = 0.65), fill = "NULL")
  #geom_point( data = subset(df2,Compound.ID == "1276055#2" ) , shape = 17, size = 6 , color = "red"  )+
  labs( caption = "greater then three fold data in red ")
 

