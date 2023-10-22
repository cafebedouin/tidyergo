source("./R/config.R")
source("./R/functions/addressBalance.R")

addressBalanceUI <- function(id) {
  fluidPage(
  theme = bslib::bs_theme(bootswatch = "darkly"),
  tagList(
    textInput(NS(id, "address"), "Address", value = "9ezksY42TovtzuLgLnBZwMj15PQtNEUjvSZxidNeMmK1g8kiGsT"),
    textInput(NS(id, "tokenId"), "tokenId", value = NULL),
    actionButton(NS(id, "submit"),"Submit"),
    #textOutput("textAddress"),
    #textOutput("textTokenId"),
    #tableOutput(NS(id, "table"))

))}

addressBalanceServer <- function(id) {
  moduleServer(id, function(input, output, session){
    
    address <- eventReactive(input$submit, { input$address })
    tokenId <- eventReactive(input$submit, { input$tokenId })
    df <- eventReactive(input$submit, { addressBalance(input$address, input$tokenId) })

    # eventReactive(input$submit, View(df))
    # output$textAddress <- reactive(address())
    #output$text$tokenId <- tokenId()
    #output$table <- renderDataTable({
    #  df()
    #})
  })
}

addressBalanceApp <- function() {
  ui <- fluidPage (
    addressBalanceUI("address1")
  )
  server <- function (input, output, session) {
    addressBalanceServer("address1")
  }
  shinyApp(ui, server)
}

