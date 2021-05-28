
#------------------------------------------------------------------#
#
# 순천향대학교
# 빅데이터 공학과 20171483
# Han Tae Gyu
# 
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# install.packages("shiny")
# install.packages("shinydashboard")
# install.packages("tidyverse")
# install.packages("DT")
# install.packages("pracma")
# install.packages("seewave")
# install.packages("changepoint")

library(changepoint)
library(shiny)
library(shinydashboard)
library(tidyverse)
library(DT)
library(pracma)
library(seewave)
library(changepoint)
library(RWeka)
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# Run app
setwd("C:/shinyApp/R_Shiny_App_homework")

load( "./myapp/.RData" )

runApp("myapp")
#------------------------------------------------------------------#
