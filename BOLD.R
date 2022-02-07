#In this code, it is aimed to simulate time series of a single voxel in brain
#for 10 different patients. I assumed that the voxel size
#for this study is 3mm x 3mm x 3mm and each voxel to have 180 units of data

#Stimulus assumed to be presented for 2s, so every patient is scanned for 6 mins.
#This is 0.15 of the average usual fMRI scan duration.

#I used nlme(ODE) package before for regression analysis to fit
#a mixed data to a model. For this project I also 
#used it. fmri package is used to process and analyze the data.

library(nlme)
library(fmri)

p<-10 #number of patients
ss<-180 # sample size

#fixcr: location that fixation cross will appear is introduced - no stim
#0back: seeing the fixation cross for the first time
#1back: remembering the fixation cross from 1 previous trial
#2back: remembering the fixation cross from 2 previous trial


nostim<-rep(0,15)#binary 0 for anything that doesn't stimulate any nback memory
stim<-rep(1,15)#binary 1 for stimulation of nback conditions
stim1 <- rep(c(nostim,stim,nostim,nostim),3)
stim2 <- rep(c(nostim,nostim,stim,nostim),3)
stim3 <- rep(c(nostim,nostim,nostim,stim),3)

par(mar=c(1, 1, 1, 1))
plot(1:ss,stim1,type="l", main="Model of 3 Stimuli", ylab="Stim - NoStim", lwd=c(2,2,2),xlab="Data #")
#plot(1:ss,stim2,type="l", ylab="", lwd=c(2,2,2),xlab="Data #")
#plot(1:ss,stim3,type="l", ylab="", lwd=c(2,2,2),xlab="Data #")
lines(1:ss,stim2,col="red",type="l", lwd=c(2,2,2))
lines(1:ss,stim3,col="blue",type="l", lwd=c(2,2,2))
legend("bottomright", c("stim1", "stim2", "stim3"), lty=c(1,1,1), lwd=c(2,2,2), col=c("black","red", "blue"))

baseonsets <- c(15, 5+60, 5+120) 
EV1 <- fmri.stimulus(scans=ss, onsets=(baseonsets+0),durations=c(15,15,15))
EV2 <- fmri.stimulus(scans=ss, onsets=(baseonsets+15),durations=c(15,15,15))
EV3 <- fmri.stimulus(scans=ss, onsets=(baseonsets+30),durations=c(15,15,15))

plot(1:ss, EV1,type="l", ylab="BOLD Response", lwd=c(2,2,2), xlab="Data #")
lines(1:ss,EV2,col="red",type="l", lwd=c(2,2,2))
lines(1:ss,EV3,col="blue",type="l", lwd=c(2,2,2))
legend("bottomright", c("EV1", "EV2", "EV3"), lty=c(1,1,1), lwd=c(2,2,2), col=c("black","red", "blue"))

#We want the BOLD signals to match with the related stimulus and peaks in voxels.
