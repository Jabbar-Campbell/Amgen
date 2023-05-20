Files<- list.files(path =  "//chowder/Departments/Neuroscience/Jabbar Campbell/ck1delta/20170609", full.names = TRUE   )

DFLIST<-LETTERS[1:length(Files)]

Names<-c(1:length(Files))
         
 for( i in 1:length(Files)){  
           Names[i]<-substr(Files[i],79,84)
}
         
       
for (i in 1:length(Names)){
           assign(Names[i],read.table(file = Files[i], header = TRUE, sep = ",", skip = 36,nrows = 17))
}



         
plate1$Time<- c(rep(c(50,40,30,20,15,10,0), each =2), rep(NA,3))
plate2$Time<- c(rep(c(40,30,20,15,10,5,0), each =2), rep(NA,3))
plate1$Exp<-c(rep("PLATE_1", each= 14), rep(NA,3))
plate2$Exp<-c(rep("PLATE_2", each= 14), rep(NA,3))
plate1$replicate<-c(rep(c(1,2),7),rep(NA,3))
plate2$replicate<-c(rep(c(1,2),7),rep(NA,3))


plate1<-plate1[1:14,c(1:17,26:28)]
plate2<-plate2[1:14,c(1:17,26:28)]



TOP<-400
DIL<-2
steps<-c(1:16)
serial<-TOP/DIL^(steps-1)


names(plate1)[1:17]<-c("row",serial)
names(plate2)[1:17]<-c("row",serial)

df<-rbind(plate1, plate2)


library(tidyverse)

df<-gather(df,key=Conc_uM, value= "value",2:17)

serial
column<-c(1:16)

m <- matrix(0, ncol = 2, nrow = 16)
m<-as.data.frame(m)
m$V1<-names(plate1)[2:17]
m$V2<-column
names(m)[1]<-"Conc_uM"
names(m)[2]<-"column"



df<-merge(m,df)
df$Conc_uM<-as.numeric(df$Conc_uM)
class(df$Time)


x<-mutate(df, Conc_M =  Conc_uM /1000000 )


library(ggplot2)




  ggplot(df,mapping = aes(x = Time, y= value,))+
  geom_point( aes(color = Conc_uM))+
  geom_line( aes( group= Conc_uM,color = Conc_uM))+
  facet_grid(Exp~replicate)
  #facet_wrap(~replicate)

  
  library(viridis)
  ggplot(df,mapping = aes(x = column, y= row))+
  geom_tile(aes(x=column, y= rev (row), fill = value) )+
  coord_equal()+
  facet_grid(Exp~replicate)+
  scale_fill_viridis(option = "magma", name = "Legend")
  
  
  
  
x<-mutate(df, Conc_M =  Conc_uM /1000000 )
x$Conc_uM<-NULL
y<-unite(x,col = Plate ,c(Exp,replicate), sep = "_")



library(dplyr)
library(tidyverse)

prism<-spread(y[,c(3:6)],key=Conc_M,value = value)
prism<-arrange(prism,Plate )


write.table(prism, file = "clipboard",sep = "\t")
