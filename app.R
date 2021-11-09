#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#library(dplyr) 
#library(plyr)
#library(ggplot2)
library(shiny)
#library(readr)
#library(scales)
#library(tidyverse)


#pp_cultura <- read.csv("D:\\AGROCOMPUTAÇÃO\\R\\dados_radis\\pp_c_header.csv", sep=";", encoding = "UTF-8")

#pp_cultura.df <- data.frame(pp_cultura)

#names(pp_cultura.df)

#attach(pp_cultura.df)

#cultura_pa <- table(Nome.Pa, Cultura)

#cultura_pa.df <- data.frame(cultura_pa)


# Define UI for application that draws a histogram
ui <- fluidPage(    
    
    # Give the page a title
    titlePanel("Cultura por Projeto de Assentamento"),
    
    # Generate a row with a sidebar
    sidebarLayout(      
        
        # Define the sidebar with one input
        sidebarPanel(
            selectInput("Nome.pa", "Nome PA:", 
                        choices=cultura_pa.df$Nome.Pa),
            hr(),
            helpText("Selecione o assentamento.")
        ),
        
        # Create a spot for the barplot
        mainPanel(
            tabsetPanel(
            tabPanel ("Gráfico", plotOutput("culturasPlot")),
            tabPanel("Tabela", tableOutput("culturasTabela"))
            
        )
        )
    )
)



# Define server logic required to draw a histogram
server <- function(input, output) {
        
        # Fill in the spot we created for a plot
        output$culturasPlot <- renderPlot({
            
            
           cultura_pa.df %>%
                filter(Nome.Pa == input$Nome.pa)%>%
                filter(Freq >0)%>%
                ggplot()+
                aes(x=Cultura, weight = Freq)+
                labs(title = input$Nome.pa)+
                geom_bar(stat = "count", na.rm = TRUE) + 
                theme(axis.text.x = element_text( color="red", 
                                                 size=14, angle=85),
                      axis.text.y = element_text(face="bold", color="#993333", 
                                                 size=14))
           
        })
        
        
        output$culturasTabela <- renderTable({
            tabelaCultura <- subset (cultura_pa.df, cultura_pa.df$Nome.Pa == input$Nome.pa)
                       
            
        }) 
        
    }
    


# Run the application 
shinyApp(ui = ui, server = server)
