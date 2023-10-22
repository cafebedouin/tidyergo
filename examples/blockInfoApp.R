source("./R/functions/config.R")

blocks <- list("Day" = 720, "Week" = 5040, "Month" = 21600, "Q1" = 64800,
               "Q2" = 131400, "Q3" = 194400, "Y1" = 262800, "Y2" = 525600,
               "Y3" = 788400, "All" = nrow(df))

# print(blocks[["Day"]])

todays_date <- Sys.Date()
blockInfoUI <- function(id) {

  tagList(
    fluidPage(
      theme = bslib::bs_theme(bootswatch = "darkly"),
      fluidRow(column(width = 4,
                    selectInput(NS(id, "xaxis"), "X Axis", names(df), 
                                selected = "height", multiple = FALSE)),
              (column(width = 4,
                    selectInput(NS(id, "yaxis"), "Y Axis", names(df), 
                                selected = "totalTxsCount", multiple = FALSE))),
              (column(width = 4,
                    selectInput(NS(id, "blocks"), "Blocks", names(blocks),
                                selected = "Day", multiple = FALSE)))),
      fluidRow(column(width = 12,
                    actionButton(NS(id, "submit"),"Submit"))),

          tags$hr(),
          
          titlePanel(NS(id, "Plot")),
          plotOutput(NS(id, "plot")))
    )
}


blockInfoServer <- function(id) {
  moduleServer(id, function(input, output, session){
    thematic::thematic_shiny()
  
    xaxis <- eventReactive(input$submit, {
      input$xaxis
    })
      
    yaxis <- eventReactive(input$submit, {
      input$yaxis
    })
    
    blockLimit <- eventReactive(input$submit, {
      blockLimit <- input$blocks
      print(input$blocks)
    })
        
      # blockLimit <- blocks[input$blocks]
      # print(blockLimit)
      # blockLimit <- as.numeric(blocks[[nameLimit]])
      # print(blockLimit)
    
    df <- eventReactive(input$submit, {
      df <- read.csv("D:/bin/shiny-ergo/data/blockInfo-dev.csv", header = TRUE)
      df <- df[ -c(1,9,10,13) ]
      df <- tail(df, n = 720)
      View(df)
    })

    
    output$plot <- renderPlot({
      ggplot() +
        geom_point(data = df(), aes(.data[[input$xaxis]], .data[[input$yaxis]])) 
    }, res = 96)
    
  })
}

blockInfoApp <- function() {
  ui <- fluidPage (
    blockInfoUI("Blocks")
  )
  server <- function (input, output, session) {
    blockInfoServer("Blocks")
  }
  shinyApp(ui, server)
}