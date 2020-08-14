#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# attach the libraries:
suppressMessages(library(shiny))
suppressMessages(library(ggplot2))
suppressMessages(library(wordcloud))
suppressMessages(library(RColorBrewer))
suppressMessages(library(tm))
suppressMessages(library(dplyr))
suppressMessages(library(readr))
suppressMessages(library(stringr))
suppressMessages(library(data.table))
suppressMessages(library(tidyr))




shinyServer(function(input, output) {

  # 1.source prediction algorithm based on backoff score tables


source("prediction_Rcode.R")



    
    output$table<-renderDataTable({
        
        textInput<-input$text
        result<-predictNextWord(textInput = input$text)
        colnames(result)<-c("Predicted_word","Score")
        result[1:20,]
    })
    
    output$text1<-renderText({
    textInput<-input$text
    result<-predictNextWord(textInput = input$text)
    colnames(result)<-c("Predicted_word","Score")
    word1<-head(result$Predicted_word,1)
    word1
  })
    
    output$barchart <- renderPlot({
        
        textInput<-input$text
        result<-predictNextWord(textInput = input$text)
        result<-as.data.frame.array(result)
        ifelse(nrow(result>=5), result2<-head(result,10))
        colnames(result2)<-c("Predicted_word","Score")
        #result2[Score]<-as.character(result2$Predicted_word)
        #result2$Predicted_word<-factor(result2$Predicted_word, levels=c(rev(levels)), labels=c(rev(levels)))# making a factor with character levels displayed
        p<-ggplot(data=result2, aes(x=as.character(Predicted_word), y=Score))
        p<-p+ geom_bar(stat="identity", fill="darkred")+labs(x = "Predicted Words", y = "Backoff Score")+
          theme(axis.line.x = element_line(color="black", size = 1),
                axis.line.y = element_line(color="black", size = 1),
                axis.title.x= element_text(face="bold",size=16),
                axis.title.y= element_text(face="bold",size=16),
                axis.text.x =element_text(face="bold",size=16,angle = 45,hjust = 1),
                axis.text.y =element_text(face="bold",size=16),
                legend.position = "none") 
        
        p
    })        
    wordcloud_pred <- repeatable(wordcloud)
    
    output$wordcloud <- renderPlot({
       
        textInput<-input$text
        result<-predictNextWord(textInput = input$text)
        result$Score<-as.numeric(as.character(result$Score))
        result$Predicted_word<-as.character(result$Predicted_word)
        wordcloud_pred(words=result$Predicted_word, freq=result$Score,scale=c(4,1),
                       colors=brewer.pal(8, "Dark2"), rot.per = 0.2,max.words=80,min.freq=0)
   
    
  }) 
    
})

