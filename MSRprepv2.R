##THIS NEW MSR PREP WILL BE MUCH BETTER SINCE IT ACCEPTS ALL EXPORTS FROM SCREENER AND LOOKS FOR COLUMN NAMES BY NAME INSTEAD OF POSITION
#ALSO THERE WILL BE NO NEED FOR CSV CONVERSION. READXL PACKAGE CAN READ ACROSS SHEETS AND DOESNT NEED ANY SPECIAL DEPENDCIES

install.packages("readxl")
library(readxl)
library(dplyr)

#THIS IS THE SOURCE  LOCATION OF YOUR FILES ???????????????????????????????????????
SOURCE<-"C:/Users/jabbarc/Desktop/New folder 1536"


FILES<-list.files(path = SOURCE, full.names = TRUE)
df<-lapply(FILES,function(FILES){
   df<-read_excel(path = FILES, sheet = 2, col_names = TRUE, trim_ws = TRUE, skip = 1)
   df<-select(df,one_of("Compound ID", "Plate"  ,"Plate ID" ,"Well Row"  , "Well Column"  , "AC50 [M]" ))
   df$date<-substr(FILES,42,49)
   df$assay<-substr(FILES,51,58)
   df$format<-substr(FILES,60,63)
   df$day<-substr(FILES,77,81)
   df
})
df<-rbind_all(df)





##WHERE DO YOU WNAT TO WRITE THE FILES TOO??????????????????????????????
DESTINATION<-"C:/Users/jabbarc/Desktop/New folder 1536"
write.csv(df,file =  DESTINATION)
