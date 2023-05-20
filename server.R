



#####SETUPS UP A SERVER THAT THE USER INTERFACE CAN WORK OFF OF. input will be set from the ui,R page. Myplot was a function that I wrote
shinyServer(function(input,output){
  output$myplot1<-renderPlot({myplot(strand_ = input$strand, dose_ = input$dose, study_ = input$study)}) ##assign myplot1 to list of possible outputs as a rendering of myplot function
  
})


