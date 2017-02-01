#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyTime)

timezones <- read.csv("timezones2.csv")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
      column(8, align="center", offset = 2,
             titlePanel("Predict Your Future!")),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
        sidebarPanel(
              p("Required info:"),
              textInput("name", "Enter your fake name:", 
                        value = "John Smith"),
              radioButtons("gender", "Gender", 
                           choices=c("Male", "Female", "Unknown"), "Male"),
              dateInput("birthdate","Date of Birth"),
              timeInput("birthtime", "Time of Birth", value = strptime("12:34:56", "%T")),
              selectInput("country", "Country of birth", sort(unique(timezones$State)), "Portugal"),
              selectInput("timezone", "Time Zone", "Select Country first","Select Country first")
              
        ),
        mainPanel(
              titlePanel("Evolution of your life parameters"),
              plotOutput("distPlot")
        )
  )
))
