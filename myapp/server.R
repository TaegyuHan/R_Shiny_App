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
    
  output$StatisticsData = DT::renderDataTable({
    
      if(input$activity == "all") {
        StatisticsData
      } else {
        StatisticsData %>% filter(activity == input$activity)  
      }
    
  },
      options = list(autoWidth = TRUE,
      scrollX = TRUE))
  
  
  output$StatisticsBoxGraph <- renderPlot({
    
    StatisticsDataColorList <- c("#F9D541", "#605CA8", "#605CA8", "#605CA8", "#605CA8", "#605CA8")
    
    if(input$activity == "all"){
      StatisticsDataColorList[1:6] = "#F9D541"
    }
    else if (input$activity == 'dws') {
      StatisticsDataColorList[1:6] = "#605CA8"
      StatisticsDataColorList[1] = "#F9D541"
    } 
    else if (input$activity == 'jog') {
      StatisticsDataColorList[1:6] = "#605CA8"
      StatisticsDataColorList[2] = "#F9D541"
    } 
    else if (input$activity == 'sit') {
      StatisticsDataColorList[1:6] = "#605CA8"
      StatisticsDataColorList[3] = "#F9D541"
    } 
    else if (input$activity == 'std') {
      StatisticsDataColorList[1:6] = "#605CA8"
      StatisticsDataColorList[4] = "#F9D541"
    } 
    else if (input$activity == 'ups') {
      StatisticsDataColorList[1:6] = "#605CA8"
      StatisticsDataColorList[5] = "#F9D541"
    } 
    else if (input$activity == 'wlk') {
      StatisticsDataColorList[1:6] = "#605CA8"
      StatisticsDataColorList[6] = "#F9D541"
    }
    
    
    if(input$StatisticsShowPlot == 'All') {
      StatisticsData %>% 
        ggplot() + 
        theme_minimal() + 
        geom_boxplot(aes(x=activity , y=get(input$StatisticsBoxGraphCol), fill=activity)) +
        geom_point(aes(x=activity , y=get(input$StatisticsBoxGraphCol), colour=activity)) + 
        scale_fill_manual(values=StatisticsDataColorList) + 
        scale_color_manual(values=StatisticsDataColorList)
    }
    else if(input$StatisticsShowPlot == 'Show Scatter') {
      StatisticsData %>% 
        ggplot() + 
        theme_minimal() + 
        geom_point(aes(x=activity , y=get(input$StatisticsBoxGraphCol), colour=activity)) + 
        scale_color_manual(values=StatisticsDataColorList)
        
    }
    else if(input$StatisticsShowPlot == 'Show Box') {
      StatisticsData %>% 
        ggplot() + 
        theme_minimal() + 
        geom_boxplot(aes(x=activity , y=get(input$StatisticsBoxGraphCol), fill=activity)) +
        scale_fill_manual(values=StatisticsDataColorList)
        
    }
    
  })
  
  # tabItem Statistics End
  # --------------------------------------------------------------------------------- #

}