# cleanfunction.R
setwd("~/Desktop/DS notes/NLP capstone/DS capstone/DS capstone")

# download the profanity file from working directory
Path.P<- "~/Desktop/DS notes/NLP capstone/DS capstone/DS capstone/bad-words.txt"
profanity <- as.vector(readLines(Path.P))

extra <- c( "rt","re","aa","aaa","aaaa","ab","aabb","zz","zzz","ve","lol","em","im","gr","en","el", "st",
            "a m","p m", "u.s","d","nt","ld", "p.m","yr","ah","aahh", "a.m","ol","mr", "dr", "ll", "ur", "omg",
            "co", "oh", "ha", "haha", "na", "la","se","coz","aahahaha","a","b","c","d","e","f","g","h","j","k",
            "l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")

# Cleaning the corpus

#1. transform all text into lower-case text
corpus <- tm_map(corpus, content_transformer(tolower))
#2. remove potentially offensive words
corpus <- tm_map(corpus, removeWords, profanity)
corpus <- tm_map(corpus, removeWords, extra)
#3. remove  repetitive characters 
# i iterate this step with so many possible repetitive words combinations that were present in corpus,
# so i entered the different repetitive character patterns and clean it
rep<-function(x)str_replace_all(x, "[a-z]+([a-z])\\1{2,}", " ")
rep1<- function(x)str_replace_all(x, "\\b\\w*^([a-z])(\\1{2,})\\w*\\b"," ")

rep2<- function(x)str_replace_all(x,"\\b\\w*([abb])(\\1{2,})$\\w*\\b"," ")
corpus <- tm_map(corpus, content_transformer(rep2))

corpus <- tm_map(corpus, content_transformer(rep))
corpus <- tm_map(corpus, content_transformer(rep1))


#4. removing URLs
url1<-function(x)str_replace_all(x, "http[[:alnum:]]*", " ")
url2<-function(x)str_replace_all(x, "http(.*?) "," ")
url3<-function(x)str_replace_all(x, "http(.*)"," ")
url4<-function(x)str_replace_all(x, "http(.*)\\."," ")
url5<-function(x)str_replace_all(x, "www\\.(.*?) "," ")
url6<-function(x)str_replace_all(x, "www\\.(.*)"," ")
url7<-function(x)str_replace_all(x, "www\\.(.*)\\."," ")

corpus <- tm_map(corpus, content_transformer(url1))
corpus <- tm_map(corpus, content_transformer(url2))
corpus <- tm_map(corpus, content_transformer(url3))
corpus <- tm_map(corpus, content_transformer(url4))
corpus <- tm_map(corpus, content_transformer(url5))
corpus <- tm_map(corpus, content_transformer(url6))
corpus <- tm_map(corpus, content_transformer(url7))

#5. removing hashtags
hashtag1<-function(x)str_replace_all(x, "#[[:alnum:]]*", " ")
hashtag2<-function(x)str_replace_all(x, "# [[:alnum:]]*", " ")
hashtag3<-function(x)str_replace_all(x, "\\#(.*?) ", " ")
hashtag4<-function(x)str_replace_all(x, "\\#(.*)", " ")
hashtag5<-function(x)str_replace_all(x, "\\#(.*)\\.", " ")

corpus <- tm_map(corpus, content_transformer(hashtag1))
corpus <- tm_map(corpus, content_transformer(hashtag2))
corpus <- tm_map(corpus, content_transformer(hashtag3))
corpus <- tm_map(corpus, content_transformer(hashtag4))
corpus <- tm_map(corpus, content_transformer(hashtag5))


#6. removing e-mail and @
mail1<-function(x)str_replace_all(x, "\\S+@\\S+", " ") 
mail2<-function(x)str_replace_all(x, "@[[:alnum:]]*", " ")
mail3<-function(x)str_replace_all(x, "@ [[:alnum:]]*", " ")

corpus <- tm_map(corpus, content_transformer(mail1))
corpus <- tm_map(corpus, content_transformer(mail2))
corpus <- tm_map(corpus, content_transformer(mail3))

#7. removing twitter language
lang1<-function(x)str_replace_all(x, "RT", "")
lang2<-function(x)str_replace_all(x, "PM", "")
lang3<-function(x)str_replace_all(x, "rt", "")
lang4<-function(x)str_replace_all(x, "pm", "") 

corpus <- tm_map(corpus, content_transformer(lang1))
corpus <- tm_map(corpus, content_transformer(lang2))
corpus <- tm_map(corpus, content_transformer(lang3))
corpus <- tm_map(corpus, content_transformer(lang4))

#8. modify apostrophes
apos1<-function(x)str_replace_all(x, "'ll", " will")
apos2<-function(x)str_replace_all(x, "'d", " would")
apos3<-function(x)str_replace_all(x, "can't", "cannot") 
apos4<-function(x)str_replace_all(x, "n't", " not")
apos5<-function(x)str_replace_all(x, "'re", " are")
apos6<-function(x)str_replace_all(x, "'m", " am")
apos7<-function(x)str_replace_all(x, "n'", " and") 
apos8<-function(x)str_replace_all(x, "n'", " and")

corpus <- tm_map(corpus, content_transformer(apos1))
corpus <- tm_map(corpus, content_transformer(apos2))
corpus <- tm_map(corpus, content_transformer(apos3))
corpus <- tm_map(corpus, content_transformer(apos4))
corpus <- tm_map(corpus, content_transformer(apos5))
corpus <- tm_map(corpus, content_transformer(apos6))
corpus <- tm_map(corpus, content_transformer(apos7))
corpus <- tm_map(corpus, content_transformer(apos8))


#9. remove s-genitive
s1<-function(x)str_replace_all(x, "'s", " ")
s2<-function(x)str_replace_all(x, "s'", " ")

corpus <- tm_map(corpus, content_transformer(s1))
corpus <- tm_map(corpus, content_transformer(s2))

#10. remove symbols
symbol1<-function(x)str_replace_all(x,"\\!|\\£|\\$|\\%|\\^|\\'", " ")
symbol2<-function(x)str_replace_all(x,"\\*|\\(|\\)|\\-|\\_", " ")
symbol3<-function(x)str_replace_all(x,"\\{|\\}|\\[|\\]|\\+|\\=", " ")
symbol4<-function(x)str_replace_all(x,"\\:|\\;|\\@|\\~|<|>|\\.|,", " ") 
symbol5<-function(x)str_replace_all(x,"\\||\\¬|\\`|\\?|\\/|\\\\", " ")

corpus <- tm_map(corpus, content_transformer(symbol1))
corpus <- tm_map(corpus, content_transformer(symbol2))
corpus <- tm_map(corpus, content_transformer(symbol3))
corpus <- tm_map(corpus, content_transformer(symbol4))
corpus <- tm_map(corpus, content_transformer(symbol5))


#11. everything that is not number or letter
punc1<-function(x)str_replace_all(x, "[^[:alnum:]]", " ")
punc2<-function(x)str_replace_all(x, "[[:punct:]]", " ")

corpus <- tm_map(corpus, content_transformer(punc1))
corpus <- tm_map(corpus, content_transformer(punc2))
corpus<- tm_map(corpus, content_transformer(removePunctuation))

#12. remove digits or numbers
digit<-function(x)str_replace_all(x, "[:digit:]", "")
corpus <- tm_map(corpus, content_transformer(digit))
corpus<- tm_map(corpus, content_transformer(removeNumbers))

# modifying commonly used words after removing apostrophes
replace1<- function(x)str_replace_all(x," thats |^thats |^that s | that s ","that is")
replace2<- function(x)str_replace_all(x," whys |^whys |^why s | why s ","why is")
replace3<- function(x)str_replace_all(x," whens |^whens |^when s | when s","when is")
replace4<- function(x)str_replace_all(x," wheres |^wheres |^where s | where s ","where is")
replace5<- function(x)str_replace_all(x," hows |^hows |^how s | how s  ","how is")

corpus <- tm_map(corpus, content_transformer(replace1))
corpus <- tm_map(corpus, content_transformer(replace2))
corpus <- tm_map(corpus, content_transformer(replace3))
corpus <- tm_map(corpus, content_transformer(replace4))
corpus <- tm_map(corpus, content_transformer(replace5))

replace6<- function(x)str_replace_all(x," whos |^whos |^who s | who s ","who is")
replace7<- function(x)str_replace_all(x," whats |^whats |^what s | what s ","what is")
replace8<- function(x)str_replace_all(x," shouldn t |^shouldn t | shouldnt |^shouldnt ","should not")
replace9<- function(x)str_replace_all(x," wouldn t |^wouldn t | wouldnt |^wouldnt ","whould not")
replace10<- function(x)str_replace_all(x," couldn t |^couldn t | couldnt |^couldnt ","could not")

corpus <- tm_map(corpus, content_transformer(replace6))
corpus <- tm_map(corpus, content_transformer(replace7))
corpus <- tm_map(corpus, content_transformer(replace8))
corpus <- tm_map(corpus, content_transformer(replace9))
corpus <- tm_map(corpus, content_transformer(replace10))

replace11<- function(x)str_replace_all(x," can t | ^can t | cant |^cant ","can not")
replace12<- function(x)str_replace_all(x," let s |^let s | lets |^lets ","let us")
replace13<- function(x)str_replace_all(x," can t | ^can t | cant |^cant ","can not")
replace14<- function(x)str_replace_all(x," wasnt |^wasnt | wasn t |^wasn t ","was not")
replace15<- function(x)str_replace_all(x," isnt |^isnt | isn t |^isn t ","is not")

corpus <- tm_map(corpus, content_transformer(replace11))
corpus <- tm_map(corpus, content_transformer(replace12))
corpus <- tm_map(corpus, content_transformer(replace13))
corpus <- tm_map(corpus, content_transformer(replace14))
corpus <- tm_map(corpus, content_transformer(replace15))

replace16<- function(x)str_replace_all(x," didn t | didnt |^didn t |^didnt  ","did not")
replace17<- function(x)str_replace_all(x," doesn t | doesnt |^doesn t |^doesnt ","does not")
replace18<- function(x)str_replace_all(x," don t | dont |^don t |^dont ","do not")
replace19<- function(x)str_replace_all(x," he s |^he s | hes |^hes","he is")
replace20<- function(x)str_replace_all(x," she s |^she s | shes |^shes","she is")

corpus <- tm_map(corpus, content_transformer(replace16))
corpus <- tm_map(corpus, content_transformer(replace17))
corpus <- tm_map(corpus, content_transformer(replace18))
corpus <- tm_map(corpus, content_transformer(replace19))
corpus <- tm_map(corpus, content_transformer(replace20))


replace21<- function(x)str_replace_all(x," it s |^it s|its|^its","it is")
replace22<- function(x)str_replace_all(x," we re |^we re|we're|^we're","we are")
replace23<- function(x)str_replace_all(x," they re |^they re | theyre |^theyre","they are")
replace24<- function(x)str_replace_all(x," you re |^you re | youre |^youre","you are")
replace25<- function(x)str_replace_all(x," I d |^I d | I d$|I d$","I would")

corpus <- tm_map(corpus, content_transformer(replace21))
corpus <- tm_map(corpus, content_transformer(replace22))
corpus <- tm_map(corpus, content_transformer(replace23))
corpus <- tm_map(corpus, content_transformer(replace24))
corpus <- tm_map(corpus, content_transformer(replace25))

 
replace26<- function(x)str_replace_all(x," i m |^i m | I m |^I m |I m$","I am")
# replace27<- function(x)str_replace_all(x," i |^i | i$|^i$","I")
replace28<- function(x)str_replace_all(x, "u s", "usa")

corpus <- tm_map(corpus, content_transformer(replace26))
# corpus <- tm_map(corpus, content_transformer(replace27))
corpus <- tm_map(corpus, content_transformer(replace28))

# 13. more then one whitespace
whtspc1<-function(x)str_replace_all(x, "\\s+", " ")
whtspc2<-function(x)str_trim(x, side=c("both")) 

corpus <- tm_map(corpus, content_transformer(whtspc1))
corpus <- tm_map(corpus, content_transformer(whtspc2))
corpus <- tm_map(corpus, stripWhitespace)
# saving the clean corpus
saveRDS(corpus,file="clean_corpus1.rds")
corpus<-readRDS("clean_corpus1.rds")

 

