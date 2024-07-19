library(tidyverse)
library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Predicting Iris Species"),
  sidebarPanel(
    h3('Enter Explanatory values'),
    numericInput('id1', 'Sepal Length', 0, min = 0, max = 10),
    numericInput('id2', 'Sepal Width', 0, min = 0, max = 10),
    numericInput('id3', 'Petal Length', 0, min = 0, max = 10),
    numericInput('id4', 'Petal Width', 0, min = 0, max = 10),
    submitButton('Submit')
  ),
  mainPanel(
    h3('Results of prediction'),
    h4('You entered sepal length as:'),
    verbatimTextOutput("oid1"),
    h4('You entered sepal width as:'),
    verbatimTextOutput("oid2"),
    h4('You entered petal length as:'),
    verbatimTextOutput("oid3"),
    h4('You entered petal width as:'),
    verbatimTextOutput("oid4"),
    h4('The model predicted '),
    verbatimTextOutput("prediction")
  )
))


