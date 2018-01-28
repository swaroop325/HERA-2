library(shiny)
library(datasets)
library(shinythemes)
ui <- shinyUI(fluidPage(theme = shinytheme("cyborg"),
titlePanel("HERA 2.0"),
 tabsetPanel(
            tabPanel("Pedophilia Analysis",
             titlePanel("Upload The Conversation Files"),
             sidebarLayout(
               sidebarPanel(
                 fileInput('file1', 'Choose CSV/Text File',
                           accept=c('text/csv', 
                                    'text/comma-separated-values,text/plain', 
                                    '.csv/.txt')),
               fileInput('file2', 'Choose CSV/Text File',
                         accept=c('text/csv', 
                                  'text/comma-separated-values,text/plain', 
                                  '.csv/.txt'))),
            mainPanel(
                 plotOutput('MyPlot')
               )
             )
    )
    
  )
)
)