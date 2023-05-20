#install.packages("readxl")
#install.packages('tidyverse')
#install.packages('gdata')
#install.packages("ggplot2")
#install.packages("officer") 
library('gdata')
library('readxl')
library('tidyverse')


###want to functionalize? make file an arguement and run this thru lapply


FILE<-"C:/Caraway Project/RAW DATA/12July2019_A1_HexLact_Graziotto with groups.xlsx"

##read in core data
x<-readxl::read_xlsx(path = FILE, sheet = 1, skip = 1)
x<-as.data.frame(x)
class(df)



###pick a start AND STOP  and end point for the normalized data
###find a reference point with the which() or where() function
indice_list<- x[,1]
start_main_data<-which(indice_list == "MatrixBlk", arr.ind = TRUE )
Stop_main_data<-which(indice_list == "Comments:", arr.ind = TRUE )-2



df<-x[c(start_main_data:Stop_main_data),]
colnames(df)<-df[1,]
df<-df[c(2:13),]
colnames(df)[28]<-"Treatment"
colnames(df)[29]<-"Cell"

colnames(df)
colnames(df)





###pick a start AND STOP  and end point for the normalized data
###find a reference point with the which() or where() function
indice_list<- x[,1]
start_norm_data<-which(indice_list == "Lipidomics ID", arr.ind = TRUE )
Stop__norm_data<-end(indice_list)[1]





#make a table of the normalized data
norm_tble<-x[c(start_norm_data:Stop__norm_data),c(1:3)]
colnames(norm_tble)<-norm_tble[1,]
norm_tble<-norm_tble[c(2:13),]
norm_tble$`Client ID`<-NULL

colnames(norm_tble[1])

colnames(df[1])




#merge the normalization table with the raw value table4
df1<-merge(norm_tble, df, by.x= "Lipidomics ID", by.y = "MatrixBlk")


colnames(df1[,2])

levels(as.factor(df3$Sample_ID))


##check the class of each column
lapply(df1[,c(2:28)],class)

##turn the class of each column to a numeric
df1[,c(2:28)]<-lapply(df1[,c(2:28)],as.numeric)
class(df1[,1])

#now we can attempt some math manipulation
#divide each value from original data set by the value column across rows on a numeric
#case basis this allows us to keep the character column
#df2<-mutate_each(df1[,c(2:28)], funs(nm = ./df1$`Phosphate (Pi) Normalization [nmole/sample]` ))
#df2<-transmute_all(df1[,c(2:28)], funs(nm = ./df1$`Phosphate (Pi) Normalization [nmole/sample]` ))

df2<-mutate_if(df1, is.numeric ,funs(nm = ./df1$`Phosphate (Pi) Normalization [nmole/sample]` ))

df2<-df2[,c(1,29:55)]
df2[1,5]


#extract sample ID mapping from originally dataframe, probably should have read this in initially
sampleID<-x[c(1,3),]
colnames(sampleID)<-sampleID[2,]
sampleID<-sampleID[-2,c(-28,-29)]



#GATHER the data both Sample id's and data set for merging purposes 
#next time just read them all in at once
a<-gather(sampleID,key = "Matrix", value = "Sample_ID")
a<-a[-1,]
a$nm<-"nm"
a<-unite(a, "Matrix", Matrix,nm)



b<-gather(df2,key = "Matrix", value = "Value", c(5:28))




#MERGE THEM TOGETHER
df3<-merge(a,b)
class(df3$Value)
df3$date<-substr(colnames(x)[1],1,10)



#get rid of spacing in order to  use treatment column in  ggplot
df3$Treatment<-gsub(pattern = " ",x = df3$Treatment ,replacement = "_")
df3$Treatment<-gsub(pattern = "-",x = df3$Treatment ,replacement = "_")



#create a table for and merge in replicate values
rep_key<-as.data.frame(levels(as.factor(df3$`Lipidomics ID`)))
rep_key$rep<-rep(c(1,2),6)
colnames(rep_key)[1]<-colnames(df3)[3]
df3<-merge(df3,rep_key, by = "Lipidomics ID")

#Since we what the averages of several metrics lets filter, group and compute the average
#this can be sent to ggplot as well
df4<-df3 %>% 
  filter(.,Sample_ID %in% c( "C16HexosylCer", "C16Lact-Cer" ,"C22HexosylCer", "C22Lact-Cer" ,"C24:1HexosylCer" ,"C24:1Lact-Cer"  , "C24HexosylCer"  , "C24Lact-Cer") ) %>% 
  group_by(.,Sample_ID, Treatment,Cell,date) %>% 
  summarize(avg_value = mean(Value))
  






#now graph
plot1<-ggplot(df3, aes(x=Sample_ID, y=Value, colour = Treatment) )+
  geom_bar(stat = 'identity')+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  facet_wrap(rep~df3$Treatment, scales = "free_y")+
  ggtitle(label = df3$date[1]  ,subtitle = "Lipid profiles"   )

plot2<-ggplot(df3, aes(x=Treatment, y=Value, colour = Treatment) )+
  geom_bar(stat = 'identity')+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  facet_wrap(rep~df3$Sample_ID, scales = "free_y")+
  ggtitle(label = df3$date[1]  ,subtitle = "Lipid profiles"   )

###plots an average of just key metics
plot3<-ggplot(df4, aes(x=Sample_ID, y=avg_value, colour = Treatment) )+
  geom_bar(stat = 'identity')+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  facet_wrap(~Treatment, scales = "free_y")+
  ggtitle(label = df3$date[1]  ,subtitle = "Lipid profiles"   )
  



#lets even write out to powerpoint
library('officer' )

# Create a PowerPoint 
doc <- read_pptx()
layout_summary(doc)
doc <- add_slide(doc, layout = "Two Content",master = "Office Theme")
doc <- ph_with(x = doc, value = plot1 ,location = ph_location_fullsize() )
doc <- add_slide(doc, layout = "Two Content",master = "Office Theme")
doc <- ph_with(x = doc, value = plot2 ,location = ph_location_fullsize() )
doc <- add_slide(doc, layout = "Two Content",master = "Office Theme")
doc <- ph_with(x = doc, value = plot3 ,location = ph_location_fullsize() )
print(doc, target = paste0( "C:/Caraway Project/RAW DATA/lipodomics_",  df3$date[1],".pptx" )) 








