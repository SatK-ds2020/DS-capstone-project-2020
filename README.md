# DS-capstone-project-2020

This is a NextWord Prediction App and is a part of Coursera Data Science Specialization-Capstone Project offered by John Hopkins University. This web app is inspired by Swiftkey, a predictive keyboard on smart phones.

This app uses a text-prediction model based on N-gram frequency with ‘stupid backoff algorithm’. The text you entered in the inputbox, it’s last four words are used to predict the next word, for example, if the sentence is ‘in my life, for the first time’ the words ‘for the first time’ will be used to predict next words.

This prediction model uses 1-5 ngrams as dictionary to search,with a precalculated back-off score from highest to lowest frequency.The probability of next word is depends on the backoff score which is calculated by dividing the counts of matches found in ngram/n-1 gram multiplied by back off factor= 0.4 with each droping n-grams

First the search started with 5-grams model to match last 4 words of User Input and the most likely next word is predicted with highest score.
If no suitable match is found in the 5-gram, the model search ‘back’s off’ to a 4-gram, i.e. using the last three words, from the user provided phrase, to predict the next best match.
If no 4-gram match is found, the model ‘back’s off’ to a 3-gram, i.e. using the last two words from the user provided phrase, to predict a suitable match.
If no bigram word is found, the model default ‘back’s off’ to the highest frequency unigram word available.
The general strategy for Building this predicitive language model is as followed:-

Creating the large corpus with sampling and pooling the blogs, news, and twitter data with stop words.
Cleaning the corpus and Building n-grams frequency tables, up to 5-grams. These frequency tables serve as frequency dictionaries for the predictive model to search for the match.
Probability of a term is modeled based on the Markov chain assumption that the occurrence of a term is dependent on the preceding terms.
Remove sparse terms, threshold is determined.
Use a 'backoff strategy',  to predict so that if the probability a quad-gram is very low, use tri-gram to predict, and so on
For more information about the project App and its code, please click on the hyperlinks available on previous page.However,for more detials about NLP and prediction algorithms and techniques, follow the below references:

Pitch presentation about my Shiny App is published at RPubs: https://rpubs.com/SatKat_2020/648587

Final Data Science capstone Report is published at Rpubs:https://rpubs.com/SatKat_2020/648871

Data Science capstone Report I is published at Rpubs:https://rpubs.com/SatKat_2020/625734

The web app is hosted at: https://satindrakathania-2020.shinyapps.io/ShinyCapstone/

The complete code is available at Github: https://github.com/SatK-ds2020/DS-capstone-project-2020

References
1.Smoothing and Backoff,‘http://www.cs.cornell.edu/courses/cs4740/2014sp/lectures/smoothing+backoff.pdf’
2.N-gram Language Models,‘https://web.stanford.edu/~jurafsky/slp3/ed3book.pdf’
3.Speech and Language Processing,‘https://web.stanford.edu/class/cs124/lec/languagemodeling.pdf’
4.Katz’s back-off model, Wikipedia,https://en.wikipedia.org/wiki/Katz%27s_back-off_model‘
5.Good-Turing frequency estimation, Wikipedia,’https://en.wikipedia.org/wiki/Good%E2%80%93Turing_frequency_estimation’
