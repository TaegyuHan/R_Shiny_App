

setwd("C:/Users/gksxo/Desktop/R_link_Data/Unstructured_data/A_DeviceMotion_data/A_DeviceMotion_data")
getwd()


## 현재 경로의 하위 파일 모두 출력
d <- getwd()
fls <- dir(d, recursive = TRUE)

## fls 확인하기
fls


mag <- function(df, column){
  
  df[, str_c("mag",column)] <- with(df, sqrt( get(str_c(column,".x"))^2 +
                                              get(str_c(column,".y"))^2 +
                                              get(str_c(column,".z"))^2 ))
  return(df) ## return ���
}

#--------------------------------------------------------------------------#
## 데이터 read
for( f in fls ) {
  
  a <- file.path(str_c(d,"/",f))
  temp <- read.csv(a)
  temp <- mag(temp,"userAcceleration")
  temp <- mag(temp,"rotationRate")
  print(a) #read한 파일 확인
  
  assign(f,temp)
  ## assign(<객체의 이름>, <객체에 들어갈 데이터터>) 함수
  ## 받은 문자열을 객체로 생성
  
  ## ex) assign("wlk_8/sub_9.csv", data)
}
#--------------------------------------------------------------------------#


#--------------------------------------------------------------------------#
# Static Data 

## 데이터 프레임 생성
HAR_total <- data.frame()

for(f in fls){
  
  temp <- get(f)
  HAR_total <- rbind(HAR_total, 
                     temp %>% 
                       mutate( exp_no   = unlist(regmatches(f, gregexpr("[[:digit:]]+", f)[1]))[1],
                               id       = unlist(regmatches(f, gregexpr("[[:digit:]]+", f)[1]))[2],
                               activity = unlist(str_split(f,"\\_")[1])[1] ))
  print(paste(f,' : END'))
}


skewness <- function(x) {
  
  (sum((x - mean(x))^3)/length(x))/((sum((x - mean(x))^2)/length(x)))^(3/2)
  
}

StatisticsData <- HAR_total %>% 
  group_by(id, exp_no, activity) %>% 
  summarize_at(.vars=c(  "attitude.roll"
                         , "attitude.pitch"
                         , "attitude.yaw"
                         , "gravity.x"
                         , "gravity.y"
                         , "gravity.z"
                         , "rotationRate.x"
                         , "rotationRate.y"
                         , "rotationRate.z"
                         , "userAcceleration.x"
                         , "userAcceleration.y"
                         , "userAcceleration.z"
                         , "maguserAcceleration"
                         , "magrotationRate"
  ),
  .funs=c(mean = mean, min = min, max = max, sd = sd, skewness = skewness))

#--------------------------------------------------------------------------#



#--------------------------------------------------------------------------#
## Peak 관련 통계량
## data frame 만들기
Peak_rslt <- data.frame()

for(d in fls) {
  
  print(d)
  f <- get(d)
  p <- findpeaks(f$magrotationRate, threshold = 4) # 4 이상의 값을 피크로 도출
  
  Peak_rslt <- rbind( Peak_rslt
                      , data.frame( d 
                                    # 피크 추출 결과 p 가 null이 아니면 dim(p)[1] : 행의 개수를 추출
                                    , f_n            = ifelse(!is.null(p), dim(p)[1], 0)
                                    
                                    # dim(p)[1]>2 : 행의 개수가 두개 이상이면, diff함수를 써서 행의 차이를 구함
                                    # diff(p[,2]) : 피크 간격의 차이를 구하고 mean() 으로 평균을 구함
                                    , p_interval     = ifelse(!is.null(p), ifelse(dim(p)[1]>2, mean(diff(p[,2])), 0), 0)
                                    
                                    # 피크 간격의 표준편차를 구함
                                    , p_interval_std = ifelse(!is.null(p), ifelse(dim(p)[1]>2, std(diff(p[,2])), 0), 0)
                                    
                                    , p_mean         = ifelse(!is.null(p), mean(p)[1], 0) # 평균
                                    , p_max          = ifelse(!is.null(p), max(p)[1], 0) # 최대
                                    , p_min          = ifelse(!is.null(p), min(p)[1], 0) # 최소 
                                    , p_std          = ifelse(!is.null(p), std(p)[1], 0))) # 표준편차
}


Peak_rslt

#--------------------------------------------------------------------------#
## 파고율 구하기
temp <- data.frame()

for (d in fls) {
  
  f <- get(d)
  f <- f %>% dplyr::select(magrotationRate, maguserAcceleration)
  cfR <- crest(f$magrotationRate, 50, plot=TRUE)
  cfA <- crest(f$maguserAcceleration, 50, plot=TRUE)
  temp <- rbind(temp, data.frame(d, cfR=cfR$C, cfA=cfA$C))
  print(paste(d,' : END'))
}

Peak_final <- merge(Peak_rslt, temp, by="d")

#--------------------------------------------------------------------------#

#--------------------------------------------------------------------------#
## 파일명에서 activity, id 등 정보 추출하기

## exp_no id activity 정보 추출 함수
id_f <- function(x){
  exp_no = unlist(regmatches(x, gregexpr("[[:digit:]]+", x)[1]))[1]
  id = unlist(regmatches(x, gregexpr("[[:digit:]]+", x)[1]))[2]
  activity = unlist(str_split(x, "\\_"))[1]
  
  return(cbind(exp_no, id, activity))
}

## data.frame 생성
temp <- data.frame()

for( i in 1:nrow(Peak_final)) {
  temp <- rbind(temp, id_f(Peak_final$d[i]))
}

## 결과 묶기
PeakData <- cbind( temp,Peak_final)
colnames(PeakData)


#--------------------------------------------------------------------------#
# ChangePoint

ChangePointData <- data.frame()

for ( d in fls ) {
  print(d)
  f <- get(d)
  f <- mag(f,"rotationRate")
  f <- mag(f,"userAcceleration")
  
  ## mean
  rslt <- sapply( f %>% dplyr::select(magrotationRate,maguserAcceleration)
                  , cpt.mean )
  rslt_cpts1 <- cpts(rslt$magrotationRate)
  rslt_cpts2 <- cpts(rslt$maguserAcceleration)
  
  
  ## var
  rslt2 <- sapply( f %>% dplyr::select(magrotationRate,maguserAcceleration)
                   , cpt.var )
  rslt2_cpts1 <- cpts(rslt2$magrotationRate)
  rslt2_cpts2 <- cpts(rslt2$maguserAcceleration)
  
  
  ## meanvar
  rslt3 <- sapply( f %>% dplyr::select(magrotationRate,maguserAcceleration)
                   , cpt.meanvar )
  rslt3_cpts1 <- cpts(rslt3$magrotationRate)
  rslt3_cpts2 <- cpts(rslt3$maguserAcceleration)
  
  
  ## dadta.frame
  ChangePointData <- rbind( ChangePointData
                  , data.frame( d
                                , cp_magrotationRate_mean=length(rslt_cpts1)
                                , cp_maguserAcceleration_mean=length(rslt_cpts2)
                                , cp_magrotationRate_var=length(rslt2_cpts1)
                                , cp_maguserAcceleration_var=length(rslt2_cpts2)
                                , cp_magrotationRate_meanvar=length(rslt3_cpts1)
                                , cp_maguserAcceleration_meanvar=length(rslt3_cpts2)) )
}

head(ch_pt)

#--------------------------------------------------------------------------#

#--------------------------------------------------------------------------#
## 파일명에서 activity, id 등 정보 추출하기
## exp_no id activity 정보 추출 함수
id_f <- function ( x ) {
  exp_no = unlist(regmatches(x, gregexpr("[[:digit:]]+", x)[1]))[1]
  id = unlist(regmatches(x, gregexpr("[[:digit:]]+", x)[1]))[2]
  activity = unlist(str_split(x, "\\_"))[1]
  
  return(cbind(exp_no, id, activity))
}

## data.frame 생성
temp <- data.frame()

for ( i in 1:nrow(ChangePointData)) {
  temp <- rbind(temp, id_f(ChangePointData$d[i]))
}

## 결과 묶기
ChangePointData <- cbind(temp, ChangePointData)

colnames(ChangePointData)

#--------------------------------------------------------------------------#









#--------------------------------------------------------------------------#
## 占쏙옙占쌈듸옙 占쏙옙환 占쌉쇽옙
## 占쏙옙占쏙옙 크占쏙옙 占쏙옙占싹댐옙 占쏙옙占쏙옙

mag <- function ( df, column ) {
  
  df[, str_c("mag",column)] <- with(df, sqrt( get(str_c(column,".x"))^2 +
                                                get(str_c(column,".y"))^2 +
                                                get(str_c(column,".z"))^2 ))
  return(df) ## return 占쏙옙占?
}

#--------------------------------------------------------------------------#
# 
id_f <- function ( x ) {
  exp_no = unlist(regmatches(x, gregexpr("[[:digit:]]+", x)[1]))[1]
  id = unlist(regmatches(x, gregexpr("[[:digit:]]+", x)[1]))[2]
  activity = unlist(str_split(x, "\\_"))[1]
  
  return(cbind(exp_no, id, activity))
}

#--------------------------------------------------------------------------#


#--------------------------------------------------------------------------#
# 스펙트럼 데이터 

FreqDataTemp <- data.frame()

for(d in fls){
  
  f <- get(d)
  f <- mag(f,"rotationRate")
  f <- mag(f,"userAcceleration")
  
  r.spec <- spectrum(f$magrotationRate,span=10,plot=FALSE)
  
  fr <- r.spec$freq*50 %>% sort(decreasing = T)
  sp <- r.spec$spec*2 %>% sort(decreasing = T)
  
  FreqDataTemp <- rbind(FreqDataTemp,as.data.frame(t(c(d,fr[1:5],sp[1:5]))))
  print(d)
}

#--------------------------------------------------------------------------#

temp <- data.frame()

for(i in 1:nrow(FreqDataTemp)){
  temp <- rbind(temp,id_f(FreqDataTemp$V1[i]))
}

SpectralAnalysisData <- data.frame()

SpectralAnalysisData <- cbind(temp,FreqDataTemp)

colnames(SpectralAnalysisData)


SpectralAnalysisData




library(RWeka)

RF <- make_Weka_classifier("weka/classifiers/trees/RandomForest")

m <- RF(as.factor(activity)~., data=ch_pt2)

e <- evaluate_Weka_classifier( m
                               , numFolds = 10
                               , complexity = TRUE
                               , class = TRUE )

e$confusionMatrix


save.image(file = "./.RData")



