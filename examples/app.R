source("D:/bin/shiny-ergo/R/config.R")
df <- read.csv("D:/bin/shiny-ergo/data/blockInfo-dev.csv")
df <- df[ -c(1,7:13) ]
View(df)
dfmod <- NULL
todays_date <- Sys.Date()
# theme = bslib::bs_theme(bootswatch = "darkly")


# Define UI for data upload app ----
ui <- fluidPage(
# theme = bslib::bs_theme(bootswatch = "darkly"),
  titlePanel("Ergo"),

  navlistPanel(
    "Ergo Utilities",
    tabPanel("Dashboard",
             h3("Ergo Dashboard")),
    tabPanel("Address Balance", 
             fluidRow(column(height = 24, width = 12,
             addressBalanceApp()))),
    tabPanel("Token Lookup",
             h3("Token Lookup")),
    "Ergo Forecasting",
    tabPanel("Ergo Price, Historical",
             h3("This is the second panel")),
    tabPanel("Ergo Price, Monte Carlo",
             h3("Monte Carlo")),
    tabPanel("Ergo Price, Threshold",
             h3("Ergo Price, Threshold")),
    "Blockchain Analytics",
    tabPanel("Blocks",
             fluidRow(column(height = 24, width = 12,
             blockInfoApp()))),
    tabPanel("Token Lookup",
             h3("Token Lookup")),
    tabPanel("Token Lookup",
             h3("Token Lookup")),
    tabPanel("Token Lookup",
             h3("Token Lookup")),
    tabPanel("Token Lookup",
             h3("Token Lookup")),
    tabPanel("Token Lookup",
             h3("Token Lookup")),
    tabPanel("Token Lookup",
             h3("Token Lookup")),
    tabPanel("Token Lookup",
             h3("Token Lookup")),
    tabPanel("Token Lookup",
             h3("Token Lookup")),
    tabPanel("Token Lookup",
             h3("Token Lookup"))
             
    ))
  
server <- function(input, output, session) {
  thematic::thematic_shiny()
  xaxis <- eventReactive(input$submit, {
    input$xaxis
  })
  yaxis <- eventReactive(input$submit, {
    input$yaxis
  })
  
  output$plot <- renderPlot({
    ggplot() +
      geom_point(data = df, aes(.data[[input$xaxis]], .data[[input$yaxis]]))
  }, res = 96)
}
  
# Create Shiny app ----
shinyApp(ui, server)
