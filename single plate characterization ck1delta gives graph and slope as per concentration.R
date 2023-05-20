


#Quadrant 1 .3nM
Col<-rep(c(1:12), 7)
length(Col)
Row<-rep(LETTERS[1:7],12)
length(Row)
Conc<-rep(".3nM",84)

Col<-as.data.frame(Col)
Row<-as.data.frame(Row)
Conc<-as.data.frame(Conc)
Quad1<-cbind(Col,Row,Conc)

#Quadrant 2 .6nM
Col<-rep(c(13:24), 7)
length(Col)
Row<-rep(LETTERS[1:7],12)
length(Row)
Conc<-rep(".6nM",84)
Col<-as.data.frame(Col)
Row<-as.data.frame(Row)
Conc<-as.data.frame(Conc)
Quad2<-cbind(Col,Row,Conc)



#Quadrant 3 1.2nM
Col<-rep(c(1:12), 7)
length(Col)
Row<-rep(LETTERS[10:16],12)
length(Row)
Conc<-rep("1.2nM",84)
Col<-as.data.frame(Col)
Row<-as.data.frame(Row)
Conc<-as.data.frame(Conc)
Quad3<-cbind(Col,Row,Conc)


#Quadrant 4 2.4nM
Col<-rep(c(13:24), 7)
length(Col)
Row<-rep(LETTERS[10:16],12)
length(Row)
Conc<-rep("2.4nM",84)
Col<-as.data.frame(Col)
Row<-as.data.frame(Row)
Conc<-as.data.frame(Conc)
Quad4<-cbind(Col,Row,Conc)

#make a key of the various quadrants (forgot time and ATP so this will come later)
Key<-rbind(Quad1,Quad2,Quad3,Quad4)



#read in the file wrangle and gather
df<-read.table(file = "H:/ENZYMOLOGY/ENVISION/raw_data/20190320_ckdelta_ATP_titration_.3nm_.6nm_1.2nm_2.4nM_6timepoints_001.csv", header = FALSE, skip = 10, sep = ",",nrows = 17, col.names = c("row",(1:25))  ) 
df$X25<-NULL
df<-df[2:17,]
library(tidyverse)
df1<-gather(df, key = key, value = value , c(2:25))
df1<-separate(df1, col= key,into =  c("x","Col"), sep = 1)
df1$x<-NULL
colnames(df1)[1]<-"Row"
 

#merge in the key
df1<-merge(df1,Key)

 
 #merge in the time axis
Row<-c(LETTERS[1:16])
Time<-c(30,25,20,15,10,5,0,"null","null",30,25,20,15,10,5,0)
Row<-as.data.frame(Row)
Time<-as.data.frame(Time)
Time<-cbind(Row,Time)
 df1<-merge(df1,Time)
 

 
 #merge in the ATP axis
Col<-c(1:24)
Top<-400
Factor<-2
steps<-12
Series<-Top /Factor^((1:steps)-1) 
ATP<-c(Series,Series)

Col<-as.data.frame(Col)
ATP<-as.data.frame(Series)
ATP<-cbind(Col,ATP)
df1<-merge(df1,ATP)
colnames(df1)[6]<-"ATP"   




#group data by enzyme concentration
df1<-group_by(df1,Conc)
as.numeric(as.character(df1$Time))




sub

#plot the data
library(ggplot2) 
#plot<-
ggplot(data= df1, mapping = aes(x=as.numeric(as.character(df1$Time)),y=value, colour = as.factor(ATP)   ),  method = "lm"     )+
geom_point()+
geom_smooth(method = lm, se = FALSE)+
facet_wrap(~Conc)

#heatmap
ggplot(data=df1, mapping = aes(x = as.integer(Col), y=rev (Row)) ,colour = "grey50"  )+
  geom_tile(aes( fill = value,) , stat = "identity", colour = "grey50")
 

#exract slopes
slopes<-df1 %>% 
  group_by(ATP,Conc) %>% 
  do({
    mod = lm(value ~ Time, data = .)
    data.frame(Slope = coef(mod)[2])
  })


#plot the slo0es
ggplot(slopes, mapping = aes (x= ATP, y= Slope))+
  geom_point()+
  geom_smooth(method = "loess", se = FALSE)+
  facet_wrap(~Conc)
 
write.table(slopes,file = "clipboard", sep = "\t")


#we can try to get kd using the formula from prism Y=Bmax*X/(Kd + X)
#x: concentration of ligand
#yspecific binding
#Bmax maximum binding in unit of Y axis or Total density of receptors = R + R L   
#Kd is the same unit of X axis


