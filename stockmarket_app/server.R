#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Load required libraries
library(shiny)
library(ggplot2)
library(tidyquant)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$stockPlot <- renderPlot({
        
        # Obtain ticker data based on stock ticker input        
        stck_ticker<-tq_get(input$stock_ticker,from=input$from_date,to=input$to_date)
        
        # If the ticker data is not null i.e. valid ticker symbol
        if(length(stck_ticker)!=0){
            
            # Draw a plot based on adjusted price of the ticker (adjusted price will be default)
            stck_plot<-stck_ticker%>%
                ggplot(aes(x=stck_ticker$date,y=stck_ticker$adjusted))+
                geom_line(color="red") +
                ggtitle(paste("Stock Performance Of Ticker: ",input$stock_ticker)) +
                theme(plot.title = element_text(hjust=0.5))+
                xlab("Date") +
                ylab("Price($)")
            
            # Add line for opening price for the ticker if option selected.
            if(input$Open==TRUE){
                stck_plot<-stck_plot+geom_line(aes(y=stck_ticker$open),color="blue")
            }
            
            # Add line for high price for the ticker if option selected.
            if(input$High==TRUE){
                stck_plot<-stck_plot+geom_line(aes(y=stck_ticker$high),color="green")
            }
            
            # Add line for low price for the ticker if option selected.
            if(input$Low==TRUE){
                stck_plot<-stck_plot+geom_line(aes(y=stck_ticker$low),color="yellow")
            }
            
            # Add line for close price for the ticker if option selected.
            if(input$Close==TRUE){
                stck_plot<-stck_plot+geom_line(aes(y=stck_ticker$close),color="brown")
            }
            
            stck_plot
        }
    })
})
