

shinyUI(
    dashboardPage(
    dashboardHeader(title = "Youtube Statistics",
                    titleWidth = 250
                    ),
    dashboardSidebar(
        width = 250,
        
        sidebarUserPanel("Precious Chima",image = "https://media.licdn.com/dms/image/C5603AQGOoGcqWeE8NA/profile-displayphoto-shrink_200_200/0?e=1569456000&v=beta&t=NGLbZMbLNYCmKynlv3nL_ACdag5HCQe9PujWQgCJoak"),
        sidebarMenu(
            menuItem("About", tabName = "about", icon = icon("address-card")),
            menuItem("Data", tabName = "data", icon = icon("database")),
            menuItem("Views", tabName = "views", icon = icon("eye")),
            menuItem("Trending", tabName = "trending", icon = icon("avianex")), 
            menuItem("Text Mining", tabName = "text_mining", icon = icon("comment-dots"))
            # menuItem("Tables", tabName = "tables", icon = icon("file-excel")),
           
             
            # menuItem("Likes", tabName = "likes", icon = icon("thumbs-up")),
            
        )
       
    ),
    dashboardBody(
        
        tabItems(  
            ###About tab###
            tabItem(tabName = "about",
                    fluidRow(
                        column(width = 6, 
                               box(height = 950, 
                                   title = h2(strong("Overview")), width = NULL, solidHeader = TRUE, background = "navy", 
                                   tags$h4("This project takes a deep dive into what it means for a Youtube video to be considered 'viral', and examines successful keywords in high trending videos.The dataset includes
                                   data on daily trending Youtube videos in the United States. There is an accompanying J.SON file that includes a category_id field. Areas of concentration are include but not limited to:
                                  "),
                                   br(),
                                   
                                   tags$ol(
                                       h4(tags$li("Text mining of video titles.")),
                                       h4(tags$li("Trending Videos.")),
                                       h4(tags$li("Statistical Analyses")),
                                       h4(tags$li("Impact of Views and Likes."))
                                   ),
                                   br(),
                                   tags$h4("'YouTube (the world-famous video sharing website) maintains a list of the top trending videos on the platform. According to Variety magazine, “To determine the year’s top-trending videos, YouTube uses a combination of factors including measuring users interactions (number of views, shares, comments and likes). Note that they’re not the most-viewed videos overall for the calendar year”. Top performers on the YouTube trending list are music videos (such as the famously virile “Gangam Style”), celebrity and/or reality TV performances, and the random dude-with-a-camera viral videos that YouTube is well-known for.

This dataset is a daily record of the top trending YouTube videos."),
                                   HTML('<center><img src = "https://static.onecms.io/wp-content/uploads/sites/38/2017/11/12230942/shutterstock_558937759.jpg" width ="75%"></center>'),
                                   
                                   
                                   tags$h4("Figure. Youtube Video Illustration", align = "center")
                                   
                                   )
                        ), 
                        column(width = 6,
                               box(height = 500,
                                   title = h2(strong("Summary of Findings")), width = NULL, solidHeader = TRUE, background = "navy",
                                   tags$ol(
                                       h4(tags$li("The results show that high trending videos generally start trending between two and 5 days.")),
                                       h4(tags$li("The results also show that 'trailer' & 'video' are the were the most frequently used title.")),
                                       h4(tags$li("ESPN has the highest number of trending videos.")),
                                       h4(tags$li("Music is the most viewed category amongst Youtube videos.")),
                                       h4(tags$li("The results show that high trending videos generally start trending between two and 5 days.")),
                                       h4(tags$li("Two of the of the top-5 disliked channels on average, also appear on the average top-5 most liked videos on average."))
                                      
                                       
                                   )
                               ),
                               box(height = 400,
                                   title = h2(strong("Data Source")), width = NULL, background = "navy",
                                   h4("The data used for this study were obtained from the following sources:"),
                                   tags$ol(
                                      h4(tags$li("Kaggle (https://www.kaggle.com/datasnaek/youtube-new)"))
                                       
                                   )
                               )
                        )
                    )
            ),
            tabItem(tabName ="data",
                        fluidRow(
                            column(4,
                                   selectInput("categories",
                                               "Category:",
                                               c("All",
                                                 unique(as.character(us_videos$categories))))
                            ),
                            column(4,
                                   selectInput("channel_title",
                                               "Channel Title:",
                                               c("All",
                                                 unique(as.character(us_videos$channel_title))))
                            )
                        ),
                    DT::dataTableOutput("tab_us_videos")),
                    
            tabItem(tabName ="views",
                        fluidRow( 
                            column(width = 12, 
                                solidHeader = TRUE, status = NULL, plotlyOutput("tot_views_per_cat", height = 600))
                            ),
                        fluidRow(
                            box(width = 12, 
                                solidHeader = TRUE, status = NULL, plotlyOutput("avg_views_per_cat", height = 600))
                    )),
        
            tabItem(tabName ="trending",
                    
                    fluidRow(
                        box(width = 12, 
                            solidHeader = TRUE, status = NULL, plotlyOutput("most_trend_chan", height = 600)),
                        
                        fluidRow(
                            box(width = 12, 
                                solidHeader = TRUE, status = NULL, plotlyOutput("days_till_trend", height = 600))
                    )
                 )
        
        ),
        tabItem(tabName = "text_mining",
                fluidRow(
                    
                    box(DT::dataTableOutput("word_freq_table"),
                        width = 12,
                        status = "warning",
                        solidHeader = TRUE)
                ),
                fluidRow(
                    box(width = 12, 
                        solidHeader = TRUE, status = NULL, plotOutput("word_cloud", height = 600))
        ))
        
        ))
))






