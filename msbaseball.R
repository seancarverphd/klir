# msbaseball.R:
# Script written by Sean Carver, Professorial Lecturer
# American University.
#
# This script Calls FindTransMat() function 
#   coded in script "simulation.R," written by Rebeca Berger, 
#   class of 2017, American University.
#   simulation.R uses data and code from Marchi & Albert.
#   See: https://github.com/maxtoki/baseball_R
#   Citation: Max Marchi and Jim Albert (2013), 
#             Analyzing Baseball With R, CRC Press.
#

# More Readable State Names Than Used in Marchi & Albert
# Code without final 3-out state XXX, needed for rows:
newcode <- function() {
  return(c("0|","0X|","0XX|",
           "3|","3X|","3XX|",
           "2|","2X|","2XX|",
           "23|","23X|","23XX|",
           "1|","1X|","1XX|",
           "13|","13X|","13XX|",
           "12|","12X|","12XX|",
           "123|","123X|","123XX|"))
}

# Code with final 3-out state, needed for columns:
newcodeXXX <- function() {
  return(c(newcode(), "XXX"))
}

FindTeams <- function(AllTeamData) {
  TeamAbbr <- c()
  for (k in 1:length(AllTeamData)) { }
    TeamAbbr <- c(TeamAbbr, substr(AllTeamData$GAME_ID,1,3))  
  return(levels(factor(TeamAbbr)))
}

# FindTransMat <- function(AllTeamData, HomeTeam="NYA"){
  
TransMatList <- function(AllTeamData) {
  Teams <- FindTeams(AllTeamData)
  TMList <- list()
  k <- 1
  for (team in Teams) {
    TM <- FindTransMat(AllTeamData,team)
    row.names(TM)<-newcode()
    colnames(TM)<-newcodeXXX()
    TMList[[k]] <- TM
    k <- k + 1
  }
  names(TMList) <- Teams
  return(TMList)
}

# Transition Matrices:
WAS <- FindTransMat(data2011C,"WAS") # Washington Nationals
BAL <- FindTransMat(data2011C,"BAL") # Baltimore Orioles
NYA <- FindTransMat(data2011C,"NYA") # New York Yankees

# Assign new codes to transition matrices:
row.names(WAS)<-newcode()
colnames(WAS)<-newcodeXXX()
row.names(BAL)<-newcode()
colnames(BAL)<-newcodeXXX()
row.names(NYA)<-newcode()
colnames(NYA)<-newcodeXXX()

# Baseball simulator
sim.baseball <- function(n, transition.matrix, seed=FALSE) {
  if (!identical(seed, FALSE)) {
    set.seed(seed)
  }
  half.innings <- c()
  for (k in 1:n) {
    state <- "0|"
    one.half.inning <- state
    while (state != "XXX") {
      probabilities <- transition.matrix[state,]
      new.state <- sample(names(probabilities),1,prob=probabilities)
      one.half.inning <- paste(one.half.inning, new.state, sep="")
      state <- new.state
    }
    half.innings <- c(half.innings, one.half.inning)
  }
  return (half.innings)
}

# Get the states that a half inning passes through
getStates <- function(one.half.inning) {
  states <- strsplit(one.half.inning,"\\|")
  for (k in 1:length(states[[1]])-1) {
    states[[1]][k] <- paste(states[[1]][k],"|",sep="")
  }
  return (states)
}

# Get the transitions that a half inning undergoes
getTransitions <- function(one.half.inning) {
  states <- getStates(one.half.inning)
  transitions <- list()  # Initialize transitions as an empty list
  number.of.transitions <- length(states[[1]])-1
  for (k in 1:number.of.transitions) {
    from.state <- states[[1]][k]
    to.state <- states[[1]][k+1]
    transitions[[k]] <- c(from.state, to.state)
  }
  return (transitions)
}

# Get the probabilities for the transitions of a half inning
getProbabilities <- function(one.half.inning, transition.matrix) {
  trans <- getTransitions(one.half.inning)
  probabilities <- c()
  for (k in 1:length(trans)) {
    from.state <- trans[[k]][1]
    to.state <- trans[[k]][2]
    this.probability <- transition.matrix[from.state, to.state]
    probabilities <- c(probabilities, this.probability)
  }
  return (probabilities)
}

# Get the log-likelihood for one inning
getLogLikelihood <- function(one.half.inning, transition.matrix) {
  return (sum(log(getProbabilities(one.half.inning,
                                   transition.matrix))))
}

# Get the log-likelihood for a vector of innings
likes.baseball <- function(innings, transition.matrix) {
  likes <- rep(NA,length(innings)) # initialize vector of likes
  k <- 1 # Initialize index into innings
  for (one.inning in innings) {
    likes[k] <- getLogLikelihood(one.inning, transition.matrix)
    k <- k + 1
  }
  return (likes)
}