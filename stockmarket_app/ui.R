#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Load shiny library
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Stock Performance View"),
    
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            
            # Request stock ticker from the user
            textInput("stock_ticker","Stock Ticker",""),
            
            # Request from and to dates from the user
            dateInput("from_date","From:","2021-02-12"),
            dateInput("to_date","To:","2021-02-22"),  
            
            # Provide additional options to view various data about the ticker
            checkboxInput("Open","open",value=FALSE),
            checkboxInput("High","high",value=FALSE),
            checkboxInput("Low","low",value=FALSE),
            checkboxInput("Close","close",value=FALSE),
            
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("stockPlot")
        )
    )
))
