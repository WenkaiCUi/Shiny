library(shiny)
library(dplyr)

ind<- read.csv('C:/Users/cui_w/Desktop/��̩����/Ʒ������/BrandData/BrandDataAIII.csv',fileEncoding='utf-8')
ind<-ind %>% select(Industry,Industry2,Industry3,Code,CompanyName) %>% distinct()

ui <- fluidPage(
  
  
  selectInput("selectI", label = "Primary Industry:",
              choices = unique(ind[,1]),selected='ʳƷ����'),
  
  # Selectize Inputs ---------------
  uiOutput("II"),
  uiOutput("III"),
  uiOutput('IV'),
  textOutput('text')
  
)

server <- function(input, output, session) {
  

  
  # II selectizeInput ----------------------
  output$II <- renderUI({
    req(input$selectI)
    selectInput('II_output','Secondary Industry:',unique(ind[ind[,1]==input$selectI,2]),selected='ʳƷ')
  })
  
  # II selectizeInput ----------------------
  output$III <- renderUI({
    req(input$selectI)
    selectInput('III_output','Tertiary Industry:',unique(ind[ind[,2]==input$II_output,3]),selected = '����Ʒ')
  })
  output$IV<- renderUI({
    req(input$selectI)
    row<- unique(ind[ind[,3]==input$III_output,c(4,5)])
    lst<- as.list(setNames(row[,1], row[,2])) 
    selectInput('Code','Company:',lst)
  })
  output$text<- renderText({
    input$Code
  })
  

  
}

shinyApp(ui = ui, server = server)