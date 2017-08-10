# NEXT 3 LINES LOAD LIBRARIES OF FUNCTIONS
library(tm)
library(wordcloud)
library(RColorBrewer)

#innings <- unique(sim.baseball(2600, WAS, seed=1))
#freq <- round(exp(likes.baseball(innings,WAS))*2600)
innings <- unique(sim.baseball(2500, BAL, seed=1))
freq <- round(exp(likes.baseball(innings, BAL))*2500)
wordcloud(innings,freq,random.order=TRUE,colors='black')
#wordcloud(innings,freq,random.order=TRUE,colors=brewer.pal(8,'RdBu'))
