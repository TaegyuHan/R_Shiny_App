#------------------------------------------------------------------#
# 
# ???천향 ????????? 비정???????????? 과제
# 빅데?????? 공학??? 20171483 ?????????
# Shiny App 개발??????
# 
#------------------------------------------------------------------#



#------------------------------------------------------------------#
# Data Read

#------------------------------------------------------------------#




server <- function(input, output) {
  
  # --------------------------------------------------------------------------------- #
  # tabItem Data
  
  output$verb <- renderText({ paste0(input$state,"/",input$experimenter,".csv") })

  # Data ?????????
  output$sensorData = DT::renderDataTable( { get(paste0(input$state,"/",input$experimenter,".csv")) },
                                           options = list(autoWidth = TRUE,
                                                          scrollX = TRUE))
    output$dataLineGraph <- renderPlot({
      if (input$somevalue) {
        ggplot(get(paste0(input$state,"/",input$experimenter,".csv")),
               aes(x = X, y = get(input$dataGraphCol) )) + 
          geom_line(color="#605CA8", size = 1) +
          geom_point(color="#EFE909", size = 1.3) +
          theme_minimal() +
          xlab("Time") +
          ylab(input$dataGraphCol)
      }
      else { # Point 그래프 같이 보이기
        ggplot(get(paste0(input$state,"/",input$experimenter,".csv")),
               aes(x = X, y = get(input$dataGraphCol) )) + 
          geom_line(color="#605CA8", size = 1) +
          theme_minimal() +
          xlab("Time") +
          ylab(input$dataGraphCol)
      }
    })
  # tabItem Data End
  # --------------------------------------------------------------------------------- #  
    
    
    
  # --------------------------------------------------------------------------------- #
  # tabItem Statistics 
    
  output$StatisticsData = DT::renderDataTable( { StatisticsData %>% filter(exp_no == input$exp_no) },
                                               options = list(autoWidth = TRUE,
                                                              scrollX = TRUE))
  
  # tabItem Statistics End
  # --------------------------------------------------------------------------------- #

}