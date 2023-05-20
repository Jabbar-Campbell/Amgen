
####with this library we can fit a presumably linear dilution to a MSD like four point logisitc
install.packages('drc')
install.packages("raster")
library(drc)


#get the Standard data in
Standard_50ul_18436<-read.csv(file = "clipboard", sep = "\t", header = FALSE)
x<-Standard_50ul_18436
x$log<-log10(Standard_50ul_18436$V2)


#make a model from the data and call it curve_50ul_18436

curve_50ul_18436<-drm(formula = Standard_50ul_18436, fct = LL.4())
curve_50ul_18436<-drm(formula = x, fct = LL.4())

#plot the curve just to see
plot(curve_50ul_18436, log = "x")


##read in experimental data
mydata_50ul_18436<-read.csv(file = "clipboard", sep = "\t", header = FALSE)



##adds a new column called interpolated  based on the prediction of new data applied to drc object/model
##in this case its and output from the drm() function  caled curve_50ul_18436
mydata_50ul_18436$interpolated<-predict(object = curve_50ul_18436, newdata = mydata_50ul_18436)




###separates the treatment colummn into ab a
library(dplyr)
library(tidyr)

mydata_50ul_18436<-separate(data = mydata_50ul_18436, col = 1, into = c("ab", "dose"), sep = 6)
mydata_50ul_18436$log_value<-log(mydata_50ul_18436$interpolated)


class(mydata_50ul_18436$interpolated)

#log x for standard curve








#fit to sigmoidal 4pl  as in prism       Y=Bottom + (Top-Bottom)/(1+10^((LogEC50-X)*HillSlope))

##read in your data
txt <- "| 0             | 0              |
    | 1.6366666667  | -12.2012787905 |
    | 3.2733333333  | -13.7833876716 |
    | 4.91          | -10.5943208589 |
    | 6.5466666667  | -1.3584575518  |
    | 8.1833333333  | 8.1590423167   |
    | 9.82          | 13.8827937482  |
    | 10.4746666667 | 18.4965880076  |
    | 11.4566666667 | 42.1205206106  |
    | 11.784        | 45.0528073182  |
    | 12.4386666667 | 76.8150755186  |
    | 13.0933333333 | 80.0883540997  |
    | 14.73         | 89.7784173678  |
    | 16.3666666667 | 98.8113459392  |
    | 19.64         | 104.104366506  |
    | 22.9133333333 | 105.9929585305 |
    | 26.1866666667 | 94.0070414695  |"



dat <- read.table(text=txt, sep="|")[,2:3]


names(dat) <- c("x", "y")

plot(dat$y ~ dat$x, pch = 19, xlab = "x", ylab = "y", main = "Monotone Splines with Varying df")


sigmoid() 
