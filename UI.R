library(shiny)
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



#Inquire about process of paper review....pkdm paper support not collaboration. send her the draft ....plan to have in next wednesday.
#this is delicate violetta can but doesnt need to have it ready by then but should





####SHOULD BE SET TO THE server.r AND ui.r FOLDER LOCATION
#getwd()
setwd("H:/SPARK")

 
###RUN THE SHINY APP. THIS LOOKS IN THE HOME DIRECTORY BY DEFAULT WHICH IS WHERE THE SERVER SHOULD BE SAVED TO. OTHERWISE HOME DIRECTORY MUST BE SET




 


 