library(DT)
library(shiny)
library(shinydashboard)
library(googleVis)
library(dplyr)
library(shiny)
library(ggplot2)
library(gganimate)
library(plotly)
library(colourpicker)
library(viridis)
library(RColorBrewer)
library(shinyWidgets)
library(devtools)
library(animation)
library(cowplot)
library(magick)
library(praise)
library(testthat)
library(lubridate)
library(tm)
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library(rjson)
library(tsbox) 
library(memoise)
library(flipTime)
library(rsconnect)
us_videos<-read.csv( "./US_videos.csv")


docs <-VCorpus(VectorSource(us_videos$title))
inspect(docs)
toSpace <- content_transformer(function(x,pattern)gsub(pattern,"",x))
docs<- tm_map(docs,toSpace,"/")
docs<- tm_map(docs,toSpace,"@")
docs<- tm_map(docs,toSpace,"\\|")

# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers) 
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english")) 
#specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("blabla1", "blabla2"))
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
# Text stemming
docs <- tm_map(docs, stemDocument)


dtm <- TermDocumentMatrix(docs)
dtm<-as.matrix(dtm)

m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)

# corp <- us_videos[,'title']




