
###for 1536

FILES<-list.files(path = "C:/Users/jabbarc/Desktop/New folder 1536/", full.names = TRUE)

df<-lapply(FILES, FUN = function(FILES){

    df<-read.csv(file = FILES )
    df$date<-substr(FILES, 42,49)
    df$assay<-substr(FILES,51,58)
    df$day<-substr(FILES,77,80)
    df$plate_type<-substr(FILES,60,63)
    df<-rbind(df)
    
})


df<-rbind_all(df)

df<-df[,c(1,2,3,4,5,22,26,27,28,29)]

colnames(df)
#df<-df[,c(1,2,3,4,5,8,30,31,32,33)]


write.csv(df,file =  "C:/Users/jabbarc/Desktop/New folder 1536/1536_compilation.csv")











#FOR 384
FILES<-list.files(path = "C:/Users/jabbarc/Desktop/New folder 384/", full.names = TRUE)

df2<-lapply(FILES, FUN = function(FILES){
  
  df2<-read.csv(file = FILES )
  df2$date<-substr(FILES, 41,48)
  df2$assay<-substr(FILES,50,57)
  df2<-rbind(df2)
  
})

df2<-rbind_all(df2)

df2<-df2[,c(1,2,3,4,5,8,14,15)]

write.table(df2,file =  "clipboard", sep = '\t')

rm(x)
X<-as.data.frame(df2[1])
y<-as.data.frame(df2[2])
z<-as.data.frame(df2[3])
q<-as.data.frame(df2[4])

FILES
df2
