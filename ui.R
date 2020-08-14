#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(wordcloud)

# Define the app ####

ui <- shinyUI(navbarPage("Next-Word Prediction App",
    tabPanel( "Prediction",                    
    fluidRow(
      column(12,align = "center",
             h3("Instructions",style = "color:darkred"),
             HTML("
  <p><strong>Dated: 13 Aug, 2020; Author: Satindra Kathania,Ph.D, mail_to:
  <a href='mailto:satindrak@gmail.com'>satindrak@gmail.com</a></p></strong>"),
             "The app need 5-10 sec to initialize, then start by entering your text in the input box below. 
              Once you click submit, the App will display a barplot with Top 10 predicted words according to backoff model score.
              This App also display the wordcloud for most predicted words. Click on 'Summary' for more details.
              This App also display the wordcloud for most predicted words.
              Note, currently this app only supports 'English' language.",
             br(),
             # Link to report
             a('More information on the project',
               href='https://rpubs.com/SatKat_2020/648814', 
               target = '_blank'),
             br(),
             
             # Link to repo
             a('Link to the GitHub Repository',
               href='https://github.com/SatK-ds2020/DS-capstone-project-2020',
               target = '_blank'),
             br(),
      )
     ),
    fluidRow(
            column(12,align = "center",
                      # Text input
                   tags$style(type="text/css", "textarea {width:80%}") ,
                   tags$textarea(id="text", rows=3, placeholder =  "Please enter your text...", ""),
                   tags$head(tags$style("#text{color: red;
                                 font-size: 20px;
                                 font-style: bold;
                                 }")),
                
                  # Submit button for making the prediction
                   submitButton("Submit")
                 
                 
                 )
    ),
                 
    fluidRow(
          column(12, 
            fluidRow(                    
                   column(6,
                 h3("Phrases to try",style = "color:darkred"),                 
                "[1] loved nine lives last night you cannot cancel	............. (the)", 
                br(),                                                                                                       
                " [2] fun i often wonder why..............(i) ",
                br(),
                 "[3]time chitchat continued commentators i suppose i.................	(should) ", 
                br(),
                 "[4] card for you today made with digital image...............	(from)" ,
                br(),  
                 "[5] to use flowers woohoo i am so...............(excited) ", 
                br(),
                 "[6] winner will be..........(announced) ", 
                br(),
                 "[7] grueling hour boot camps that cost per head has..............	(begun) ", 
                br(),
                 "[8] the front page philip orlando the new.............(york) " ,
                br(),
                 "[9] miles from downtown cleveland but look how................(far) ",
                br(),
                 "[10] developed fever while the..................(rest)  "
                 ),
                
                               
                  column(6, 
                         
                         h3("Top suggested Next Word:" ), 
                         
                         textOutput('text1'),
                         tags$head(tags$style("#text1{color: red;
                                 font-size: 30px;
                                 font-style: italic;
                                 }"))
                         
                      
                      ))
            )),
          
    fluidRow(
      column(12, 
             fluidRow( 
               column(6,  
                      h3("Top 10 Predicted Words",alignment="center"),
                      plotOutput("barchart")),
               column(6,      
                      h3("Wordcloud for the Predicted Words"),
                               plotOutput('wordcloud'))
                           ))
                  )
            ), #tabpanel
    
    
              
  tabPanel("Summary",
           h3("Information about the App", style = 'color:darkred'),
           HTML("<footer>
  <p>Author: Satindra Kathania,Ph.D, mail_to:
  <a href='mailto:satindrak@gmail.com'>satindrak@gmail.com</a></p>
</footer>
    <p style='color:darkblue'> 1. This is a NextWord Prediction App and is a part of Coursera Data Science Specialization-Capstone Project offered by John Hopkins University.
                                            This web app is inspired by Swiftkey, a predictive keyboard on smart phones.</p>
     <p style='color:darkblue'> 2. This app uses a text-prediction model based on N-gram frequency with 'stupid backoff algorithm'.
                                            The text you entered in the inputbox, it's  last four words will be used to predict the next word, for example, 
                                            if the sentence is <strong>'it happened for the first time'</strong> the words <strong>'for the first time'</strong> will be used 
                                            to predict next words.</p>
     <p style='color:darkblue'> 3. This prediction model uses 1-5 ngrams as dictionary to search,with a precalculated back-off score from highest to lowest frequency.
                                              The probability of next word is depends on the backoff score which is calculated by dividing the counts of matches found in ngram/n-1 gram 
                                              multiplied by **backoff factor= 0.4** with each droping n-grams</p>
                                       - First the search started with 5-grams model to match last 4 words of User Input and the most likely next word is predicted with highest score.<br>
                                              - If no suitable match is found in the 5-gram, the model search 'back's off' to a 4-gram, i.e. using the last three words, from the user provided phrase,
                                                to predict the next best match.<br>
                                              - If no 4-gram match is found, the model 'back's off' to a 3-gram, i.e. using the last two words from the user provided phrase, to predict a suitable match.<br>
                                              - If no bigram word is found, the model default 'back's off' to the highest frequency unigram word available.<br><br>
                                       
     <p style='color:darkblue'> 4. The general strategy for Building this predicitive language model is as followed:-</p>
                                       - Creating the large corpus with sampling and pooling the blogs, news, and twitter data with stop words.<br>
                                              - Cleaning the corpus and Building n-grams frequency tables, up to 5-grams. These frequency tables serve as frequency
                                                dictionaries for the predictive model to search for the match.<br>
                                              - Probability of a term is modeled based on the Markov chain assumption that the occurrence of a term is dependent on the preceding terms.<br>
                                              - Remove sparse terms, threshold is determined.<br>
                                              - Use a('backoff strategy', href='https://en.wikipedia.org/wiki/Katz%27s_back-off_model') to predict so that if the
                                                probability a quad-gram is very low, use tri-gram to predict, and so on.<br><br>
    <p style='color:darkblue'> 5. For more information about the project App and its code, please click on the hyperlinks available on previous page.However,
                                  for more details about NLP, prediction algorithms and its techniques, follow the below references: </p>
                                     
                                     
                   ")
           ),
  
  tabPanel("References",
           h3("More information on linguistic models", style = 'color:darkred'),
           HTML("
                <h3><p style='color:darkred'> References </p></h3>
      <strong>1.Large language models in machine translation</strong>, http://www.aclweb.org/anthology/D07-1090.pdf'<br> 
      <strong>2.Real Time Word Prediction Using N-Grams Model</strong>, IJITEE,ISSN: 2278-3075, Vol.8 Issue-5, 2019'<br>  
      <strong>3.Tokenizer: Introduction to the tokenizers R Package</strong>, https://cran.r-project.org/web/packages/tokenizers/'<br> 
     <strong>4.Smoothing and Backoff</strong>,'http://www.cs.cornell.edu/courses/cs4740/2014sp/lectures/smoothing+backoff.pdf'<br>
    <strong>5.N-gram Language Models</strong>,'https://web.stanford.edu/~jurafsky/slp3/ed3book.pdf'<br>
    <strong>6.Speech and Language Processing</strong>,'https://web.stanford.edu/class/cs124/lec/languagemodeling.pdf'<br>
  <strong>7.Katz’s back-off model, Wikipedia</strong>,https://en.wikipedia.org/wiki/Katz%27s_back-off_model'<br>
  <strong>8.Good-Turing frequency estimation, Wikipedia</strong>,'https://en.wikipedia.org/wiki/Good%E2%80%93Turing_frequency_estimation'<br>
   <strong>9.NLP Lunch Tutorial: Smoothing</strong>,'https://nlp.stanford.edu/~wcmac/papers/20050421-smoothing-tutorial.pdf'<br>
    <strong>10.Word Prediction Using Stupid Backoff With a 5-gram Language Model</strong>,' https://rpubs.com/pferriere/dscapreport'<br>
    <strong>11.Katz’s Backoff Model Implementation in R</strong>,'https://thachtranerc.wordpress.com/2016/04/12/katzs-backoff-model-implementation-in-r'<br>
<strong>12.NLP: Language Models</strong>,'https://www.csd.uwo.ca/courses/CS4442b/L9-NLP-LangModels.pdf'<br>
                 ")
           )
    )
 
)
