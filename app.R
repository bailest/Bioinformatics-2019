#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Dehydration Experiment"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         selectInput("yvalues",
                     "Y-axis choice:",
                    choices = c(
                      "Total percent body weight lost"="total.percent",
                      "Average percent body weight lost per day"="avg.percentdaily",
                      "Number of days survived"="days.survived"
                    ))
      ),
      
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("waterplot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$waterplot <- renderPlot({
      # generate bins based on input$bins from ui.R
      if (input$yvalues=="total.percent"){
       y=Water$total.percent
       ylabs="Total percent body weight lost"
     }
     
     else if (input$yvalues=="avgpercentdaily"){
       y=Water$total.avgpercentdaily
       ylabs="Average percent body weight lost per day"
     }
        
     else {
        y=Water$days.survived
        ylabs="Number of days survived"
     }
      # make ggplot object
      ggplot(Water,aes(factor(status),y))+
        geom_bar(stat="identity")+
        #stat_boxplot(geom="errorbar")
        #geom_bar(fill = c("purple"))+
        ###^Error: stat_count() must not be used with a y aesthetic.
        ylab(ylabs)+
        xlab("Reproductive Status")
       
        
   })
}
  


# Run the application 
shinyApp(ui = ui, server = server)

