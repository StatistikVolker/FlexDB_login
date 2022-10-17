library(shiny)
library(tidyverse)
library(shinyjs)

ui1 <- function(){
  fluidPage(
    shinyjs::useShinyjs(),
    #shinyjs::inlineCSS(appCSS),
    div(id = "login",
        wellPanel(textInput("userName", "Benutzer"),
                  passwordInput("passwd", "Passwort"),
                  br(),
                  actionButton("Login", "Log in"),
                  verbatimTextOutput("dataInfo")
        )
    ),
    tags$style(type="text/css", "#login {font-size:10px;   text-align: left;position:absolute;top: 40%;left: 50%;margin-top: -100px;margin-left: -150px;}")
  )}

ui2 <- function(){
  useShinyjs(debug = TRUE) 
  #shinyjs::inlineCSS(appCSS)
  uiOutput("Content")
}

ui <-   htmlOutput("page")

server = function(input, output, session) {
  
output$Content <- renderUI({
  HTML("<h1>Hello, world!</h1>")
})


Password_DF <- reactive({    
  data.frame(Nutzername = c("User1", "User2", "test"),
             Passwort = c("PW1", "PW2", "test")) %>%  
    mutate(Kennung = paste(Nutzername, Passwort, sep = "|"))  
  })

Logged <- FALSE
Security <- TRUE
USER <- reactiveValues(Logged = Logged)
SEC <- reactiveValues(Security = Security)
LOGINDATA <- reactiveValues(User = NULL)
observe({ 
  if (USER$Logged == FALSE) {
    if (!is.null(input$Login)) {
      if (input$Login > 0) {
        Username <- isolate(input$userName)
        Password <- isolate(input$passwd)
        if(paste(Username, Password, sep = "|") %in% 
           c(Password_DF()$Kennung) ) {
          USER$Logged <- TRUE
          LOGINDATA$User <- Username
        } else {SEC$Security <- FALSE}
      } 
    }
  }    
})

observe({
  if (USER$Logged == FALSE)  {
    output$page <- renderUI({ui1()})
  }
  if (USER$Logged == TRUE)  {
    output$page <- renderUI({ui2() })
  }   
})

observe({
  output$dataInfo <- renderText({
    if (SEC$Security) {""}
    else {"Login fehlgeschlagen!"}
  })
})

}

shinyApp(ui, server)
