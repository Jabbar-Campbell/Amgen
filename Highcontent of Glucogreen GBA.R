library(tidyverse)
library(ggplot2)
library('officer' )


FILE<-"C:/Users/Jabbar/Desktop/20202102_NPC2_40x_hela_glucogreen_per_well.csv"

df<-read.csv(file = FILE )

df<-separate(df,WELL.LABEL,into =c("row","junk"), sep = "-" )

df$junk<-NULL
df$row<-NULL
df$Z<-NULL
df$T<-NULL

#Column key
#This will most likely change each time
Key1<- read.table(file = "clipboard", sep = "\t", header = TRUE)

#Row key
#This will most likely change each time
Key2<- read.table(file = "clipboard", sep = "\t", header = TRUE)

colnames(Key1)[1]<-"Column"
colnames(Key2)[1]<-"Row"


df<-merge(df,Key1, by =  "Column")

df<-merge(df, Key2, by= "Row")

df1<-gather(df,key = "Metric", value = Value, c(3:18))
df1<-unite(df1, TREATMENT, conc.uM, col = "TREATMENT2", sep = " ", remove = FALSE)

#rep1<-filter(df1,rep == "rep 1" )
#rep2<-filter(df1,rep == "rep 2" )
#rep3<-filter(df1,rep == "rep 3" )
#rep4<-filter(df1,rep == "rep 4" )
#rep5<-filter(df1,rep == "rep 5" )
#rep6<-filter(df1,rep == "rep 6" )
#rep7<-filter(df1,rep == "rep 7" )
#rep8<-filter(df1,rep == "rep 8" )





#we can choose to plot each rep
ggplot(rep1, aes(x= TREATMENT2, y = Value, colour = Metric))+
  geom_bar(stat= "identity")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  facet_wrap(.~Metric, scales = "free_y", ncol = 3 )








###we can group and summarize  across replicates
df2<-df1 %>% 
  group_by(.,TREATMENT,conc.uM,Metric, TREATMENT2)%>% 
  #summarize(avg_value = mean(Value), Standard_error = sd(Value))
  summarize(avg_value = mean(Value), std_dev = sd(Value),std_err = std_dev/ sqrt(length(Value))  )


plot1<-ggplot(df2, aes(x= TREATMENT2, y = avg_value, colour = Metric))+
  geom_bar(stat= "identity")+
  theme(axis.text.x = element_text(angle = 90))+
  geom_errorbar(aes(ymin=avg_value-Standard_error, ymax=avg_value+Standard_error), width=.2)+ 
  facet_wrap(.~Metric, scales = "free_y", ncol = 3 )

# Create a PowerPoint 
doc <- read_pptx()
layout_summary(doc)
doc <- add_slide(doc, layout = "Two Content",master = "Office Theme")
doc <- ph_with(x = doc, value = plot1 ,location = ph_location_fullsize() )
print(doc, target = paste0( "C:\Caraway Project\HIGH CONTENT",".pptx" ))





timestamp()
FILE
target = paste0( "C:\Caraway Project\HIGH CONTENT",  timestamp(),".pptx" )
