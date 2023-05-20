###SPARK

source('library/r_general/ubiquity_install_packages.r')

install.packages("devtools") #package of development tools
install.packages("shiny")#for web interfacing
install.packages("deSolve")#for solve ordinary or systems of equations
install.packages("ggplot2")#
install.packages("optimx")#accepts functions and looks for min and max parameters
install.packages("rstudioapi")#access R and return relevant syntax
install.packages("rhandsontable")#for creating a shiny excel object for input
install.packages("gdata")#allows reading in excel across sheets
install.packages("foreach")#speeds up computing
install.packages("doRNG")#speeds up computing
install.packages("doParallel")#speeds up computing



source('library/r_general/ubiquity.r')