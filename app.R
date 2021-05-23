#------------------------------------------------------------------#
# 
# 순천향 대학교 비정형데이터 과제
# 빅데이터 공학과 20171483 한태규
# Shiny App 개발하기
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

library(shiny)
library(shinydashboard)
library(tidyverse)
library(DT)
library(pracma)
library(seewave)
library(changepoint)
#------------------------------------------------------------------#


#------------------------------------------------------------------#
load( "./.RData" )

setwd("C:/Users/gksxo/Desktop/순천향대학교/2학년2학기(3학년_4학년수업)/비정형데이터 분석/github/R_Shiny_App")

runApp("myapp")
#------------------------------------------------------------------#

