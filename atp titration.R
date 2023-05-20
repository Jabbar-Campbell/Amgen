###READ IT IN ADDING IN TIME COLUMN 
df<-read.table(file = "H:/ENZYMOLOGY/CK1DELTA/20170601_atp_titration_001.csv", sep = ",", skip = 36, nrows = 16 ,header = TRUE)
colnames(df)<-gsub("X","",colnames(df))
df$time = c(seq(80,0,by=-10),rep(NA,7))


colnames(df)[1]<-"row"





#GATHER THE DATA
df<-gather(df[1:9,],key = column,value = "value",2:25)







#CREATE A DILUTION SCHEME 
steps<-seq(1:24)
dil<-2
top<-400/10^6
series<-top/dil^(steps-1)








#MAKE THIS DILUTION SCHEME A DATAFRAME TO BE MERGED IN WITH THE ORIGINAL
map<-data.frame("atp_conc"=series,column=steps)
df<-merge(df,map,by="column")

###for prism molar values must be converted into log10
df<-mutate(df, logconc= log10(atp_conc))




###for km we first need the slopes of the various ATP concentrations thruout time. 
atplot<-ggplot(df, mapping=aes(x = time,y = value, color = atp_conc))+
  geom_point( )+
  geom_line( aes(group= atp_conc))


df<-mutate(df, logconc= log10(atp_conc))
atplot

#####we can also make a tile of this data. 
library(viridis)
envis<-ggplot(df, mapping = aes(x = column ,y = row, color= value))+
  geom_tile(aes(fill=value,x = factor(as.numeric(column))))+
  ylim(rev(levels(df$row))) +
  coord_equal()+
  scale_fill_viridis(option = "magma", name = "Legend")+
  coord_cartesian(ylim=c(8, 16))+
  geom_text(aes(label = round(value)))
  levels(df$row)[1:9]
  
  
  
library(cowplot)
plot_grid(envis,atplot)
  
###PLOT THE GATHERED DATA
#ggplot(df, mapping=aes(x = log10(atp_conc),y = value, color = time))+
 # geom_point( )+
  #geom_line( )
  #geom_smooth( aes(group=time), se=FALSE)+
  
  ####heres a way to hijack geomsmooth and instruct it abdondon it default and use a self starting four parameter logistic
#geom_smooth(aes(group=time),method = 'nls', formula = y ~ SSfpl(atp_conc,A,B,xmid,scal),se=FALSE)



#SPREAD THE GATHERED data FOR PRISM AND THEN SAVE THE FOOTPRINT.
prismdf<-spread(df[,c(3,4,6)], key = logconc, value = value )

write.table(prismdf,file = "clipboard", sep= " ")

save.image(file = "H:/ENZYMOLOGY/CK1DELTA/20170601_atp_titration_001.Rdata")
load(  file= "H:/ENZYMOLOGY/CK1DELTA/20170601_atp_titration_001.Rdata")




