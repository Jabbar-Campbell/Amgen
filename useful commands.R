Libraries
devtools::
tidyr::
dplyr::
tidyverse::
gdata::
xlsx::
ggplot2::viridis::gridExtra::
cowplot::
gtable::
grid::
gridExtra::
plotly::
networkd3::
igraph::
ggmap::
quantmod:: 
caret::
gdata::
viridis::
RANN::
readxl::
drc:: 
readxl::
                                                                Installation   
install_github( reponsci/plotly) #link to package  
install.packages("package", destdir = ) ###installs package in  a location ####
install_course_zip("C:/Users/jabbarc/Desktop/plotrix_3.6-1.zip",multi=TRUE)
install.packages("installr")
installr::updateR() 
                              




                                                                NAVIGATION
getwd()###what directory your currently in####
dir.create("testdir")###create a directory called tesdir in the current working directory####
setwd("path") ###switches your working directory to a specific location###
list.files() ####List all the files in your working directory####
ls() ###lists the variable in your workspace####
list.files() ###listing all the files in the current directory.####





                                                                 CHRONOLOGICAL DATA
Sys.Date()
Sys.time() #Give current time
Sys.time() >t1 #where t1 has a time value asks if the systime is ahead or not not
Sys.time() >t1 #where t1 has a time stored what is the difference between the 2 timestamp()
difftime()#compares two time points and sets the  units for what systime returns
weekdays() #Give weekday on a date
months() #Give Month on a date
quarters() #Give quarter on a date
as.POSIXct()#elapsed in seconds post 1970 single integer
as.POSIXlt() #elapsed in days post 1970 as a list of info sec mminutes hours days mDAY month year weekday any of which can be extraxted
strptime(t3, "%B %d, %Y %H:%M") ##converts a character into date and time using a format t3 could be  "October 17, 1986 08:24"in a posixlt format
seq.Date()#like seq along except for dates you can count in intervals even seconds
p<-as.POSIXlt(Sys.time())#ALLOWS YOU TO GET AT THE SECONDS MIN HOURS DAYS MONTHER YEARS 
unclass(p)




                                                                   READING IN DATA
ITS ALWAYS BETTER TO GET INFORMATION FROM THE ORIGINAL FILE NAME
nchar() ###gives you the number of characters in a string
readClipboard()###reads in the clipboard as a list
read.xls ("myfile.xlsx",sheet = 1 , gather), sheet = 1, header = TRUE, skip = 3) ###reads in a xlsx file gdata package 
read.csv("path.csv",col.names=c("X","Y","Z")) ###read in DATA  make column names x y and Z####
read.table ("path.csv", header=TRUE, skip  = 5, col.names=c("X","Y","Z"))#read file keep header, skip first 5 lines  and reassigns columns names 
readClipboard()
list.files(path = "H:/EPHYS DATA/Qube/H1.7 vs PX/qube exports/")#list the files in a certain location
length(FILES)
assign()###assign a variable name a dataframe or list of dataframes if need be
rbind_all()##binds a list of dataframes into one
starts_with()##give me something that start with a pattern
getSymbol()#retrieves stock or portfolio information from yahoo 
ROC()#gives returns on stock or portfolio information
periodReturn()#gets returns on stock or portfolio for specified period
read_excel()



                                                                    LOOPING DATA 
case_when()##allows you to vectorize if else statments
list.files(path = "directoty you want to read from")
df<-lapply(FILES,  function(FILES){
  df<-read.table(file = FILES ,skip = 1 , nrows = 17 , sep = ","  )
  df[,26]<-NULL
  colnames(df)<-c("row",c(1:24))
  df$plate<-substr(FILES, 51,56 )
  df$date<-substr(FILES, 42,49)
   df
} 
)

for (i in length(i)){
    df[[i]][,26]<-plate[i]
}
 

  
  
  
                                                                    SAVING & WRITING DATA
writeClipboard(format = 1,str = z)
save.image(file = "H:/EPHYS DATA/Qube/H1.6/Nav 1.6_Poster_Figures.RData")
load(file = "H:/EPHYS DATA/Qube/H1.6/Nav 1.6_Poster_Figures.RData")
wb<-createWorkbook()
wb_sht1<-createSheet(wb,sheetName= "1030")
write.xlsx(df, file="newpath" ,sheetName = "sheetname",row.names = TRUE)
####Creates a new excel file and writes to it.
####ANOTHER WAY IS TO CREATE A WORKBOOK AS WELL AS A WORKSHEET ONCE THIS IS DONE YOU ARE FREE TO ADD MULTIPLE DATAFRAMES AND PLACE IT WHEREVER YOU WANT BE SURE TO SAVE IT AFTERWARDS such as....
addDataFrame(thirty6 ,wb_sht1,col.names = TRUE,row.names =TRUE, startRow = 3,startColumn = 1)
saveWorkbook(wb,file = "FILENAME.xls")


dpois(x, lambda, log = FALSE)#Density, distribution, quantile function and random generation  with rate lambda
ppois(q, lambda, lower.tail = TRUE, log.p = FALSE)
qpois(p, lambda, lower.tail = TRUE, log.p = FALSE)
rpois(n, lambda)
deriv()



                                                                    SUMMARIZING DATA
mydata[mydata$A_Pval<0.05 & mydata$B_Pval<0.05 & mydata$C_Pval<0.05,]####takes data based on a value in a certain column
table(x) ### this can give a count of value occurances in a given table)
range() ####give max and min###
Var()#looks at the variance or distance from the mean....this will be important                 
sqrt() #taking the square root  of variance isn the standard deviation
sd() #standard deviation of data
mean()###take an aeverage this can be trimed using trim =
rename() ###takes a data frame and renames an old column with a new name      
range()###give s range or max and min
class() ###what kind of DATA you dealing with###
dim()##returns dimensions##
names()##returns a vector of column headings##
head()##returns first six rows of a dataframe####
summary()##summarizes a data  giving average,median,max, also divides data into thirds #####
str()##also summarizes a dataframe####
jitter()###looks at data values that occur frequently####
x$A1= c("A1") ## adds a column called A1 to x and all values will be A1###
anti_join()###takes 2 tables and joins them together
summarise()####allows you to make your own summaryies using column specifics
nrow()###gives the number of rows
ncol()###gives the number of columns
scale()##converts the unit of measure of numeric data to a standard distribution
dist()##computes the distance matrix on a row by row basis. required for clustier analysis


                                                                  COMPARING DATA 
writeClipboard(intersect(x,new)) ###writes the instersection of new and x to clipboard of excel####
unique()###what doesnt repeat itself
z<-x[x %in%y]
which()###this is slick one gives a location value for whats true in the query???????
setdiff(list1,list2)####contents of list2 not in list1###takes list1 compares it to list2 and gives you overflow
setdiff(list2,list1)####contents of list1 not in list2###takes list2 compares it to list1 and gives you overflow
intersect(list1,list2)####which elements exist on both lists
union(list1,list2)####binds the lists together stripping out any duplicates
dist()#makes a distance matrix for all rows




                                                                  FORMATTING DATA
gather(df2, key = parameter, value = value , c(10,13,20,21)) 
gsub()#substitute a pattern for something else
for() for loop
lapply()#apply to a list
do.call()#takes a function as input and splatters its other arguments to the function. 
seq()#sequence 
rep()#repeat
t()#transpose
cut() #arranges data into bins
substr()###substring
separate()#separate a column into several
sort()###sorts according to a column
%in% ###allows for filter and select to work on several values instead of just one
filter(Sweep.Number%in% c(3,6,9,12))
subset(liquid_period == 1 & Sweep.Number == 12 | liquid_period %in% c(2,3,4) & Sweep.Number %in% c(3,6,9,12))
setNames(df, c("title1","title2","title3"))###  reassigns the vector of column headings to 
na.rm=TRUE ####removes NA's######
separate()#separates one column into many
apply(m, 2, function(x) length(x[x<0])) #for matrix m apply a function that on colmn basis gives be the nuber of postive numbers
sapply(strsplit(as.character(Data.Period), ":")  ###where I would call columnn[,] you use sapply on each element of a list 
NORMAL = d1 %>%###make a new data frame taking an old dataframe and do the following
       gsub("#1","",x) ##swap out characters
       d1$column<-substr(d1$Well, 2, 3)####MAKE NEW COLUMNS BASED ON A SUBSTRING OF ANOTHER
       df<-do.call("rbind",x)
 unlist() #takes something and make a single line out the data
DF %>%  group_by() %>%   nest() #group and nest the data by
 
 
 head(by_treatment)
 
 

 
 
 
 

       ####you dont have to set specific coordinates, you can transform subsets and add new columns that way.
df2<-transform(subset(df1, valuesinnamedcolumncontain == 'Postcompound'  ), role =  "numerator"),
ddply(normalized, .(row,column), summarize, 
      Result = value[V18 == "Postcompound"] / value[V18 == "Precompound"])





                                                        DPLYR COMMANDS
filter()###works like subset except you use commas inbetween criteria    
cut() #arranges data into bins
tbl_df(mydf) ## reformats and othrwise large datframe  into a table format##
select(df,one_of("list","of", "names" ))
select(), arrange(), mutate(), and summarize()
select()## select certain columns
arrange()###arrange columns
mutate()###change the dataframe adding a column based on computations
summarize()###summarize the dataframe can be based on grouping
group_by(Well, Label, Data_Block) %>%####groups them so that in the summary funtion it uses these groups
summarize(NORM = min(value) )##you can add computations to summarize
NORMAL2 = d1 %>% ####make another dataframe from and old one
select(Well, Label, Run = value)####then select other columns###
merge(d1, NORMAL, by = c("Well", "Label", "Data_Block"), all.x = TRUE)### merge data by single or multiple columns                 
gather()#gathers information ideally on numeric values
##filter by a column called datablock but only select certain values along with label where the values or activation or inactivation
filter(Data_Block %in% c(1,3,5,7), Label %in% c("Activation","InActivation")) %>%
filter(Sweep == 1, Label == "PX", Data_Block == 2) %>% 
  
 
######or mutate based on a condition making a new column called "Norm" if label column == "Activation" do X otherwise do y
mutate(d1, Norm = ifelse(Label == "Activation", 100-((1-(value/NORM))*100) , (1-(value/NORM))*100 ))
mutate(df,newcolumn =  TOP/DF^column-1)
TOP/DF^steps-1
##ddply splits the dataframe into many pieces as you like and perform a calculation on each in this case divide one group by anotheR                                            
ddply(normalized, .(row,column), summarize, 
      Result = value[V18 == "Postcompound"] / value[V18 == "Precompound"])   





                                                      SUBSETTING DATA

x[1,3:5] ## subset of x (1st and third thru fifth elements)#### 
df[column==x & another column == y,] ####subset on logic!!!!!!
! ####flips logic###
y <- x[!is.na(x)] ###create a vector called y that contains all of the non-NA values from x
y[y > 0]
na.rm = FALSE ###a logical value indicating whether NA values should be stripped####
!duplicated(myd) ####give me everything thats not duplicated 
subset( Data_Block == 1 & Sweep1 == 6  | Data_Block == 2 & Sweep1 == 12 |Data_Block == 3 & Sweep1 == 18)##subset a dataframe with and/or 
# subset by take everything except whats in vector -c(a,b,c,d,)), you can nest selects inside of subsets but thats confusing
subset(df2[df2$Plate==i & df2$liquid_period== 2 & df2$Sweep.Number ==3,],    
             select = -c(Experiment, Row, liquid_period, Sweep.Number, Plate)  ) 
###subset rows based on a string value
d2 = d1 %>% 
  filter(grepl("\\.2\\.1",Sweep))   



                                                      STRIPPING OUT NOT APPLICABLE VALUES
#TEST FOR TRUE TARGET %IN%  "QUERY"
a$dose %in% NA

#NEST INSIDE WHICH TO RETURN WHERE THE TRUE OR FALSES ARE
which(a$dose %in% NA, arr.ind = TRUE)


#COUNT ALL IN A COLUMN
#TEST FOR TRUE AND RETURN WHERE
#IF COUNT IS EQUAL TO NUMBER OF TRUE REMOVE THAT COLUMN











                                                        MAPS
library(ggmap)
map.tokyo <- get_map("Tokyo")##from the ggmap library retrieves maps from google                          
webehere<-geocode("300 binney street")###give me the coordinates on an address
xmarksthespot<-get_map(webehere, zoom = 17, maptype = "satellite")###use those coordinates to retrieve the map tile
ggmap(xmarksthespot)###display the map
ggmap(map.tokyo)###allows you to use that opbect in ggplot  
df.tokyo_locations <- tibble(location = c("Ueno, Tokyo, Japan"))# CREATE DATA FRAME of locations
geo.tokyo_locations <- geocode(df.tokyo_locations$location)## retrieves numbers of the locations in tibble
df.tokyo_locations <- cbind(df.tokyo_locations, geo.tokyo_locations)###combines those numbers back to the tibble
get_map("Tokyo", zoom = 12) %>% ggmap() +# USE WITH GGPLOT
  geom_point(data = df.tokyo_locations, aes(x = lon, y = lat), color = 'red', size = 3)##lays poinst at the location column we just made
graph_from_data_frame()#produces an network graph from igraph library





                                                            PLOTTING DATA
                                                             
                                                             
                                                            
library(ggplot2)                                                        
abline(model) ###adds the line defined as model####           
model<-lm(response variable~ Indepedent Variable, Data) ####plots a linear regression line 
coef() #will give you the coefficients of model. there should be 2 for lm, y intercept and slope for every data point
hclust() ##takes distribution data and makes a dendrogram   
tkplot()#an interactive version of plot  

to build a graph in layers....
aes() #aesthetics for each geom, can also be inherited from call to ggplot
 colour # fixs colour for geom point or even the bottom level of  ggplot
 alpha # transparency argument for geom point
 fill # fills bars by a grouping 
 ggplot() ##does everything qplot does but you can add layer_scales each geom takes it unique aesthetics 
+geom_boxplot(varwidth= TRUE)#  gives idea of population size in addition 
+geom_density()
+geom_density_2d()#gives you a contour like in a geographic map
+geom_label() # adds a label and places it according to x and y
+geom_point() ##adds points to the ggplot thus plus sign can go above and omit the g
+geom_raster()##makes a heat map
+geom_tile() ###in the ggplot change x and y to factors or levels in order to manipulate the scale
+geom_point(color= "blue") ## you can set the color to all points or color
+geom_point(aes(color = variable))  #aes funciton allows colors by factors or levels of a variable.. .   
+geom_line()#add s a trend lline  
+geom_smooth()##give a shaded area for regression analysis
+geom_smooth( size,linetype,method, se)#add s a smooth trend line with many arguments  
+facet_grid(x~3y)##facets the data by categories or factors of a column in x~., .~y or both
+facet_wrap()#facets the data and wraps it
+scale_fill_distiller ###new color palettes can be used
+geom_vline(aes(xintercept=-6))+
+geom_hline(aes(yintercept=0.5)
+geom_text(data = , aes(x=.5,y=-9, label=MEAN[column==23 & key == "p1.baseline" & V18 == "Postcompound" ])) 
+coord_cartesian()###lops of the scale yet includes the  outliers  
+xlab() #xlabel
+labs() #y label
+ggtitle()#title
+theme_bw(base_family = "Times") #allows for theme and font type
+scale_y_continuous(limits=c(-100,200))
+scale_x_discrete(breaks = NULL)+ #makes the scale descrete and great rid of vertical grid lines
+scale_x_continuous(breaks = seq(1,100 by=1))+ # makes a continous scale and sets the break points
+scale_x_log10()+ #sets the scale to logrithemic althought it better to log the data
+geom_errorbar##adds error bars 
+geom_rug##i think for a RASTER like plot
scale_fill_viridis##helps you adopt a new color scale
mean_sdl###from the Hmisc library returns the mean upper and lower limits inside of ggplot  
stat_summary(fun.data = y ymin ymax , fun.args= )###for the statical layer of ggplot fun.data can accept mead_sdl
stat_function( )##compute y values based on x in accordance with given function
stat_qq()#perform calculations for a quantile-quantile plot or 1st and third quartile
cowplot.mpg<-plot_grid(plot.mpg, plot.diamonds, labels = c("A", "B"), align = "h")
do() #performs computations on a data frame and compliments working with models.
coef()#extracts model coefficients from objects returned by modeling functions. 
drm()#fits dose reponse models which can be plotted and returns a  drc object
predict()###creates new points based on model of type DRC
                                    



                                                     
                                                                NETWORK GRAPH FROM A DISTANCE MATRIX 

library(igraph)
scale()##converts the unit of measure of numeric data to a standard distribution
dist()##computes the distance matrix on a row by row basis. required for clustier analysis
graph(edges = c("alice","sam","sam","david",  "david", "alice","frank","David"), directed=FALSE)# makes a undirected graph where several names are connected
g <- graph.adjacency(x)#makes and igraph object out of a distance matrix
get.edgelist(g)#returns the edgelist of the igrpah object
graph.data.frame()#creates and igraph object
E(igraphobject)$color[]<-"grey"#turns all edges to grey or even a subset if desired
V(igraphobject)$red[]<-"red"#turns a vertice/node red. also subsettable
tkplot(layout= )#plots the igraph with various layouts
clusters(igraph)#returns nodes or vertices that are strongly connected
plot(igraph, vertex.size = degree, layout = layout.random)#plot igraph making vertices vary by betweeness or degree. 




ANOMOLY DETECTION 
#Download stats on accessing wikipedia webpage "fifa" 
fifa_data_wikipedia = wp_trend("fifa", from="2013-03-18", lang = "en")

#Apply anomaly detection and plot the results
anomalies = AnomalyDetectionTs(fifa_data_wikipedia, direction="pos", plot=TRUE)
anomalies$plot


                                                             MACHINE LEARNING
                                  Caret streamlines the process for creating predictive models.
# The package contains tools for:
#  data splitting
#  pre-processing
#  feature selection
#  model tuning using resampling
#  variable importance estimation
#  as well as other functionality
#Dont be afraid to get rid of useles columns such as NAME and or imput DATA aka fill in the blanks
#always to add new columns like which have missing data Y/N. 
#sometimes new columns can be an aggregation of others nunmerics making a new feature
#it probably uses distance matrices under the hood.
install.packages("caret")
library("caret")
table(df$column)#imputs data for the column using median or even "mode" or most common value 
xgboost()
createDataPartition(y = df$column,p = 0.8, list = FALSE)#create training set indices with 80% of data
preProcess()#process the data and fills in blank values depending on a method 
preProcess()#estimates new data based on old data
dummyVars()#creates dummy variables from categorical values
predict(model, newdata= )#creates prediction based on new data and the model given
createDataPartition(df$time,speed=1 , p= .7)#70 percent of data maintaining ratio of  time and speed
trainControl()#split data number of times and test how good the model is
makeCluster()
registerDosnow()
                                                    THINGS TO LEARN   
                                                    

                                                        PLOTLY
                                        https://www.youtube.com/watch?v=6ddBAUzIfmw                                                       


                         
                                            
                                        

                                                           MATRICES 

#|A| = determinant matrix A
####identy matrix = I basically like a one
####inverse of|A| = A^-1
#### AB does not equal BA
#####but A^-1 * A =  A * A^-1
#### A^-1*I=A
#### |A|.x=b then  A^-1(|A|).x =  (b)A^-1
###if you multipy something times its inverse....you get a sense of how similar it is....

matrix() #create a matrix                                      
C = matrix(runif(16), nrow=4, ncol=4)# generate a square matrix with 4 rows and 4 columns
solve(A) #matrix inverse 
matrix.inverse(x)#gives the inverse of a matrix     
A %*% B# matrix multiplication AB
A %^%n #raise a matric to a power of n 
t(B)# transpose of B
sum(diag(C))# trace of a square matrix
det(C)# determinant of a square matrix
Iden = diag(1, 5)# create an identity matrix of 5x5
svd(A)# singular value decomposition
eigen(C %*% t(C))# eigen-decomposition of a symmetric matrix
typeof(A)# what is the type of storage in A?
object.size(A)# how much space is allocated to A?
head(A, 4)# show first 4 rows of matrix A
tail(A, 4)# show last 4 rows of matrix A
summary(A)# descriptive statistics of variables in A
rowSums(A)# sum of elements by rows
colSums(A)# sum of elements by columns
margin.table(A, 1)# another way to get sum of elements by rows
margin.table(A, 2)# another way to get sum of elements by columns
rowMeans(A)# mean of elements by rows
colMeans(A)# mean of elements by columns
dim(A)# dimensions of matrix A
nrow(A)# number of rows
ncol(A)# number of columns
scale(A, scale=FALSE)# center matrix A
sweep(A, 2, colMeans(A))# alternatively
scale(A)# standardize matrix A (variables with mean=0 and var=1)
prop.table(A)# elements as fraction of the total sum
prop.table(A, 1)# elements as fraction of rows margin
prop.table(A, 2)# elements as fraction of columns margin                                                             
apply(A, 1, sum)# sum of elements by rows
apply(A, 2, sum)# sum of elements by columns
apply(A, 1, mean)# mean of elements by rows
apply(A, 2, mean)# means of elements by columns
apply(A, 1, max)# maximum by rows
apply(A, 2, min)# minimum by columns


# which position is the minimum by row
# (with your own function)
myfun <- function(x) {which(x == min(x))}
apply(A, 1, myfun)

# assign row and column names to matrix A
rownames(A) = 1:10
colnames(A) = paste("a", 1:3, sep="")

# similarly with matrix B and C
dimnames(B) = list(1:3, paste("b", 1:5, sep=""))
dimnames(C) = list(1:4, paste("c", 1:4, sep=""))













#MATRIX ALGEBRA IS GOOD FOR REGRESSOIN ANALYSIS BUT ITS ALSO GOOD FOR STORING VALUES OF A COMPUTATION SUCH AS EUCLDEAN AGPRITHEMS Next, we'll set up the for() loop. this is where the matrix comes in, we'll take the mean of each one of those vectors and store it. We will store the three values in the ith row of the mat1 matrix, filling in all three columns: 
mat1<-matrix(NA, nrow=1000, ncol=3)
for(i in 1:nrow(mat1)){
  vec1<-rpois(1,1)
  vec2<-rpois(10,1)
  vec3<-rpois(100,1)
  mat1[i,]<-c(mean(vec1), mean(vec2), mean(vec3))
  
}


#Each column of our matrix could also be graphed as a histogram to look at the distribution
par(mfrow=c(1,3))
hist(mat1[,1], main="n=1")
hist(mat1[,2], main="n=10")
hist(mat1[,3], main="n=100")





                                                              CLUSTER ANALYSIS 
                                                        Divisive and Agglomerative.
                                      https://www.r-bloggers.com/how-to-perform-hierarchical-clustering-using-r/

       

data <- car::Freedman#read in your data should be numeric although categorical is possible
data<-scale(data)#scale or convert the unit of measure to standard deviation
d <- dist(data, method = "euclidean")#make a  distance matrix  by using the 'dist' function on a per row to row basis
hc1 <- hclust(d, method = "complete" )# Hierarchical clustering using the above generated distance matrix
plot(hc1, cex = 0.6, hang = -1)# Plot the obtained dendrogram

              

                                                             BUILDING SHINY WEB APP
                                                      https://www.youtube.com/watch?v=KdvlxJaWWVQ
                                                             
 library(shiny)
 
                                                      
 shinyUI(
   dashboardPage( dashboardBody(),dashboardSidebar(),dashboardHeader())
 )                                                     
                                                      
                                                      
                                                                                                           
install.packages("shinydashboard")
library(shinydashboard)
##CREATION OF USERNINTERFACE
shinyUI(
  dashboardPage(
    dashboardHeader(),
    dashboardSidebar(
      menuItem("LINK1"),
      menuSubItem("link a"),
      menuItem("LINK2"),
      menuItem("LINK3"),
      
      sliderInput(inputId = "time", label = "hrs", min = 0, max = 400, value = 0),
      selectInput(inputId = "strand", label = "select strand", choices = levels(factor(df$strand)), selected = "both"),
      selectInput(inputId = "study", label = "which study", choices = levels(factor(df$study)), selected = "both"),
      selectInput(inputId = "dose", label = "what dose", choices = levels(factor(df$dose)), selected = "both")
    ),
    
    
    

  
  
    dashboardBody( 
      fluidPage(
        plotOutput("myplot1")##plotOutout talks to the server and pull fetches output ID mymplot1
        
      )
    ) 
    
 )
)


####NEEDS TO BE PLACE IN THE HOME DIRECTORY OTHERWISE USE RUNAPP TO POINT TO IT
#####SETUPS UP A SERVER THAT THE USER INTERFACE CAN WORK OFF OF. input will be set from the ui,R page. Myplot was a function that I wrote
shinyServer(function(input,output){
  output$myplot1<-renderPlot({myplot(strand_ = input$strand, dose_ = input$dose, study_ = input$study)})
  
})

