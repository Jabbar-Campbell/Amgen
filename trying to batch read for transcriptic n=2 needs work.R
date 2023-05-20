###THIS SCRIPT WILL TAKE DATA FILES SAVED IN CSV FORMAT FROM SCREENER AND STICHES THEM TOGETHER LABLEING WITH DISCRIPTIONS FROM THE FILE NAME
#BEWARE IF FILE PATHS CHANGE
library(tidyverse)

#CURVEDATA 
#read in files 
FILES<- list.files("C:/Users/jabbarc/Desktop/spotfire curve engine/curve data",full.names = TRUE)
Files<-LETTERS[1:length(FILES)]


df<-lapply(FILES, function(FILES){
  df<-read.csv(file = FILES, header = FALSE, skip = 1)
        #TRYING TO AUTOMATE COLNAMES WITHIN THE LAPPLY
          x<-read.csv(file = FILES, header = FALSE, skip = 1, colClasses = "character", strip.white = TRUE)
          num_columns<-length(x[1,])
          COL_NAMES<-letters[1:length(x[1,])]
          for (i in 1:num_columns){
          COL_NAMES[i]<-x[1,][[i]]
           }
  
  colnames(df)<- COL_NAMES
  #df<-df[2:25,]
 x<-strsplit(FILES,split = "_")
 df$assay<-x[[1]][2]
  df$company<-x[[1]][4] 
  df

} 
)


#TRYING TO AUTOMATE COLNAMES
#x<-read.csv(file = FILES[3], header = FALSE, skip = 1, colClasses = "character")
#num_columns<-length(x[1,])
#COL_NAMES<-letters[1:length(x[1,])]
#for (i in 1:num_columns){
#COL_NAMES[i]<-x[1,][[i]]

#strsplit(FILES[3],split = "_")

df1<-bind_rows(df)

#df1$`AC50 [M]`<-as.numeric(df1$`AC50 [M]`)

#df1 <-mutate(df1,df1$`AC50 [M]`*1000000)

colnames(df1)[27]<-"AC50 [uM]"
write.csv(df1, file = "H:/ENZYMOLOGY/ENVISION/raw_data/curvedata.csv")

 
 



"C:/Users/jabbarc/Desktop/spotfire curve engine/well data"




 #WELL DATA USING THE SAME VARIABLES
 FILES<- list.files("C:/Users/jabbarc/Desktop/spotfire curve engine/well data",full.names = TRUE)
 Files<-LETTERS[1:length(FILES)]
 
 
 df<-lapply(FILES, function(FILES){
   df<-read.csv(file = FILES, header = FALSE, skip = 1)
   #colnames(df)<-c("Index",	"Plate ID",	"Run",	"Row",	"Column",	"Compound ID",	"Conc. [?M]",	"Well Type",	"Masked",	"Ratio Raw",	"Normalized",	"665nMRaw",	"Normalized",	"615 Raw",	"Normalized", "ASSAY")
            #TRYING TO AUTOMATE COLNAMES WITHIN THE LAPPLY
             x<-read.csv(file = FILES, header = FALSE, skip = 1, colClasses = "character", blank.lines.skip = TRUE)
             num_columns<-length(x[1,])
             COL_NAMES<-letters[1:length(x[1,])]
             for (i in 1:num_columns){
             COL_NAMES[i]<-x[1,][[i]]
             
             
             
             }
   colnames(df)<- COL_NAMES
  # df<-df[2:4626,]
   
   x<-strsplit(FILES[1],split = "_")
   df$assay<-x[[1]][2]
   df$company<-x[[1]][4] 
   df
   
 } 
 )
 
 

 df1<-bind_rows(df)
 
 df1$`Conc. [?M]`<-as.numeric(as.character(df1$`Conc. [?M]`))  #to convert a column of factors to nunbers

 
 df1<-mutate(df1,df1$`Conc. [?M]`/ 10^6) #add a column dividing molar values by 1000000
 

 colnames(df1)[18]<-"Conc_molar"  #rename column

 

 
 write.csv(df1, file = "H:/ENZYMOLOGY/ENVISION/raw_data/well data.csv")


 
 

 
 