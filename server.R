
shinyServer(function (input, output){
     
    
   #Reactive Data Table
    output$tab_us_videos = DT::renderDataTable({
       data<- us_videos
       if (input$categories != "All") {
           data <- data[data$manufacturer == input$categories,]
       }
       if (input$channel_title != "All") {
           data <- data[data$channel_title == input$channel_title,]
       }
       data
        
        })
    
    ##### AVG VIEWS PER CATEGORY#####
    
    #reactive pie chart for views per category ##
    output$tot_views_per_cat = renderPlotly({
        
        # Views Per Category Pie Chart
        plot_ly(us_videos, labels = ~categories, values = ~views, type = 'pie') %>%
            layout(title = 'Youtubes Video Views per categories',
                   xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                   yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
        
    })

         # reactive Average views per category
    output$avg_views_per_cat = renderPlotly({
         ggplotly(us_videos %>% 
                     group_by(.,categories) %>%
                     summarise(.,avg_views = mean(views)) %>% 
                     arrange(.,desc(avg_views))%>% 
                              ggplot(aes(x = reorder(categories, avg_views), 
                                         y = avg_views, fill=categories)) +
                              geom_col() + coord_flip() + theme(legend.position="none") +
                              labs(y ="Average Views", x = "Category"))
    })
    
    
    # #Top 50 Most Trending Channels
     
     output$most_trend_chan = renderPlotly({
            ggplotly(us_videos %>%
                         group_by(channel_title) %>%
                         summarise(num_trend_vids = length(channel_title)) %>%
                         arrange(desc(num_trend_vids)) %>% 
                         head(50) %>% 
                         ggplot(aes(x = reorder(channel_title, -num_trend_vids, na.rm=TRUE),
                                    y = num_trend_vids, fill = channel_title)) +
                         geom_bar(stat = "identity") + 
                         theme(legend.position="none",
                               axis.text.x = element_text(angle=45)) +
                         labs(x = "Channel", y = "Trending videos", title = "Top Trending Channels"))
})
     
     #Number of Days Before Trending
             published_time = AsDateTime(us_videos$publish_time) #flipTime Datetime conversions
             published_date = date(published_time)
             trending_diff = us_videos$trending_date-published_date 
                us_videos %>% mutate(trending_diff = trending_diff) 
                 High_trending_df =as.numeric(us_videos$trending_diff[us_videos$trending_diff <40])
         output$days_till_trend = renderPlotly({
             plot_ly(x = High_trending_df, type = "histogram") %>% 
             layout(title = 'Days Before Trending')
     })
  
         #Text Transformation
      
         output$word_freq_table <- DT::renderDataTable({
             datatable(d)
         })
         
         
         output$word_cloud <- renderPlot({
           
           set.seed(1234)
           wordcloud(words = d$word, freq = d$freq, min.freq = 1,
                     max.words=200, random.order=FALSE, rot.per=0.35, 
                     colors=c("chartreuse", "cornflowerblue", 
                              "darkorange","orchid2","lightpink1",
                              "sienna1","yellow1","tan3"))
         })
         
         
       
})







   
