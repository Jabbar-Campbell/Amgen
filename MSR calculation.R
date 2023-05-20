
FILE<-"//chowder/Labdata/Neuroscience/Jabbar/384 to 1536 comparision of ic50s day2 curated.csv"
#FILE<-"C:/Users/jabbarc/Desktop/New folder/384 to 1536 comparision of ic50s.csv"

df<-read.csv(file = FILE, header = TRUE, stringsAsFactors = FALSE)
colnames(df)

colnames(df)[10]<- "ratio"
df
library(dplyr)
library(tidyverse)
class(df$X384.AC50..M.)




#columns must be numeric fo manipulation
df$X384.AC50..M.<-  as.numeric(df$X384.AC50..M.)  
df$X1536.AC50..M.<- as.numeric(df$X1536.AC50..M.)


#create new columns by calculating of prior columns
df<-mutate(df, log_potency_difference = abs(X384.AC50..M.- X1536.AC50..M.))

#df<-mutate(df, log_potency_difference_graph = (X384.AC50..M.- X1536.AC50..M.))




#average log potency within assays
df<-df %>% 
  group_by(.,assay) %>% 
  mutate(., avg_log_potency_diff = mean(log_potency_difference,na.rm = TRUE)) %>% 

#standard deviation of log potency
   mutate(., Std_log_potency_diff = sd(log_potency_difference,na.rm = TRUE)) %>% 

#mean ratio
   mutate(., Mean_Ratio= 10^avg_log_potency_diff) %>% 

#Ratio limits plus and minus
   mutate(.,  Ratio_Limits=10^avg_log_potency_diff+(2*(Std_log_potency_diff/sqrt(length(df))))) %>% 

#Minimum significatn ratio
  mutate (.,  Min_Significant_ratio= 10^2*Std_log_potency_diff) %>% 
 
  
  #limits of agreement plus and minus
  mutate(., Limits_of_agreement= 10^(avg_log_potency_diff+(2*Std_log_potency_diff) )    ) %>% 

 #Geometric mean
  mutate(., Geometric_Mean = sqrt(X384.AC50..M.*X1536.AC50..M.))

       
library(ggplot2)
       
 class(df$Geometric_Mean)      

  set.seed(1)
  ggplot(df,aes(x= scale(Geometric_Mean), y=scale (ratio )  ))+
    geom_point(aes(colour = as.character(df$Compound.ID),  size = 3, shape = df$assay ))+
    #geom_point(aes(colour = "green",  size = 3 ))+
    #geom_text(aes(label=Compound.ID,hjust=1,vjust=1))+
    geom_hline(yintercept= df$Limits_of_agreement[1], linetype ="dashed", color = "red", size = 1)+
    geom_hline(yintercept= -df$Limits_of_agreement[1], linetype ="dashed", color = "red", size = 1)+
    geom_hline(yintercept= 0, size = .1)+
    geom_hline(yintercept= df$Ratio_Limits[1], linetype ="twodash", color = "springgreen1", size = 1)+
    geom_hline(yintercept= -df$Ratio_Limits[1], linetype ="twodash", color = "springgreen1", size = 1)+
    facet_wrap(facets = vars(assay) , nrow = 2, ncol = 2, scales = "free")
   #annotate("label",x = 1,y = 1, label = levels(as.factor(df$Min_Significant_ratio)))
   #annotate("label",x = 1,y = 2, label = levels(as.factor(df$Limits_of_agreement)))
    
   
 
 as.character(levels(as.factor(df$Min_Significant_ratio)))


install.packages("plotly")
library(plotly)
plotly(df2)
df$Compound.ID
class(x)
