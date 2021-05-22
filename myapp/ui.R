#------------------------------------------------------------------#
# 
# 순천향 대학교 비정형데이터 과제
# 빅데이터 공학과 20171483 한태규
# Shiny App 개발하기
# 
#------------------------------------------------------------------#





ui <- dashboardPage(
  
  
  

  skin = "purple",
  
  
  
  
  
  dashboardHeader(title = "Shiny App Dev"),
  
  
  
  
  
  dashboardSidebar(
      
      sidebarMenu(
        
          # Data
          menuItem("Data", tabName = "data", icon = icon("th")),
          
          # Preprocessing
          menuItem("Preprocessing", id = "chartsID", tabName = "charts", icon = icon("hammer"),
                   menuSubItem("Statistics", tabName = "Statistics"),
                   menuSubItem("Peak", tabName = "Peak"),
                   menuSubItem("Change Point", tabName = "Change Point"),
                   menuSubItem("Spectral Analysis", tabName = "Spectral Analysis")
          )
      )
      
  ),
  
  
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
                                       label = h5("데이터 상태"), 
                                       choices = list(  'dws_1' = 'dws_1'
                                                      , 'dws_11' = 'dws_11'
                                                      , 'dws_2' = 'dws_2'
                                                      , 'jog_16' = 'jog_16'
                                                      , 'jog_9' = 'jog_9'
                                                      , 'sit_13' = 'sit_13'
                                                      , 'sit_5' = 'sit_5'
                                                      , 'std_14' = 'std_14'
                                                      , 'std_6' = 'std_6'
                                                      , 'ups_12' = 'ups_12'
                                                      , 'ups_3' = 'ups_3'
                                                      , 'ups_4' = 'ups_4'
                                                      , 'wlk_15' = 'wlk_15'
                                                      , 'wlk_7' = 'wlk_7'
                                                      , 'wlk_8' = 'wlk_8'), 
                                       selected = "dws_1"),
                           
                           selectInput(inputId = "experimenter",
                                       label = h5("실험자"), 
                                       choices = list(  'sub_1' = 'sub_1'
                                                      , 'sub_2' = 'sub_2'
                                                      , 'sub_3' = 'sub_3'
                                                      , 'sub_4' = 'sub_4'
                                                      , 'sub_5' = 'sub_5'
                                                      , 'sub_6' = 'sub_6'
                                                      , 'sub_7' = 'sub_7'
                                                      , 'sub_8' = 'sub_8'
                                                      , 'sub_9' = 'sub_9'
                                                      , 'sub_10' = 'sub_10'
                                                      , 'sub_11' = 'sub_11'
                                                      , 'sub_12' = 'sub_12'
                                                      , 'sub_13' = 'sub_13'
                                                      , 'sub_14' = 'sub_14'
                                                      , 'sub_15' = 'sub_15'
                                                      , 'sub_16' = 'sub_16'
                                                      , 'sub_17' = 'sub_17'
                                                      , 'sub_18' = 'sub_18'
                                                      , 'sub_19' = 'sub_19'
                                                      , 'sub_20' = 'sub_20'
                                                      , 'sub_21' = 'sub_21'
                                                      , 'sub_22' = 'sub_22'
                                                      , 'sub_23' = 'sub_23'
                                                      , 'sub_24' = 'sub_24'), 
                                       selected = "sub_1"),
                           
                           h5("현재 보여주고 있는 Data"), 
                           verbatimTextOutput("verb")
                           ),
                           
                    column(width =7,
                           fluidRow(
                               plotOutput(outputId = 'dataLineGraph', width = '945px')
                           ),
                           fluidRow(
                             column(
                               width =5,
                               selectInput(inputId = "dataGraphCol",
                                           label = h5("colunm 선택"),
                                           choices = list( "attitude.roll" = "attitude.roll"
                                                         , "attitude.pitch" = "attitude.pitch"
                                                         , "attitude.yaw" = "attitude.yaw"
                                                         , "gravity.x" = "gravity.x"
                                                         , "gravity.y" = "gravity.y"
                                                         , "gravity.z" = "gravity.z"
                                                         , "rotationRate.x" = "rotationRate.x"
                                                         , "rotationRate.y" = "rotationRate.y"
                                                         , "rotationRate.z" = "rotationRate.z"
                                                         , "userAcceleration.x" = "userAcceleration.x"
                                                         , "userAcceleration.y" = "userAcceleration.y"
                                                         , "userAcceleration.z" = "userAcceleration.z"
                                                         , "maguserAcceleration" = "maguserAcceleration"
                                                         , "magrotationRate" = "magrotationRate"),
                                           selected = "attitude.roll"),
                               
                                   ),
                             column(
                                width =5,
                                h5("Plot Point 보여주기"),
                                checkboxInput("somevalue", "Show", FALSE),
                                verbatimTextOutput("value")
                                    )

                           )
                      
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
              fluidPage(
                  fluidRow(
                      column(width = 3.3,
                             selectInput(inputId = "exp_no",
                                         label = h5("Filter"), 
                                         choices = list(  'dws_1' = '1'
                                                        , 'dws_11' = '11'
                                                        , 'dws_2' = '2'
                                                        , 'jog_16' = '16'
                                                        , 'jog_9' = '9'
                                                        , 'sit_13' = '13'
                                                        , 'sit_5' = '5'
                                                        , 'std_14' = '14'
                                                        , 'std_6' = '6'
                                                        , 'ups_12' = '12'
                                                        , 'ups_3' = '3'
                                                        , 'ups_4' = '4'
                                                        , 'wlk_15' = '15'
                                                        , 'wlk_7' = '7'
                                                        , 'wlk_8' = '8'), 
                                         selected = "dws_1"),
                             ),
                      column(width = 3.3,
                             
                             ),
                      column(width = 3.3
                             )
                  ),
                  fluidRow(
                    DT::dataTableOutput('StatisticsData')
                  ),
              )
          )
          
          # tabItem Statistics end
          # --------------------------------------------------------------------------------- #
      )
  )
  
)












