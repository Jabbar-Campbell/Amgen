
df<-read.table(file = "C:/Users/jabbarc/Desktop/TEST/20170531_001.csv", sep = ",", skip = 36, nrows = 16 ,header = TRUE, )
df<- df[1:4,1:17]



steps<-seq(1,8)
top<-400
dilfactor<-2
series<-top/dilfactor^(steps-1)


series<-rep(series,each=2)
x<-rep(c(1,2), times=8)



colnames(df)[2:17]<-paste0(series,"_nM","_",x)

df$X<-c("Lot#070501","Lot#0705122","Carna", "Invitrogen" )
colnames(df)[1]<-"CK1delta_source"


gdf<-gather(df,key = "conc", value = "value", 2:17)


gdf<-separate(gdf,col = conc, into= c("conc","units","replicate"), sep = "_")

gdf$conc<-as.numeric(gdf$conc)
gdf<-mutate(gdf,conc2=conc/10^9)


ggplot( gdf  , mapping= aes(x= log10(conc2),y= value,color = CK1delta_source))+
  geom_point(aes(shape=replicate),size=1.5)+
  geom_line(aes(group=interaction(replicate,CK1delta_source)))


prismdf<-gdf[,c(1,4:6)]   %>% 
  spread(key = CK1delta_source ,value=value)
write.table(prismdf,file = "clipboard", sep= "\t")




