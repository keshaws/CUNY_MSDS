#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
if (!require('tidyverse')) install.packages('tidyverse')
if (!require('googleVis')) install.packages('googleVis')
# load libraries and get data
source('global.R')

# Define UI
ui <- fluidPage(
    
    # App title ----
    h2
    (" CDC Wonder - Exploring the Underlying Cause of Death (https://wonder.cdc.gov/ucd-icd10.html)"),
    
    h4("Keshaw Sahay, DATA 608"),
    
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            
            conditionalPanel(
                'input.dataset === "Question-1"',
                selectInput('cause', 'ICD Chapter (Cause)', q1.sub$cause, selected = ""),
                p("Compare Crude Mortality Rates: Select Cause of Death (ICD Chapter)")
            ),
            
            conditionalPanel(
                'input.dataset === "Question-2"',
                selectInput('cause2', 'ICD Chapter (Cause)', raw.data$ICD.Chapter, selected = ""),
                selectInput('state', 'State', raw.data$State, selected = ""),
                p("Compare State crude mortality rates Vs National Avg : Selcect Cause of Death (ICD Chapter) and State")
            )
        ),
        
        # Main panel for displaying outputs ----    
        mainPanel(
            tabsetPanel(
                id = 'dataset',
                
                tabPanel("Question-1",
                         br(),
                         p("As a researcher, you frequently compare mortality rates from particular causes across different States. You need a visualization that will let you see (for 2010 only) the crude mortality rate, across all States, from one cause (for example, Neoplasms, which are effectively cancers). Create a visualization that allows you to rank States by crude mortality for each cause of death."),
                         htmlOutput('plot1')),
                
                tabPanel("Question-2",
                         br(),
                         p("Often you are asked whether particular States are improving their mortality rates (per cause) faster than, or slower than, the national average. Create a visualization that lets your clients see this for themselves for one cause of death at the time. Keep in mind that the national average should be weighted by the national population."),
                         htmlOutput('plot2'))
            )
        )
    )
    
)


# Define server logic
server <- function(input, output, session) {
    
    # create data for Q1 ---
    q1.data <- reactive({
        q1.sub[q1.sub$cause == input$cause, ]
    })
    
    # create data for Q2 ---
    q2.data <- reactive({
        df <- q2.sub %>%
            filter(cause == input$cause2 & state == input$state) %>%
            select(Year, State.Avg, Nat.Avg)
    })
    
    # create plot 1 ---   
    output$plot1 <- renderGvis({
        q1.title <- paste0("Cause: ", input$cause)
        gvisBarChart(q1.data(), 
                     options=list(title=q1.title, 
                                  legend="none",
                                  hAxis="{title:'Crude Rate'}",
                                  vAxis="{title:'State', fontSize:1, showTextEvery:1, gridlines:50}",
                                  height = 1000)
        ) 
    })
    
    # create plot 2 ---
    output$plot2 <- renderGvis({
        q2.title <- paste0("State: ", input$state, " | Cause: ", input$cause2)
        gvisAreaChart(q2.data(), 
                      options=list(title=q2.title, hAxis="{format:'####'}"))
    })
    
}


shinyApp(ui, server)