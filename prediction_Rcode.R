## prediction_Rcode.R

Match1 <- read_csv("Match1.csv", col_types = cols(Var1 = col_character(), Freq = col_double(), predicted_word = col_character(), score = col_double()))
Match2 <- read_csv("Match2.csv", col_types = cols(bigram = col_character(), c_bigram = col_double(), OneG = col_character(), c_OneG = col_double(), score = col_double(),predicted_word = col_character()))
Match3 <- read_csv("Match3.csv", col_types = cols(trigram = col_character(), c_trigram = col_double(), TwoG = col_character(), c_TwoG = col_double(),score = col_double(), predicted_word = col_character()))
Match4 <- read_csv("Match4.csv", col_types = cols(quadgram = col_character(), c_quadgram = col_double(), ThreeG = col_character(), c_ThreeG = col_double(), score = col_double(),predicted_word = col_character()))
Match5 <- read_csv("Match5.csv", col_types = cols(pentagram = col_character(), c_pentagram = col_double(), fourG = col_character(), c_fourG = col_double(),score = col_double(), predicted_word = col_character()))


removenon_engwords <-function(x)gsub(pattern = "\\W+"," ",x)# function to remove which are not numbers or letters

# Cleaning Function 
cleanInput <- function(textInput){
  textInput <- tolower(textInput)
  textInput <- removePunctuation(textInput)
  textInput <- removeNumbers(textInput)
  textInput <- removenon_engwords(textInput)
  textInput <- str_replace_all(textInput, "[^[:alnum:]]", " ")
  textInput <- stripWhitespace(textInput)
  textInput <-str_split(textInput,pattern = "\\s+") # spliting the words
  textInput <-unlist(textInput)
  
  return(textInput)
}

# 3.Predict next word Function takes in the input variable from user and predicts the next word


predictNextWord <- function(textInput)
{
  
  textInput <- cleanInput(textInput)
  
  #If the text input is 4 words
  if (length(textInput) >= 4) {
    #start with 5-Gram Model
    # extracting last 4 words from input
    textInput4 <- paste(tail(textInput, 4), collapse = " ")
    predict5 <-Match5[Match5$fourG == textInput4,]
    predict5<- mutate(predict5,score5 = score)
    predict5 <- predict5[order(-predict5$score5),]
    predict5 <- select(predict5,predicted_word,score5)
   # head(predict5,10)
    
    # drop to 4-Gram Model
    textInput3 <- paste(tail(textInput, 3), collapse = " ")
    predict4 <- Match4[Match4$ThreeG==textInput3,]
    predict4<- mutate(predict4, score4 = 0.4*score)
    predict4 <- predict4[order(-predict4$score4),]
    predict4 <- select(predict4,predicted_word,score4)
   # head(predict4,10)
    
    
    #3-Gram Model
    textInput2 <- paste(tail(textInput, 2), collapse = " ")
    predict3 <- Match3[Match3$TwoG==textInput2,]
    predict3<- mutate(predict3, score3 = 0.4^2*score)
    predict3 <- predict3[order(-predict3$score3),]
    predict3 <- select(predict3,predicted_word,score3)
   # head(predict3,10)
    
    
    #2-Gram Model
    textInput1 <- paste(tail(textInput, 1), collapse = " ")
    predict2 <- Match2[Match2$OneG==textInput1,]
    predict2<- mutate(predict2, score2 = 0.4^3*score)
    predict2 <- predict2[order(-predict2$score2),]
    predict2 <- select(predict2,predicted_word,score2)
   # head(predict2,10)
    
    
    #1-Gram Model
    predict1<- Match1 %>% mutate(score1 = 0.4^4*score)
    predict1 <- predict1[order(-predict1$score1),]
    predict1 <- select(predict1,predicted_word,score1)
    head(predict1,10)
    
    
    # combining all the predictions from each grams
    Pred <- merge(predict5, predict4, by.x = 'predicted_word',by.y = 'predicted_word',all = T,stringsAsFactors = FALSE)
    Pred <- merge(Pred, predict3, by.x = 'predicted_word',by.y = 'predicted_word', all = T,stringsAsFactors = FALSE)
    Pred <- merge(Pred, predict2, by.x = 'predicted_word',by.y = 'predicted_word', all = T,stringsAsFactors = FALSE)
    Pred <- merge(Pred, predict1, by.x = 'predicted_word',by.y = 'predicted_word', all = T,stringsAsFactors = FALSE)
    head(Pred)
    Pred[is.na(Pred)] <- 0
    Pred["Score"] <- rowSums(Pred[, 2:5])
    Pred <- arrange(Pred,desc(score5), desc(score4), desc(score3), desc(score2),desc(score1))
    #Pred <- arrange(Pred,desc(score5), desc(score4), desc(score3), desc(score2))
    Final_Pred<-data.frame(Pred)
    Final_Pred<- select(Final_Pred,predicted_word,Score)
    colnames(Final_Pred)<- c("Predicted_word","Score")
    
      return (head(Final_Pred,100))
    
  } else if (length(textInput) == 3) {  
    
    #start with 4-gram model extracting last Three words
    
    #4-Gram Model
    textInput3 <- paste(tail(textInput, 3), collapse = " ")
    predict4 <- Match4[Match4$ThreeG==textInput3,]
    predict4<- mutate(predict4, score4 = score)
    predict4 <- predict4[order(-predict4$score4),]
    predict4 <- select(predict4,predicted_word,score4)
   # head(predict4,10)
    
    #3-Gram Model
    textInput2 <- paste(tail(textInput, 2), collapse = " ")
    predict3 <- Match3[Match3$TwoG==textInput2,]
    predict3<- mutate(predict3, score3 = 0.4*score)
    predict3 <- predict3[order(-predict3$score3),]
    predict3 <- select(predict3,predicted_word,score3)
   # head(predict3,10)
    
    #2-Gram Model
    textInput1 <- paste(tail(textInput, 1), collapse = " ")
    predict2 <- Match2[Match2$OneG==textInput1,]
    predict2<- mutate(predict2, score2 = 0.4^2*score)
    predict2 <- predict2[order(-predict2$score2),]
    predict2 <- select(predict2,predicted_word,score2)
   # head(predict2,10)
    
    #1-Gram Model
  predict1<- Match1 %>% mutate(score1 = 0.4^3*score)
  predict1 <- predict1[order(-predict1$score1),]
  predict1 <- select(predict1,predicted_word,score1)
   # head(predict1,10)
    
    Pred <- merge(predict4, predict3, by.x = 'predicted_word',by.y = 'predicted_word',all = T,stringsAsFactors = FALSE)
    Pred <- merge(Pred, predict2, by.x = 'predicted_word',by.y = 'predicted_word', all = T,stringsAsFactors = FALSE)
    Pred <- merge(Pred, predict1, by.x = 'predicted_word',by.y = 'predicted_word', all = T,stringsAsFactors = FALSE)
    
    Pred[is.na(Pred)] <- 0
    Pred["Score"] <- rowSums(Pred[, 2:5])
    Pred <- arrange(Pred, desc(score4), desc(score3), desc(score2),desc(score1))
    Final_Pred<-data.frame(Pred)
    Final_Pred<- select(Final_Pred,predicted_word,Score)
    colnames(Final_Pred)<- c("Predicted_word","Score")
    
      return (head(Final_Pred,100))
    
    
  } else if (length(textInput) == 2) {
    
    #start with 3-Gram Model and extract with last 2 words
    textInput2 <- paste(tail(textInput, 2), collapse = " ")
    predict3 <- Match3[Match3$TwoG==textInput2,]
    predict3<- mutate(predict3, score3 = score)
    predict3 <- predict3[order(-predict3$score3),]
    predict3 <- select(predict3,predicted_word,score3)
   # head(predict3,10)
    
    #2-Gram Model
    textInput1 <- paste(tail(textInput, 1), collapse = " ")
    predict2 <- Match2[Match2$OneG==textInput1,]
    predict2<- mutate(predict2, score2 = 0.4*score)
    predict2 <- predict2[order(-predict2$score2),]
    predict2 <- select(predict2,predicted_word,score2)
    #head(predict2,10)
    
    #1-Gram Model
    predict1<- Match1 %>% mutate(score1 = 0.4^2*score)
    predict1 <- predict1[order(-predict1$score1),]
    predict1 <- select(predict1,predicted_word,score1)
   # head(predict1,10)
    
    Pred <- merge(predict3, predict2, by.x = 'predicted_word',by.y = 'predicted_word',all = T,stringsAsFactors = FALSE)
    Pred <- merge(Pred, predict1, by.x = 'predicted_word',by.y = 'predicted_word', all = T,stringsAsFactors = FALSE)
    
    Pred[is.na(Pred)] <- 0
    Pred["Score"] <- rowSums(Pred[, 2:4])
    Pred <- arrange(Pred, desc(score3), desc(score2),desc(score1))
    Final_Pred<-data.frame(Pred)
    Final_Pred<- select(Final_Pred,predicted_word,Score)
    colnames(Final_Pred)<- c("Predicted_word","Score")
   
      return (head(Final_Pred,100))
    
    
  }else if (length(textInput) == 1) {
    #start with 2-Gram Model
  textInput1 <- paste(tail(textInput, 1), collapse = " ")
  predict2 <- Match2[Match2$OneG==textInput1,]
  predict2<- mutate(predict2, score2 = score)
  predict2 <- predict2[order(-predict2$score2),]
  predict2 <- head(select(predict2,predicted_word,score2),10)
 # head(predict2,10)
  
  #1-Gram Model
  predict1<- Match1 %>% mutate(score1 = 0.4*score)
  predict1 <- predict1[order(-predict1$score1),]
  predict1 <- select(predict1,predicted_word,score1)
  #head(predict1,10)
  
  Pred <- merge(predict2, predict1, by.x = 'predicted_word',by.y = 'predicted_word',all = T,stringsAsFactors = FALSE)
  Pred[is.na(Pred)] <- 0
  Pred["Score"] <- rowSums(Pred[, 2:3])
  Pred <- arrange(Pred,desc(score2), desc(score1))
  Final_Pred<-data.frame(Pred)
  Final_Pred<- select(Final_Pred,predicted_word,Score)
  colnames(Final_Pred)<- c("Predicted_word","Score")
  
    
    return(head(Final_Pred,100))
  
  } else (length(textInput)==0)
  
  paste("hello try me")
 
 
}
