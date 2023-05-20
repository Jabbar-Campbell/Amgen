#install.packages("readxl")
#install.packages('tidyverse')
#install.packages('gdata')
#install.packages("ggplot2")
#install.packages("officer") 
library('gdata')
library('readxl')
library('tidyverse')


###want to functionalize? make file an arguement and run this thru lapply
FILE2<-"C:/Caraway Project/RAW DATA/Copy of 12Feb2020_A4_GluGal_Graziotto with new Pi Key.xlsx"

FILE1<-"C:/Caraway Project/RAW DATA/Copy of 19Feb2020_A1_Lact_Graziotto with new Pi Key.xlsx"

FILE3<-"C:/Caraway Project/RAW DATA/12July2019_A1_HexLact_Graziotto with groups.xlsx"
  


##read in core data
x<-readxl::read_xlsx(path = FILE3, sheet = 1, skip = 1)
x<-as.data.frame(x)
class(df)



###pick a start AND STOP  and end point for the normalized data
###find a reference point with the which() or where() function
indice_list<- x[,1]
start_main_data<-which(indice_list == "MatrixBlk", arr.ind = TRUE )
Stop_main_data<-which(indice_list == "Comments:", arr.ind = TRUE )-2



df<-x[c(start_main_data:Stop_main_data),]
colnames(df)<-df[1,]

##find where last column is 
column_list<-x[1,]
last_column<-which(column_list == "Cell Line")
df<-df[,c(1:last_column)]

colnames(df)[last_column-1]<-"Treatment"
colnames(df)[last_column]<-"Cell"

colnames(df)
colnames(df)





###pick a start AND STOP  and end point for the normalized data
###find a reference point with the which() or where() function
indice_list<- x[,1]
start_norm_data<-which(indice_list == "Lipidomics ID", arr.ind = TRUE )
Stop__norm_data<-end(indice_list)[1]





#make a table of the normalized data
#NA isng needed and since i couldnt use omit na i reversed filtered where NA wasnt present
norm_tble<-x[c(start_norm_data:Stop__norm_data),c(1:3)]
colnames(norm_tble)<-norm_tble[1,]

norm_tble<-norm_tble[-1,]
norm_tble$`Client ID`<-NULL

#norm_tble<-filter(norm_tble, norm_tble$`Phosphate (Pi) Normalization [nmole/sample]` != "NA")



colnames(norm_tble[1])

colnames(df[1])




#merge the normalization table with the raw value table4
df1<-merge(norm_tble, df, by.x= "Lipidomics ID", by.y = "MatrixBlk", all.y = FALSE)





##check the class of each column
##to find the end and omit treatment and cell columns lets use y as a place holder
y<-length(colnames(df1))
lapply(df1[,c(2:y)],class)
y<-y-2
##turn the class of each column to a numeric
df1[,2:y]<-lapply(df1[,c(2:y)],as.numeric)
class(df1[,1])




#now we can attempt some math manipulation
#divide each value from original data set by the value column across rows on a numeric
#case basis this allows us to keep the character column
##instead of a number take things that have "_nm", "Treatment" and "Cell"
df2<-mutate_if(df1, is.numeric ,funs(nm = ./df1$`Phosphate (Pi) Normalization [nmole/sample]` ))




which(grepl("_nm", colnames(df2))==TRUE)
df2<-df2[,matches(match = c("Lipidomics ID","Treatment","Cell","_nM"), ignore.case = TRUE, vars = colnames(df2))     ]
df2$`Phosphate (Pi) Normalization [nmole/sample]_nm`<-NULL



#of the first comlumn of x take Sample ID and MAtrixBLK to build and gather a data frame with for mapping
##shave off anything uneccesary
#sample id data frame will be defined and trimmed according to  these values
which(x[1]== "Sample ID")
which(x[1]== "MatrixBlk")

sampleID<-x[c(which(x[1]== "Sample ID"),which(x[1]== "MatrixBlk")),]
which(sampleID[1]== "MatrixBlk")
colnames(sampleID)<-sampleID[which(sampleID[1]== "MatrixBlk"),]


samp_ID_stop<-which(sampleID[1,]== "Treatment")

which(grepl("",colnames(sampleID))==FALSE)
  

sampleID<-sampleID[-2,c(1:samp_ID_stop-1)]



#GATHER the  Sample id's t for merging purposes 
#next time just read them all in at once
a<-gather(sampleID,key = "Matrix", value = "Sample_ID")
a<-a[-1,]
a$nm<-"nm"
a<-unite(a, "Matrix", Matrix,nm)


##gather our original data
b<-gather(df2,key = "Matrix", value = "Value", c(4:length(colnames(df2))))




#MERGE THEM TOGETHER
df3<-merge(a,b, by =  "Matrix")
df3$date<-substr(colnames(x)[1],1,10)



#get rid of spacing in order to  use treatment column in  ggplot
df3$Treatment<-gsub(pattern = " ",x = df3$Treatment ,replacement = "_")
df3$Treatment<-gsub(pattern = "-",x = df3$Treatment ,replacement = "_")






#create a table for and merge in replicate values
#first make a tble using lipidomics info
#find start and stop
lip_start<-which(x[1] == "MatrixBlk" )-1
lip_stop<-which(x[1] == "Comments:" )

rep_key<-as.data.frame(df[c(lip_start:lip_stop),1])
rep_key<-filter(rep_key, rep_key$`df[c(lip_start:lip_stop), 1]` != "NA")
colnames(rep_key)[1]<-"Lipidomics ID"


rep_col<-which(x[1,] == "Rep")
rep_start<-which(x[,1] == "MatrixBlk")+1
rep_stop<-which(x[,1] == "Comments:")-2


rep_key$rep<-x[c(rep_start:rep_stop),rep_col]   

colnames(rep_key)[1]<-colnames(df3)[3]

df3<-merge(df3,rep_key, by = "Lipidomics ID")



#Since we what the averages of several metrics lets filter, group and compute the average
#this can be sent to ggplot as well since plyr is part of ggbiplot they need to be detached just remember to reinstall them
detach(package:ggbiplot)
detach(package:plyr)
df4<-df3 %>% 
  separate(.,col = `Lipidomics ID`, into= c("model","loading_order"),sep = "-" ) %>% 
 # filter(.,Sample_ID %in% c( "C16HexosylCer", "C16Lact-Cer" ,"C22HexosylCer", "C22Lact-Cer" ,"C24:1HexosylCer" ,"C24:1Lact-Cer"  , "C24HexosylCer"  , "C24Lact-Cer") ) %>% 
  filter(., grepl('C22|C26|C24|C16',Sample_ID)) %>% 
  group_by(.,Treatment, model, Sample_ID) %>% 
  summarize(avg_value = mean(Value), std_dev = sd(Value),std_err = std_dev/ sqrt(length(Value))  ) 



df5<-df4 %>% 
  ungroup(.,) %>% 
  group_by(.,Treatment)

###create rowise calculation by first get rid of unnessary columns like treatment and cell. Transpose so it can be mutated numerically.
##get rid of columns your dont need and transpose back with some minor editing. now that everything is labeled it can be gathered and heatmapped 
qc<-df %>%   
  mutate(., Treatment=NULL, Cell = NULL, )
 qc<-as.data.frame(t(qc))
 colnames(qc)<- lapply(qc[1,],as.character)
 qc<-qc[-1,]
 qc$columns<-c(1:dim(qc)[1])
 qc <- data.frame(sapply(qc, function(x) as.numeric(as.character(x))))
 #qc<-transmute_all(qc,  funs(ratio = ./ MatrixBlk))
 qc<-mutate_at(qc,vars(-contains("columns")), funs(ratio = ./ MatrixBlk))
 qc<-qc[,matches(match = c("columns","ratio"), ignore.case = TRUE, vars = colnames(qc))     ]
 qc<-as.data.frame(t(qc))
 colnames(qc)<-qc[1,]
 qc<-qc[-c(1,2),]
 qc$index<-LETTERS[1:dim(qc)[1]]
 qc<-gather(qc, key = Column, value = value, c(1:26))
class(qc$Column)

#perhaps tack on the sample id as well and lipidomics_ID in place of letters
samp<-as.data.frame(t(sampleID[1,-1]))
colnames(samp)[1]<-"lipid" 
samp$Column<-c(1:dim(samp)[1])
qc<-merge(qc, samp, by =  "Column")





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
  ggtitle(label = df3$date[1]  ,subtitle = "Lipid profiles"   )+
  geom_errorbar(mapping = aes(ymin =avg_value-std_dev ,ymax=avg_value +std_dev))
  
##plots the treatments next to each othher for each lipid and averages reps
plot4<-ggplot(df5, aes(x=Treatment, y=avg_value, colour = Sample_ID) )+
  geom_bar(stat = 'identity')+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  facet_wrap(~Sample_ID, scales = "free_y")+
  ggtitle(label = df3$date[1]  ,subtitle = "Lipid profiles"   )+
  geom_errorbar(mapping = aes(ymin =avg_value-std_dev ,ymax=avg_value +std_dev))






#uses the qc to heat map anything thats under 

plot5<-ggplot(qc, mapping = aes(x= reorder(as.factor(qc$Column), as.numeric(qc$Column)),y= index))+
  geom_tile(aes(fill = value))+
  scale_fill_gradient(low = "#56B4E9", high = "blue", limits= c(2,max(qc$value)),   na.value = "red" )+
  coord_equal()+
  xlab("Column")+
  ylim(rev(levels(as.factor(qc$index))))+
  scale_x_discrete(limit = c(1:length(levels(qc$lipid))), breaks = c(1:length(levels(qc$lipid))), labels = levels(qc$lipid) )+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
  

length(levels(qc$lipid))
qc[1,3]<-1




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
doc <- add_slide(doc, layout = "Two Content",master = "Office Theme")
doc <- ph_with(x = doc, value = plot4 ,location = ph_location_fullsize() )
doc <- add_slide(doc, layout = "Two Content",master = "Office Theme")
doc <- ph_with(x = doc, value = plot5 ,location = ph_location_fullsize() )
print(doc, target = paste0( "C:/Caraway Project/RAW DATA/lipodomics_",  df3$date[1],".pptx" )) 








