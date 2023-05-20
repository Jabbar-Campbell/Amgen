
FILES<-list.files(path = "C:/Users/jabbarc/Desktop/New folder/", full.names = TRUE)

splitter<-function(FILE){

#FILE<-"C:/Users/jabbarc/Desktop/New folder/sanjiv_9000016756.csv"
#FILE<-"C:/Users/jabbarc/Desktop/New folder/sanjiv_8000196147.csv"

  
  library(dplyr)
  #read in the data
  
  df<-read.table(file=FILE,skip=11,sep = ",",nrows=32)
  
  #rewrite colnames
  colnames(df)<-c("row",c(1:48))
  #convert to a data frame
  df<-as.data.frame(df)
  
  #get rid of last column
  df$"50"<-NULL
  df<-df[,1:49]
  
  
  
  #we need a column of rows since row AA etc wont make any sense
  df$row_num<-c(1:32)
  
  
  
  substr(FILE, 44,53)
  library(tidyr)
  #gather the table
  df<-gather(df,key = "column", value = "value", c(2:49) )
  
  df$column<-as.integer(df$column)
  class(df$column)
  
  
  
  #we need to make our lists for the KEY to be used 
  
  column<-c(rep(1:24,16),rep(25:48,16),rep(1:24,16),rep(25:48,16))
  row_num<- c(rep(rep(1:16,each=24),2) , rep(rep(17:32,each=24),2))
  plate<-c(rep(substr(FILE, 44,53),1152), rep(substr(FILE, 44,53),384))
  quadrant<-c(rep("alpha",384),rep("delta",384),rep("gamma",384),rep("p38",384))
  
  
  #make a key out of my list
  KEY<-data.frame(row_num,column,plate,quadrant)
  class(KEY$column)
  
  #merge the data with the key
  df<-merge(df,KEY)
  
  
  #Do not drop rownum column to preserve the order
  #df$row_num<-NULL
  
  
  #group_by(quad)
  
  alpha<-filter(df,df$quadrant=="alpha")
  delta<-filter(df,df$quadrant=="delta")
  gamma<-filter(df,df$quadrant=="gamma")
  
  p38<-filter(df,df$quadrant=="p38")
  
  
  
  #spread out each DATA FRAME
  alpha<-spread(alpha, key = "column", value = value)
  colnames(alpha)[5:28]<-as.character(1:24)
  #alpha$quadrant<-NULL
  #alpha$plate<-NULL
  
  delta<-spread(delta, key = "column", value = value)
  #colnames(delta)[4:27]<-c(1:24)
  #delta$quadrant<-NULL
  #delta$plate<-NULL
  
  gamma<-spread(gamma, key = "column", value = value)
  gamma$row<-LETTERS[1:16]
  #gamma$quadrant<-NULL
  #gamma$plate<-NULL
  
  p38<-spread(p38, key = "column", value = value)
  colnames(p38)[5:28]<-as.character(1:24)
  #colnames(p38)[4:27]<-c(1:24)
  p38$row<-LETTERS[1:16]
  #p38$quadrant<-NULL
  #p38$plate<-NULL
  
  
  #write out the files
  #write.table(alpha[,c(2,5:28)],file =paste0("H:/ENZYMOLOGY/ENVISION/raw_data/paramita_R_writeout_alpha_",alpha$plate[1],"_"), row.names = FALSE, sep = "\t")
  # write.table(delta[,c(2,5:28)],file = paste0("H:/ENZYMOLOGY/ENVISION/raw_data/paramita_R_writeout_delta_",delta$plate[1],"_"), row.names = FALSE,  sep = "\t") 
  #write.table(gamma[,c(2,5:28)],file = paste0("H:/ENZYMOLOGY/ENVISION/raw_data/paramita_R_writeout_gamma_",gamma$plate[1],"_"), row.names = FALSE,  sep = "\t")
  #(p38[,c(2,5:28)],file = paste0("H:/ENZYMOLOGY/ENVISION/raw_data/paramita_R_writeout_p38_",p38$plate[1],"_"), row.names = FALSE, sep = "\t") 
  
  
  
  
  
  ###rwite out files with the date
  
 # class(DATE)
  DATE<-date()
  DATE<-substr(DATE, 5,25)
  DATE<-gsub(pattern = ":",replacement = "-", DATE)
  #```{ }
  
  write.table(alpha[,c(2,5:28)],file = paste0("H:/ENZYMOLOGY/ENVISION/raw_data/", DATE,"_paramita_R_writeout_alpha_",alpha$plate[1],"_"), row.names = FALSE, sep = "\t")
  write.table(delta[,c(2,5:28)],file = paste0("H:/ENZYMOLOGY/ENVISION/raw_data/", DATE,"_paramita_R_writeout_delta_",delta$plate[1],"_"), row.names = FALSE, sep = "\t")
  write.table(gamma[,c(2,5:28)],file = paste0("H:/ENZYMOLOGY/ENVISION/raw_data/", DATE,"_paramita_R_writeout_gamma_",gamma$plate[1],"_"), row.names = FALSE, sep = "\t")
  write.table(p38[,c(2,5:28)],file = paste0("H:/ENZYMOLOGY/ENVISION/raw_data/", DATE,"_paramita_R_writeout_p38_",p38$plate[1],"_"), row.names = FALSE, sep = "\t")
  #```
}





lapply(X = FILES,FUN = splitter)

