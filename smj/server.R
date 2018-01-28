server <- shinyServer(function(input, output, session) {
  # added "session" because updateSelectInput requires it
  
  
  data <- reactive({ 
    req(input$file1) ## ?req #  require that the input is available
    
    inFile <- input$file1 
    
    df <- readLines(inFile$datapath)
    
    return(df)
  })
  
  output$contents <- renderTable({
    data()
  })
  
  output$MyPlot <- renderPlot({
    
    #if(is.null(df)){return (NULL)}
    #data()
    
    #Read from chat history file
    texts = data();
    
    #texts <- readLines("samplechat.txt")
    text=texts;
    
    library("tm")
    library("SnowballC")
    library("wordcloud")
    library("RColorBrewer")
    library("syuzhet") 
    library("lubridate") 
    library("ggplot2")
    library("dplyr") 
    
    #fetch sentiment words from tweets
    mySentiment <- get_nrc_sentiment(texts)
    head(mySentiment)
    text <- cbind(texts, mySentiment)
    
    #count the sentiment words by category
    sentimentTotals <- data.frame(colSums(text[,c(2:11)]))
    names(sentimentTotals) <- "count"
    sentimentTotals <- cbind("sentiment" = rownames(sentimentTotals), sentimentTotals)
    rownames(sentimentTotals) <- NULL
    
    #total sentiment score of all texts
    x <- ggplot(data = sentimentTotals, aes(x = sentiment, y = count)) +
      geom_bar(aes(fill = sentiment), stat = "identity") +
      theme(legend.position = "none") +
      xlab("Sentiment") + ylab("Total Count") + ggtitle("Pedophilia analysis score")
    
    plot(x)
    
  })
  
  
})