library(dplyr)
library(ggplot2)
library(gridExtra)

eeg.colnames <- c('subject.id', 'video.id', 'attention', 'meditation', 'raw.signal', 'Delta', 'Theta', 'Alpha1', 'Alpha2', 'Beta1', 'Beta2', 'Gamma1', 'Gamma2', 'expected.confusion', 'subject.confusion')
eegdat.raw <- read.csv('EEG data.csv', header = FALSE, col.names = eeg.colnames) 
View(eegdat.raw)


eegdat <- eegdat.raw %>%
  select(subject.id, video.id, Delta, Theta, Alpha1, Alpha2, Beta1, Beta2, Gamma1, Gamma2, subject.confusion)

View(eegdat)
