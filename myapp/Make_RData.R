


library(tidyverse)
library(DT)

sensorData <- read_csv("./myapp/data/total_data.csv")

save.image(file = "./.RData")


setwd("C:/Users/gksxo/Desktop/R_link_Data/Unstructured_data/A_DeviceMotion_data/A_DeviceMotion_data")
getwd()


## 현재 경로의 하위 파일 모두 출력
d <- getwd()
fls <- dir(d, recursive = TRUE)

## fls 확인하기
fls


#--------------------------------------------------------------------------#
## 데이터 read
for( f in fls){
  
  a <- file.path(str_c(d,"/",f))
  temp <- read.csv(a)
  print(a) #read한 파일 확인
  
  assign(f,temp)
  ## assign(<객체의 이름>, <객체에 들어갈 데이터터>) 함수
  ## 받은 문자열을 객체로 생성
  
  ## ex) assign("wlk_8/sub_9.csv", data)
}
#--------------------------------------------------------------------------#

for ( f in fls ){
  print(f)
}



# Data 데이터
output$sensorData = DT::renderDataTable( { `wlk_8/sub_9.csv` },
                                         filter = 'top',
                                         options = list(autoWidth = TRUE,
                                                        scrollX = TRUE))

colnames(`wlk_8/sub_9.csv`)

class(`wlk_8/sub_9.csv`["X"])


ggplot(`wlk_8/sub_9.csv`,aes(x = X, y = get("attitude.roll"))) + 
geom_line(color="#605CA8")+
  theme_minimal()







