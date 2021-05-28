
library(changepoint)
library(shiny)
library(shinydashboard)
library(tidyverse)
library(DT)
library(pracma)
library(seewave)
library(changepoint)
library(RWeka)


ShowGraph <- function(data, filter, showPlot, showCol)
{
  
  DataColorList <- c("#F9D541", "#605CA8", "#605CA8",
                     "#605CA8", "#605CA8", "#605CA8")
  
  if (filter == "all") {
    DataColorList[1:6] = "#F9D541"
  }
  else if (filter == 'dws') {
    DataColorList[1:6] = "#605CA8"
    DataColorList[1] = "#F9D541"
  } 
  else if (filter == 'jog') {
    DataColorList[1:6] = "#605CA8"
    DataColorList[2] = "#F9D541"
  } 
  else if (filter == 'sit') {
    DataColorList[1:6] = "#605CA8"
    DataColorList[3] = "#F9D541"
  } 
  else if (filter == 'std') {
    DataColorList[1:6] = "#605CA8"
    DataColorList[4] = "#F9D541"
  } 
  else if (filter == 'ups') {
    DataColorList[1:6] = "#605CA8"
    DataColorList[5] = "#F9D541"
  } 
  else if (filter == 'wlk') {
    DataColorList[1:6] = "#605CA8"
    DataColorList[6] = "#F9D541"
  }
  
  
  if(showPlot == 'All') {
    showPlot <- data %>% 
      ggplot() + 
      theme_minimal() + 
      geom_boxplot(aes(x=activity , y=get(showCol), fill=activity)) +
      geom_point(aes(x=activity , y=get(showCol), colour=activity)) + 
      scale_fill_manual(values=DataColorList) + 
      scale_color_manual(values=DataColorList) + 
      theme(axis.text.y=element_blank())
  }
  else if(showPlot == 'Show Scatter') {
    showPlot <- data %>% 
      ggplot() + 
      theme_minimal() + 
      geom_point(aes(x=activity , y=get(showCol), colour=activity)) + 
      scale_color_manual(values=DataColorList) + 
      theme(axis.text.y=element_blank())
  }
  else if(showPlot == 'Show Box') {
    showPlot <- data %>% 
      ggplot() + 
      theme_minimal() + 
      geom_boxplot(aes(x=activity , y=get(showCol), fill=activity)) +
      scale_fill_manual(values=DataColorList) + 
      theme(axis.text.y=element_blank())
  }
  
  return(showPlot)
}
#------------------------------------------------------------------#




#------------------------------------------------------------------#
# model
showModel <- function(data)
{
  
  RF <- make_Weka_classifier("weka/classifiers/trees/RandomForest")
  
  m <- RF(as.factor(activity)~., data)
  
  e <- evaluate_Weka_classifier( m
                                 , numFolds = 10
                                 , complexity = TRUE
                                 , class = TRUE )
  
  return(e)
}
#------------------------------------------------------------------#



server <- function(input, output) {
  
  
    # --------------------------------------------------------------------------------- #
    # tabItem Data
    
    output$verb <- renderText({ paste0(input$state,"/",input$experimenter,".csv") })
    
    
    # Data 
    output$sensorData = DT::renderDataTable({
        get(paste0(input$state,"/",input$experimenter,".csv"))
    },
    options = list(autoWidth = TRUE,scrollX = TRUE))
    
  
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
        else { 
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
    options = list(autoWidth = TRUE,scrollX = TRUE))
    
    output$StatisticsBoxGraph <- renderPlot({
      
        ShowGraph(data = StatisticsData,
                  filter = input$StatisticsFilter_activity,
                  showPlot = input$StatisticsShowPlot,
                  showCol = input$StatisticsBoxGraphCol)
      
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
      
      ShowGraph(data = PeakData,
                filter = input$PeakFilter_activity,
                showPlot = input$PeakShowPlot,
                showCol = input$PeakBoxGraphCol)
      
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
      
      ShowGraph(data = ChangePointData,
                filter = input$ChangePointFilter_activity,
                showPlot = input$ChangePointShowPlot,
                showCol = input$ChangePointBoxGraphCol)
  
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
      
        ShowGraph(data = SpectralAnalysisData,
                  filter = input$SpectralAnalysisFilter_activity,
                  showPlot = input$SpectralAnalysisShowPlot,
                  showCol = input$SpectralAnalysisBoxGraphCol)
      
    })
    
    # tabItem SpectralAnalysis End
    # --------------------------------------------------------------------------------- #
    
    
    # --------------------------------------------------------------------------------- #
    # model 

    output$Data = DT::renderDataTable({
    
        if (input$ChoiceData == "StatisticsData") {
            StatisticsData
        }
        else if (input$ChoiceData == "PeakData") {
            PeakData
        }
        else if (input$ChoiceData == "ChangePointData") {
            ChangePointData
        }
        else if (input$ChoiceData == "SpectralAnalysisData") {
            SpectralAnalysisData
        }
      
    },
    options = list(autoWidth = TRUE,
                   scrollX = TRUE))
    
    
    
    output$modelPrint <- renderPrint({ 
      
        if (input$ChoiceData == "StatisticsData") {
          
            showModel(StatisticsData[,3:73])
    
        }
        else if (input$ChoiceData == "PeakData") {
          
            showModel(cbind(activity = PeakData[,3:3], PeakData[,5:13]))
          
        }
        else if (input$ChoiceData == "ChangePointData") {
          
            showModel(cbind(activity = ChangePointData[,3:3], ChangePointData[,5:10]))
        
        }
        else if (input$ChoiceData == "SpectralAnalysisData") {
            
            activity_freq <- SpectralAnalysisData %>% select(-exp_no,-id,-V1)
            
            for (x in 2:11) {
                t <- paste0("V",x)
                activity_freq[[t]] <- as.numeric(activity_freq[[t]])
            }
            
            showModel(activity_freq)
        }
    })
    
    # --------------------------------------------------------------------------------- #
    
}