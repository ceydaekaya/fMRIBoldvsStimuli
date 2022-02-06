#In this code, it is aimed to simulate time series of a single voxel in brain
#for 5 different patients. I assumed that the voxel size
#for this study is 3mm x 3mm x 3mm and each voxel to have 60 units of data

#Stimulus assumed to be presented for 2s, so every patient is scanned for 2 mins.
#This is 0.5 of the average usual fMRI scan duration.

#I used nlme(ODE) package before for regression analysis to fit
#a mixed data to a model. For this project I also 
#used it. fmri package is used to process and analyze the data.

library(nlme)
library(fmri)

p<-5 #number of patients
ss<-60 # sample size

#fixcr: location that fixation cross will appear is introduced - no stim
#0back: seeing the fixation cross for the first time
#1back: remembering the fixation cross from 1 previous trial
#2back: remembering the fixation cross from 2 previous trial


nostim<-rep(0,5)#binary 0 for anything that doesn't stimulate any nback memory
stim<-rep(1,5)#binary 1 for stimulation of nback conditions
stim1 <- rep(c(nostim,stim,nostim,nostim),3)
stim2 <- rep(c(nostim,nostim,stim,nostim),3)
stim3 <- rep(c(nostim,nostim,nostim,stim),3)

plot(1:ss,stim1,type="l", main="Model of 3 Stimuli", ylab="Stim - NoStim", lwd=c(2,2,2),xlab="Trial Number")
#plot(1:ss,stim2,type="l", ylab="", lwd=c(2,2,2),xlab="Trial Number")
#plot(1:ss,stim3,type="l", ylab="", lwd=c(2,2,2),xlab="Trial Number")
lines(1:ss,stim2,col="red",type="l", lwd=c(2,2,2))
lines(1:ss,stim3,col="blue",type="l", lwd=c(2,2,2))
legend("bottomright", c("stim1", "stim2", "stim3"), lty=c(1,1,1), lwd=c(2,2,2), col=c("black","red", "blue", cex=0.1))

