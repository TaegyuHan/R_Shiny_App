#------------------------------------------------------------------#
# 
# ???천향 ????????? 비정???????????? 과제
# 빅데?????? 공학??? 20171483 ?????????
# Shiny App 개발??????
# 
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
    
      if(input$StatisticsFilter_activity == "all") {
        StatisticsData
      } else {
        StatisticsData %>% filter(activity == input$StatisticsFilter_activity)  
      }
    
  },
      options = list(autoWidth = TRUE,
      scrollX = TRUE))
  
  
  output$StatisticsBoxGraph <- renderPlot({
    
    DataColorList <- c("#F9D541", "#605CA8", "#605CA8", "#605CA8", "#605CA8", "#605CA8")
    
    if(input$StatisticsFilter_activity == "all"){
      DataColorList[1:6] = "#F9D541"
    }
    else if (input$StatisticsFilter_activity == 'dws') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[1] = "#F9D541"
    } 
    else if (input$StatisticsFilter_activity == 'jog') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[2] = "#F9D541"
    } 
    else if (input$StatisticsFilter_activity == 'sit') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[3] = "#F9D541"
    } 
    else if (input$StatisticsFilter_activity == 'std') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[4] = "#F9D541"
    } 
    else if (input$StatisticsFilter_activity == 'ups') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[5] = "#F9D541"
    } 
    else if (input$StatisticsFilter_activity == 'wlk') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[6] = "#F9D541"
    }
    
    
    if(input$StatisticsShowPlot == 'All') {
      StatisticsData %>% 
        ggplot() + 
        theme_minimal() + 
        geom_boxplot(aes(x=activity , y=get(input$StatisticsBoxGraphCol), fill=activity)) +
        geom_point(aes(x=activity , y=get(input$StatisticsBoxGraphCol), colour=activity)) + 
        scale_fill_manual(values=DataColorList) + 
        scale_color_manual(values=DataColorList)
    }
    else if(input$StatisticsShowPlot == 'Show Scatter') {
      StatisticsData %>% 
        ggplot() + 
        theme_minimal() + 
        geom_point(aes(x=activity , y=get(input$StatisticsBoxGraphCol), colour=activity)) + 
        scale_color_manual(values=DataColorList)
        
    }
    else if(input$StatisticsShowPlot == 'Show Box') {
      StatisticsData %>% 
        ggplot() + 
        theme_minimal() + 
        geom_boxplot(aes(x=activity , y=get(input$StatisticsBoxGraphCol), fill=activity)) +
        scale_fill_manual(values=DataColorList)
        
    }
    
  })
  
  # tabItem Statistics End
  # --------------------------------------------------------------------------------- #
  
  
  # --------------------------------------------------------------------------------- #
  # tabItem Peak
  
  output$PeakData = DT::renderDataTable( {  
    
    if(input$PeakFilter_activity == "all") {
      PeakData
    } else {
      PeakData %>% filter(activity == input$PeakFilter_activity)
    }
    
  },
  options = list(autoWidth = TRUE, scrollX = TRUE))
  
  
  
  output$PeakBoxGraph <- renderPlot({
    
    DataColorList <- c("#F9D541", "#605CA8", "#605CA8", "#605CA8", "#605CA8", "#605CA8")
    
    if(input$PeakFilter_activity == "all"){
      DataColorList[1:6] = "#F9D541"
    }
    else if (input$PeakFilter_activity == 'dws') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[1] = "#F9D541"
    } 
    else if (input$PeakFilter_activity == 'jog') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[2] = "#F9D541"
    } 
    else if (input$PeakFilter_activity == 'sit') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[3] = "#F9D541"
    } 
    else if (input$PeakFilter_activity == 'std') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[4] = "#F9D541"
    } 
    else if (input$PeakFilter_activity == 'ups') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[5] = "#F9D541"
    } 
    else if (input$PeakFilter_activity == 'wlk') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[6] = "#F9D541"
    }
    
    
    if(input$PeakShowPlot == 'All') {
      PeakData %>% 
        ggplot() + 
        theme_minimal() + 
        geom_boxplot(aes(x=activity , y=get(input$PeakBoxGraphCol), fill=activity)) +
        geom_point(aes(x=activity , y=get(input$PeakBoxGraphCol), colour=activity)) + 
        scale_fill_manual(values=DataColorList) + 
        scale_color_manual(values=DataColorList)
    }
    else if(input$PeakShowPlot == 'Show Scatter') {
      PeakData %>% 
        ggplot() + 
        theme_minimal() + 
        geom_point(aes(x=activity , y=get(input$PeakBoxGraphCol), colour=activity)) + 
        scale_color_manual(values=DataColorList)
      
    }
    else if(input$PeakShowPlot == 'Show Box') {
      PeakData %>% 
        ggplot() + 
        theme_minimal() + 
        geom_boxplot(aes(x=activity , y=get(input$PeakBoxGraphCol), fill=activity)) +
        scale_fill_manual(values=DataColorList)
      
    }
    
  })
  
  # tabItem Peak End
  # --------------------------------------------------------------------------------- #
  
  
  # --------------------------------------------------------------------------------- #
  # tabItem Change Point
  
  output$ChangePointData = DT::renderDataTable( {

    if(input$ChangePointFilter_activity == "all") {
      ChangePointData
    } else {
      ChangePointData %>% filter(activity == input$ChangePointFilter_activity)
    }

  },
  options = list(autoWidth = TRUE, scrollX = TRUE))



  output$ChangePointBoxGraph <- renderPlot({

    DataColorList <- c("#F9D541", "#605CA8", "#605CA8", "#605CA8", "#605CA8", "#605CA8")

    if(input$ChangePointFilter_activity == "all"){
      DataColorList[1:6] = "#F9D541"
    }
    else if (input$ChangePointFilter_activity == 'dws') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[1] = "#F9D541"
    }
    else if (input$ChangePointFilter_activity == 'jog') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[2] = "#F9D541"
    }
    else if (input$ChangePointFilter_activity == 'sit') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[3] = "#F9D541"
    }
    else if (input$ChangePointFilter_activity == 'std') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[4] = "#F9D541"
    }
    else if (input$ChangePointFilter_activity == 'ups') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[5] = "#F9D541"
    }
    else if (input$ChangePointFilter_activity == 'wlk') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[6] = "#F9D541"
    }


    if(input$ChangePointShowPlot == 'All') {
      ChangePointData %>%
        ggplot() +
        theme_minimal() +
        geom_boxplot(aes(x=activity , y=get(input$ChangePointBoxGraphCol), fill=activity)) +
        geom_point(aes(x=activity , y=get(input$ChangePointBoxGraphCol), colour=activity)) +
        scale_fill_manual(values=DataColorList) +
        scale_color_manual(values=DataColorList)
    }
    else if(input$ChangePointShowPlot == 'Show Scatter') {
      ChangePointData %>%
        ggplot() +
        theme_minimal() +
        geom_point(aes(x=activity , y=get(input$ChangePointBoxGraphCol), colour=activity)) +
        scale_color_manual(values=DataColorList)

    }
    else if(input$ChangePointShowPlot == 'Show Box') {
      ChangePointData %>%
        ggplot() +
        theme_minimal() +
        geom_boxplot(aes(x=activity , y=get(input$ChangePointBoxGraphCol), fill=activity)) +
        scale_fill_manual(values=DataColorList)

    }

  })
  
  
  # tabItem Change Point End
  # --------------------------------------------------------------------------------- #
  
  
  
  # --------------------------------------------------------------------------------- #
  # tabItem SpectralAnalysis
  
  output$SpectralAnalysisData = DT::renderDataTable( {
    
    if(input$SpectralAnalysisFilter_activity == "all") {
      SpectralAnalysisData
    } else {
      SpectralAnalysisData %>% filter(activity == input$SpectralAnalysisFilter_activity)
    }
    
  },
  options = list(autoWidth = TRUE, scrollX = TRUE))
  
  
  
  output$SpectralAnalysisBoxGraph <- renderPlot({
    
    DataColorList <- c("#F9D541", "#605CA8", "#605CA8", "#605CA8", "#605CA8", "#605CA8")
    
    if(input$SpectralAnalysisFilter_activity == "all"){
      DataColorList[1:6] = "#F9D541"
    }
    else if (input$SpectralAnalysisFilter_activity == 'dws') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[1] = "#F9D541"
    }
    else if (input$SpectralAnalysisFilter_activity == 'jog') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[2] = "#F9D541"
    }
    else if (input$SpectralAnalysisFilter_activity == 'sit') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[3] = "#F9D541"
    }
    else if (input$SpectralAnalysisFilter_activity == 'std') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[4] = "#F9D541"
    }
    else if (input$SpectralAnalysisFilter_activity == 'ups') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[5] = "#F9D541"
    }
    else if (input$SpectralAnalysisFilter_activity == 'wlk') {
      DataColorList[1:6] = "#605CA8"
      DataColorList[6] = "#F9D541"
    }
    
    
    if(input$SpectralAnalysisShowPlot == 'All') {
      SpectralAnalysisData %>%
        ggplot() +
        theme_minimal() +
        geom_boxplot(aes(x=activity , y=get(input$SpectralAnalysisBoxGraphCol), fill=activity)) +
        geom_point(aes(x=activity , y=get(input$SpectralAnalysisBoxGraphCol), colour=activity)) +
        scale_fill_manual(values=DataColorList) +
        scale_color_manual(values=DataColorList) + 
        theme(axis.text.y=element_blank())
    }
    else if(input$SpectralAnalysisShowPlot == 'Show Scatter') {
      SpectralAnalysisData %>%
        ggplot() +
        theme_minimal() +
        geom_point(aes(x=activity , y=get(input$SpectralAnalysisBoxGraphCol), colour=activity)) +
        scale_color_manual(values=DataColorList) + 
        theme(axis.text.y=element_blank())
      
    }
    else if(input$SpectralAnalysisShowPlot == 'Show Box') {
      SpectralAnalysisData %>%
        ggplot() +
        theme_minimal() +
        geom_boxplot(aes(x=activity , y=get(input$SpectralAnalysisBoxGraphCol), fill=activity)) +
        scale_fill_manual(values=DataColorList) + 
        theme(axis.text.y=element_blank())
      
    }
    
  })
  
  # tabItem SpectralAnalysis End
  # --------------------------------------------------------------------------------- #
  
  

}