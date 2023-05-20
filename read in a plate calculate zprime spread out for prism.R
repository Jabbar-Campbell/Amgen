library(tidyverse)

##REAd IN THE PLATE AND FORMAT AS NEEDED
df<-read.table(file = "H:/ENZYMOLOGY/CK1DELTA/Raw data/CK1 delta screen/20170719/20170619_ck1delta_DR_8000183462.csv", header = TRUE, sep = ",", skip = 10, nrows = 16, col.names = c(1:25))
class(df[1,])
colnames(df)
colnames(df)<-c("Row" ,c(1:24))
                




####GATHER THE DATA
df<-gather(df, key = "column", value = "value", 2:25 )
df$column<-as.numeric(df$column) 
df$value<-as.numeric(df$value) 




####CALCULATE THE MEANS OF 23 AND 24 STORE THAT IN A TABLE CALLED NORMALIZED TO REFERENCE LATER. 
normalized<- df %>% 
            filter( column == 23 | column == 24) %>% 
            group_by(column) %>% 
            summarise(MEAN = mean(value))

#ADD COLUMNS OF A VALUE FROM NORMALIZED TABLE IN ORDER TO CALCULATE A FINAL COLUMN CALLED WINDOW
df$low<- rep(normalized[1,2 ],384)
df$high<- rep(normalized[2,2 ],384)
normalized$column
df$high<-as.numeric(df$high)
df$low<-as.numeric(df$low)


###HERE WE CREATE OUR CALCULATE COLUMN CALLED WINDOW USING MUTATE FROM  DPLYR
df<-mutate(df, window =  high - low)
df<-mutate(df,normalized= (value/window)*100)

df<-df[,c(1,2,7)]



#WE CALCULATE Z PRIME BT MAKING A TABLE THAT CALCULATES THE MEAN AND SD OF COLUMNS 23 AND 24 AND PERFOMRS A CALCULATION, df NEEDS TO BE NUMERIC OR FACTOR TO WORK
class(df$value)
class(Z$value)
class(df$Row)

Z<-df %>% 
  filter(column == "23" | column == "24") %>% 
  group_by(column) %>% 
  summarise(mean =  mean(normalized), std= sd(normalized))

zprime= 1-( 3*(   Z[2,3] + Z[1,3]     )/      abs(Z[2,2]- Z[1,2]  ))
zprime<- round(zprime,digits = 5)

###FOR EXPORTATION WE NEED TO CALCULATE OUR DILUTION SCHEME AND APPEND THIS.
top = 5
dil = 2
steps = 22
series<-top/dil^(c(1:steps)-1)

###MAKE A DATA FRAME OF COLUMNS AND DILTUION SERIES 
conc<-as.data.frame(series)
conc$column<-c(1:22)
conc[23,]<- c("low","23")
conc[24,]<- c("high","24")


###MERGE THIS DILUTION SERIES DATA IN WITH OUR VALUES
prism<-merge(conc,df)
prism<-spread(prism,key = Row, value = normalized)


#prism<-prism[c(1:15,18:24),]
prism$key<-as.numeric(prism$key)
cpdlist<-readClipboard()
colnames(prism)<-c("column", "conc", cpdlist)
write.table(prism,file = "clipboard",sep = "\t")










spotfire<-gather(prism, key = "Row", value = value, 3:18)
x<-as.data.frame(cpdlist)
y<-as.data.frame(LETTERS[1:16])
x<-cbind(x,y)
colnames(x)<- c( "compound","Row")

spotfire<-merge(x,spotfire)


write.table(spotfire,file = "clipboard",sep = "\t")






###no clue why this works but it works but something to do with Row having to be a factor and then discrete levels, instead of a character string. ggplot likes integers.

#df$Row = with(df, factor(Row, levels = rev(levels(Row))))



#####LETS HEAT MAP
ggplot(df, aes(x= as.factor(column),y = Row))+
  geom_tile(aes(fill =  normalized ))+
  xlab("Column")+
  #ylab("Row")
  scale_y_discrete(name="Row", limits = rev(levels(as.factor(df$Row))))+
  #scale_y_reverse (name="Row", limits = levels(as.factor(df$Row)))
  geom_label(data = zprime ,aes(label = paste( "zprime =", zprime[1,1]) , x = 22, y = 1))

  
