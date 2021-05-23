#------------------------------------------------------------------#
# 
# 순천향 대학교 비정형데이터 과제
# 빅데이터 공학과 20171483 한태규
# Shiny App 개발하기
# 
#------------------------------------------------------------------#



#------------------------------------------------------------------#
# select list

stateList <- list(  'dws_1' = 'dws_1', 'dws_11' = 'dws_11', 'dws_2' = 'dws_2',
                    'jog_16' = 'jog_16', 'jog_9' = 'jog_9', 'sit_13' = 'sit_13',
                    'sit_5' = 'sit_5', 'std_14' = 'std_14', 'std_6' = 'std_6',
                    'ups_12' = 'ups_12', 'ups_3' = 'ups_3', 'ups_4' = 'ups_4',
                    'wlk_15' = 'wlk_15', 'wlk_7' = 'wlk_7', 'wlk_8' = 'wlk_8')

experimenterList <- list(  'sub_1' = 'sub_1', 'sub_2' = 'sub_2', 'sub_3' = 'sub_3', 
                           'sub_4' = 'sub_4', 'sub_5' = 'sub_5', 'sub_6' = 'sub_6', 
                           'sub_7' = 'sub_7', 'sub_8' = 'sub_8', 'sub_9' = 'sub_9', 
                           'sub_10' = 'sub_10', 'sub_11' = 'sub_11', 'sub_12' = 'sub_12', 
                           'sub_13' = 'sub_13', 'sub_14' = 'sub_14', 'sub_15' = 'sub_15', 
                           'sub_16' = 'sub_16', 'sub_17' = 'sub_17', 'sub_18' = 'sub_18', 
                           'sub_19' = 'sub_19', 'sub_20' = 'sub_20', 'sub_21' = 'sub_21', 
                           'sub_22' = 'sub_22', 'sub_23' = 'sub_23', 'sub_24' = 'sub_24')

dataGraphColList <- list( "attitude.roll" = "attitude.roll", "attitude.pitch" = "attitude.pitch", 
                          "attitude.yaw" = "attitude.yaw", "gravity.x" = "gravity.x", 
                          "gravity.y" = "gravity.y", "gravity.z" = "gravity.z", "rotationRate.x" = "rotationRate.x", 
                          "rotationRate.y" = "rotationRate.y", "rotationRate.z" = "rotationRate.z", 
                          "userAcceleration.x" = "userAcceleration.x", "userAcceleration.y" = "userAcceleration.y", 
                          "userAcceleration.z" = "userAcceleration.z", "maguserAcceleration" = "maguserAcceleration", 
                          "magrotationRate" = "magrotationRate")



activityList <-  list(  'all' = 'all', 'dws' = 'dws', 'jog' = 'jog', 'sit' = 'sit', 
                        'std' = 'std', 'ups' = 'ups', 'wlk' = 'wlk')



StatisticsBoxGraphColList <- list(  "attitude.roll_mean" = "attitude.roll_mean"
                                    , "attitude.pitch_mean" = "attitude.pitch_mean"
                                    , "attitude.yaw_mean" = "attitude.yaw_mean"
                                    , "gravity.x_mean" = "gravity.x_mean"
                                    , "gravity.y_mean" = "gravity.y_mean"
                                    , "gravity.z_mean" = "gravity.z_mean"
                                    , "rotationRate.x_mean" = "rotationRate.x_mean"
                                    , "rotationRate.y_mean" = "rotationRate.y_mean"
                                    , "rotationRate.z_mean" = "rotationRate.z_mean"
                                    , "userAcceleration.x_mean" = "userAcceleration.x_mean"
                                    , "userAcceleration.y_mean" = "userAcceleration.y_mean"
                                    , "userAcceleration.z_mean" = "userAcceleration.z_mean"
                                    , "maguserAcceleration_mean"  = "maguserAcceleration_mean" 
                                    , "magrotationRate_mean"  = "magrotationRate_mean" 
                                    , "attitude.roll_min" = "attitude.roll_min"
                                    , "attitude.pitch_min" = "attitude.pitch_min"
                                    , "attitude.yaw_min" = "attitude.yaw_min"
                                    , "gravity.x_min" = "gravity.x_min"
                                    , "gravity.y_min" = "gravity.y_min"
                                    , "gravity.z_min" = "gravity.z_min"
                                    , "rotationRate.x_min" = "rotationRate.x_min"
                                    , "rotationRate.y_min" = "rotationRate.y_min"
                                    , "rotationRate.z_min" = "rotationRate.z_min"
                                    , "userAcceleration.x_min" = "userAcceleration.x_min"
                                    , "userAcceleration.y_min" = "userAcceleration.y_min"
                                    , "userAcceleration.z_min" = "userAcceleration.z_min"
                                    , "maguserAcceleration_min"  = "maguserAcceleration_min" 
                                    , "magrotationRate_min"  = "magrotationRate_min" 
                                    , "attitude.roll_max" = "attitude.roll_max"
                                    , "attitude.pitch_max" = "attitude.pitch_max"
                                    , "attitude.yaw_max" = "attitude.yaw_max"
                                    , "gravity.x_max" = "gravity.x_max"
                                    , "gravity.y_max" = "gravity.y_max"
                                    , "gravity.z_max" = "gravity.z_max"
                                    , "rotationRate.x_max" = "rotationRate.x_max"
                                    , "rotationRate.y_max" = "rotationRate.y_max"
                                    , "rotationRate.z_max" = "rotationRate.z_max"
                                    , "userAcceleration.x_max" = "userAcceleration.x_max"
                                    , "userAcceleration.y_max" = "userAcceleration.y_max"
                                    , "userAcceleration.z_max" = "userAcceleration.z_max"
                                    , "maguserAcceleration_max"  = "maguserAcceleration_max" 
                                    , "magrotationRate_max"  = "magrotationRate_max" 
                                    , "attitude.roll_sd" = "attitude.roll_sd"
                                    , "attitude.pitch_sd" = "attitude.pitch_sd"
                                    , "attitude.yaw_sd" = "attitude.yaw_sd"
                                    , "gravity.x_sd" = "gravity.x_sd"
                                    , "gravity.y_sd" = "gravity.y_sd"
                                    , "gravity.z_sd" = "gravity.z_sd"
                                    , "rotationRate.x_sd" = "rotationRate.x_sd"
                                    , "rotationRate.y_sd" = "rotationRate.y_sd"
                                    , "rotationRate.z_sd" = "rotationRate.z_sd"
                                    , "userAcceleration.x_sd" = "userAcceleration.x_sd"
                                    , "userAcceleration.y_sd" = "userAcceleration.y_sd"
                                    , "userAcceleration.z_sd" = "userAcceleration.z_sd"
                                    , "maguserAcceleration_sd"  = "maguserAcceleration_sd" 
                                    , "magrotationRate_sd"  = "magrotationRate_sd" 
                                    , "attitude.roll_skewness" = "attitude.roll_skewness"
                                    , "attitude.pitch_skewness" = "attitude.pitch_skewness"
                                    , "attitude.yaw_skewness" = "attitude.yaw_skewness"
                                    , "gravity.x_skewness" = "gravity.x_skewness"
                                    , "gravity.y_skewness" = "gravity.y_skewness"
                                    , "gravity.z_skewness" = "gravity.z_skewness"
                                    , "rotationRate.x_skewness" = "rotationRate.x_skewness"
                                    , "rotationRate.y_skewness" = "rotationRate.y_skewness"
                                    , "rotationRate.z_skewness" = "rotationRate.z_skewness"
                                    , "userAcceleration.x_skewness" = "userAcceleration.x_skewness"
                                    , "userAcceleration.y_skewness" = "userAcceleration.y_skewness"
                                    , "userAcceleration.z_skewness" = "userAcceleration.z_skewness"
                                    , "maguserAcceleration_skewness" = "maguserAcceleration_skewness")


PeakBoxGraphColList <- list( "f_n", "p_interval", "p_interval_std", 
                             "p_mean", "p_max", "p_min", 
                             "p_std", "cfR", "cfA" )

ChangePointPeakBoxGraphColList <- list(  "cp_magrotationRate_mean"
                                       , "cp_maguserAcceleration_mean"
                                       , "cp_magrotationRate_var"
                                       , "cp_maguserAcceleration_var"
                                       , "cp_magrotationRate_meanvar"
                                       , "cp_maguserAcceleration_meanvar")



SpectralAnalysisBoxGraphColList <- list(   "V2", "V3", 
                                          "V4", "V5", "V6", 
                                          "V7", "V8", "V9", 
                                          "V10", "V11" )

DataChoiceList <- list( "StatisticsData" = "StatisticsData"
                      , "PeakData" = "PeakData"
                      , "ChangePointData" = "ChangePointData"
                      , "SpectralAnalysisData" = "SpectralAnalysisData")

ShowPlotList <- c('All',
                  'Show Scatter',
                  'Show Box')

# select list end
#------------------------------------------------------------------#





#------------------------------------------------------------------#
# ui

ui <- dashboardPage(
    
    # 스킨
    skin = "purple",
    
    
    
    
    # Header
    dashboardHeader(title = "Shiny App Dev"),
    
    
    
    
    # Sidebar
    dashboardSidebar(
      
        sidebarMenu(
          
            # Data
            menuItem("Data", tabName = "data", icon = icon("th")),
          
            # Preprocessing
            menuItem("Preprocessing", id = "chartsID", tabName = "charts", icon = icon("hammer"),
                menuSubItem("Statistics", tabName = "Statistics"),
                menuSubItem("Peak", tabName = "Peak"),
                menuSubItem("Change Point", tabName = "Change_Point"),
                menuSubItem("Spectral Analysis", tabName = "Spectral_Analysis")
            ),
          
            # model
            menuItem("Model",tabName = "Model", icon = icon("hammer"))
        )
    ),
    
    
    
    
    # Body
    dashboardBody(
      
        tabItems(
          
            # --------------------------------------------------------------------------------- #
            # tabItem Data
            tabItem(
              
                tabName = "data",
              
                fluidPage(
                
                    titlePanel("데이터 확인"),
                
                    fluidRow(
                      
                        column(
                          
                            width = 3,
                            
                            selectInput(inputId = "state",
                                        label = "데이터 범주",
                                        choices = stateList, 
                                        selected = "dws_1"),
                           
                            selectInput(inputId = "experimenter",
                                        label = "실험자", 
                                        choices = experimenterList, 
                                        selected = "sub_1"),

                            selectInput(inputId = "dataGraphCol",
                                        label = "시각화 colunm 선택",
                                        choices = dataGraphColList,
                                        selected = "attitude.roll"),
                           
                            checkboxInput("somevalue", "Show Point", FALSE),
                           
                            verbatimTextOutput("verb"),
                        ),
                           
                        column(width =7,
                               
                           fluidRow(
                             
                               plotOutput(outputId = 'dataLineGraph', width = '945px')
                               
                            ),
                        )
                    ),
                    
                    fluidRow(
                      
                        DT::dataTableOutput('sensorData')
                    ),
                )
            ),
            # tabItem Data End
            # --------------------------------------------------------------------------------- #
          
          
            # --------------------------------------------------------------------------------- #
            # tabItem Statistics
            tabItem(
              
                tabName = "Statistics",
                
                titlePanel("Statistics"),
              
                fluidPage(
                  
                    fluidRow(
                      
                        column(width = 3,
                               
                            selectInput(inputId = "StatisticsFilter_activity",
                                        label = "Filter Row Activity", 
                                        choices = activityList, 
                                        selected = "all"),
                             
                            selectInput(inputId = "StatisticsBoxGraphCol",
                                        label = "시각화 colunm 선택",
                                        choices = StatisticsBoxGraphColList,
                                        selected = "attitude.roll"),
                             
                            radioButtons(inputId = 'StatisticsShowPlot',
                                          label = '시각화 선택',
                                          choices = ShowPlotList,
                                          selected = 'All'),

                        ),
                        
                        column(width = 7,
                               
                            fluidRow(
                            
                                plotOutput(outputId = 'StatisticsBoxGraph', width = '945px')
                            )
                        ),
                    ),
                    
                    fluidRow(
                      
                        DT::dataTableOutput('StatisticsData')
                    ),
                )
            ),
            # tabItem Statistics end
            # --------------------------------------------------------------------------------- #
          
            # --------------------------------------------------------------------------------- #
            # tabItem Peak
            tabItem(
              
                tabName = "Peak",
                
                titlePanel("Peak"),
                
                fluidPage(
                  
                    fluidRow(
                      
                        column(width = 3,
                       
                        selectInput(inputId = "PeakFilter_activity",
                                    label = "Filter Row Activity", 
                                    choices = activityList, 
                                    selected = "all"),
                       
                        selectInput(inputId = "PeakBoxGraphCol",
                                    label = "시각화 colunm 선택",
                                    choices = PeakBoxGraphColList,
                                    selected = "attitude.roll"),
                       
                        radioButtons(inputId = 'PeakShowPlot',
                                     label = '시각화 선택',
                                     choices = ,
                                     selected = 'All'),
                        ),
                        
                        column(width = 7,
                               
                            fluidRow(
                                plotOutput(outputId = 'PeakBoxGraph', width = '945px')
                            )
                        )
                    ),
                    
                    fluidRow(
                      
                        DT::dataTableOutput('PeakData')
                    ),
                )
            ),
            # tabItem Peak End
            # --------------------------------------------------------------------------------- #
          
          
            # --------------------------------------------------------------------------------- #
            # tabItem Change Point
            tabItem(
              
                tabName = "Change_Point",
                
                titlePanel("Change Point"),
                
                fluidPage(
                  
                    fluidRow(
                      
                        column(width = 3,
                       
                        selectInput(inputId = "ChangePointFilter_activity",
                                    label = "Filter Row Activity", 
                                    choices = activityList, 
                                    selected = "all"),
                       
                        selectInput(inputId = "ChangePointBoxGraphCol",
                                    label = "시각화 colunm 선택",
                                    choices = ChangePointPeakBoxGraphColList,
                                    selected = "attitude.roll"),
                       
                        radioButtons(inputId = 'ChangePointShowPlot',
                                     label = '시각화 선택',
                                     choices = ShowPlotList,
                                     selected = 'All'),
                        ),
                        
                        column(width = 7,
                               
                            fluidRow(
                              
                                plotOutput(outputId = 'ChangePointBoxGraph', width = '945px')
                            )
                        )
                    ),
                    
                    fluidRow(
                        DT::dataTableOutput('ChangePointData')
                    ),
                )
            ),
            # tabItem Change Point End
            # --------------------------------------------------------------------------------- #
          
          
            # --------------------------------------------------------------------------------- #
            # tabItem SpectralAnalysis
            tabItem(
              
                tabName = "Spectral_Analysis",
                
                titlePanel("Spectral Analysis"),
                
                fluidPage(
                  
                    fluidRow(
                        
                        column(width = 3,
                       
                        selectInput(inputId = "SpectralAnalysisFilter_activity",
                                    label = "Filter Row Activity", 
                                    choices = activityList, 
                                    selected = "all"),
                       
                        selectInput(inputId = "SpectralAnalysisBoxGraphCol",
                                    label = "시각화 colunm 선택",
                                    choices = SpectralAnalysisBoxGraphColList,
                                    selected = "attitude.roll"),
                       
                        radioButtons(inputId = 'SpectralAnalysisShowPlot',
                                     label = '시각화 선택',
                                     choices = ShowPlotList,
                                     selected = 'All'),
                        ),
                        
                        column(width = 7,
                               
                            fluidRow(
                              
                                plotOutput(outputId = 'SpectralAnalysisBoxGraph', width = '945px')
                            )
                        )
                    ),
                    
                    fluidRow(
                      
                        DT::dataTableOutput('SpectralAnalysisData')
                    ),
                )
            ),
            # tabItem SpectralAnalysis End
            # --------------------------------------------------------------------------------- #
            
            
            
            # --------------------------------------------------------------------------------- #
            # model
            tabItem(
              
                tabName = "Model",
                
                titlePanel("Model"),
                
                fluidPage(
                  
                    fluidRow(
                      
                        column(width = 3,
                           
                            div(style="margin-top:25px;",
                                radioButtons(inputId = 'ChoiceData',
                                             label = 'Data 선택',
                                             choices = DataChoiceList,
                                             selected = 'StatisticsData')),
                       
                            verbatimTextOutput("value")
                        ),
                        column(width = 7,
                           
                            h3("RF Model"),
                        
                            div(style="width:850px;", verbatimTextOutput("modelPrint")),
                        )
                    ),
                
                    fluidRow(
                        DT::dataTableOutput('Data')
                    )
                )
            )
            # model End
            # --------------------------------------------------------------------------------- #
        )
    )
)












