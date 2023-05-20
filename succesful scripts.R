                                reads (in a quattro file and resets the column names and plots it)

df<-read.table ("//chowder/Departments/Neuroscience/Jabbar Campbell/Ephys/Quattro/March/Mouse 1.7 20160324/TRACES/20160330  mNav1.7 m#3 run2 cp1_A1_CP.ihd", header=TRUE, skip  = 5,col.names=c("event","time","current","resistance","event","post compound time","post compound current"))
plot(x<-df$time, y<-df$current,type = "l")

                                  

                                JAROSH(reads in 2 data frames, combines them and spits out an excel file)

df1<-read.xlsx("C:/Users/jabbarc/Desktop/R Sample Data/file1.xlsx", sheetIndex = 1, rowIndex = 3:76, colIndex = 1:25, as.data.frame = TRUE, 
header = TRUE, startRow = 3, endRow = 76)
df2<-read.xlsx("C:/Users/jabbarc/Desktop/R Sample Data/file2.xlsx", sheetIndex = 1, rowIndex = 3:76, colIndex = 1:25, as.data.frame = TRUE, 
header = TRUE, startRow = 3, endRow = 76)
df3<-rbind(df1,df2)



write.xlsx(df3,"C:/Users/jabbarc/Desktop/R Sample Data/file 3.xlsx", sheetName = "Ballin like MJ", col.names = TRUE, row.names= TRUE, 
append = FALSE, showNA= FALSE)



                                                    READS in a BARRACUDA FILE IV by column



df = read.table ("//chowder/Departments/Neuroscience/Jabbar Campbell/Ephys/Barracuda/Jabbar/2016-04-08_001_a_h17_IV test with Dan by column.csv",header= TRUE, sep= ",", nrows=384 )


metric4<-select(df, ends_with("_M4", ignore.case = TRUE))###from dplyr###
metric5<-select(df, ends_with("_M5", ignore.case = TRUE))###from dplyr###
sweeps<-seq(-110,10, by=10)
x<-colnames(metric4)
y<-colnames(metric5)
colMeans(metric4,na.rm = TRUE)

metric4scan6<-select(metric4,starts_with("S6",ignore.case=TRUE))
metric4scan7<-select(metric4,starts_with("S7",ignore.case=TRUE))
metric4scan8<-select(metric4,starts_with("S8",ignore.case=TRUE))
smartbind()###from gtools###


                           COPY FROM CLIPBOARD, REASSIGN COLUMN NAMES, SORT BY COLUMN NAME AND EXPORT TO CLIPBOARD
                           
rep1<-read.table(file = "clipboard",header = TRUE, sep = "\t")
rep2<-read.table(file = "clipboard",header = TRUE, sep = "\t")
names(rep2) = paste0(LETTERS[1:16], "2")


df<- cbind(rep1,rep2)

sortdf <- df[,sort(names(df))]

write.table(sortdf, file = "clipboard",sep = "\t",row.names = FALSE)

rep1<- read.table(file = "clipboard", header = TRUE, sep = "\t")
rep2<- read.table(file = "clipboard", header = TRUE, sep = "\t")


colnames(rep2)<-paste0(colnames(rep2),"1")

 

             COPY FROM CLIPBOARD, REASSIGN COLUMN NAMES, BIND, SORT, SPLIT INTO 2 DISTINCT DATAFRAMES SELECTING EVERYOTHER COLUMN.

REP1<-read.table(file = "clipboard", header = TRUE, sep = "\t")
REP2<-read.table(file = "clipboard", header = TRUE, sep = "\t")
REP3<-read.table(file = "clipboard", header = TRUE, sep = "\t")


colnames(REP2)<-paste0(colnames(REP2),"1")
colnames(REP3)<-paste0(colnames(REP3),"3")

df<-cbind(REP1,REP2,REP3)

sortdf<-df[,sort(colnames(df))]


notricine<-sortdf[,c("A","A1","A3","C","C1","C3","E","E1","E3","G","G1","G3","I","I1","I3","K","K1","K3","M","M1","M3","O","O1","O3")]

tricine<-sortdf[,c("B","B1","B3","D","D1","D3","F","F1","F3","H","H1","H3","J","J1","J3","L","L1","L3","N","N1","N3","P","P1","P3")] 

write.table(tricine, file = "clipboard",sep = "\t",row.names = FALSE,col.names = FALSE)

df=read.csv(file = "C:/Users/jabbarc/Desktop/Glycine screener/Glycine screener Exports/all exported.csv", header = TRUE, sep = ",") 






                                          takes in DATA and Gathers it subs out the X for each column for a space
df->read.table(file = "clipboard", header = FALSE, sep= ",")

colnames(df)<-gsub("X","",colnames(df))


df2<-gather(df, key = Concentration, value = activity, 2:23)


                      READS in a folder of files and then takes each and reads it in as a list of Data frames appending
                      a portion of the filename as a column. file one-->take its name and create 2 lists (tricine and     
                      replicate, bind these 2 list onto the original file and move on to file 2-->)
                                     
                                     
files<-list.files( "C:/Users/jabbarc/Desktop/Glycine screener/Glycine screener Exports", pattern = ".csv", full.names = TRUE)
files<-files[2:5]


files<-list.files( "C:/Users/jabbarc/Desktop/Glycine screener/Glycine screener Exports", pattern = ".csv", full.names = TRUE)
files<-files[2:5]



d = lapply(files, function(files){
  d=read.table(file = files[1] , header = TRUE, sep = ",", comment.char = "&")
  filename<- basename(files[1])
  tricine<-strsplit(filename, split = "_")[[1]][2]
  Replicate<-strsplit(filename, split = "_")[[1]][3]
  d<-d[,1:29]
  d<-cbind(d,filename,tricine,Replicate)
  
})

d1<-rbind_all(d)
d2<-d1