#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
timezones <- read.csv("timezones2.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
      observe({
            x <- input$country
            
            # Can also set the label and select items
            updateSelectInput(session, "timezone",
                              choices = timezones$Time_Zone[timezones$State==x],
                              selected = timezones$Time_Zone[timezones$State==x][1]
            )
      })
      
      output$distPlot <- renderPlot({
            i <- c(input$name, input$gender, input$birthdate, 
                   as.character(input$birthtime), input$country, input$timezone)
#             i<-1:6
            b<-c(1:12)
            for (f in 1:6) {
                  set.seed(sum(match(unlist((strsplit(as.character(i[f]),""))),c(letters,LETTERS,0:9), nomatch=rnorm(1))))
                  b[(f*2-1):(f*2)] <- rnorm(2)
            }
            x <- 1:90

            m<-matrix(nrow=360, ncol=3)
            m<-data.frame(m)
            names(m)<- c("Love", "Luck", "Work")
            for (f in 1:3) {
                  m[1:90,f]    <- x*b[4*(f-1)+1]
                  m[91:180,f]  <- x*b[4*(f-1)+2]+m[90,f]
                  m[181:270,f] <- x*b[4*(f-1)+3]+m[180,f]
                  m[271:360,f] <- x*b[4*(f-1)+4]+m[270,f]
            }
            tsm<-ts(m,Sys.Date(),as.Date(Sys.Date()+360-1))
            plot(tsm, main="How you will fare in Work, Love and Luck during the next year",
                 xaxt='n')
            axis(1, at=axTicks(1), labels=as.Date(axTicks(1), origin="1970-01-01"))
#            axis.Date(side=1,at=axTicks(1),format='%Y-%m',labels=F,las=3) #ADD X-AXIS LABELS WITH "YEAR-MONTH" FORMAT
#            axis.Date(side=1,at=axTicks(1))
            
            
            
            
            
  })
  
})
