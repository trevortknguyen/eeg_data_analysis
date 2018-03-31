library(dplyr)
library(ggplot2)
library(gridExtra)

eeg.colnames <- c('subject.id', 'video.id', 'attention', 'meditation', 'raw.signal', 'Delta', 'Theta', 'Alpha1', 'Alpha2', 'Beta1', 'Beta2', 'Gamma1', 'Gamma2', 'expected.confusion', 'subject.confusion')
eegdat.raw <- read.csv('EEG data.csv', header = FALSE, col.names = eeg.colnames)
eegdat <- eegdat.raw %>%
  select(subject.id, video.id, subject.confusion, Delta, Theta, Alpha1, Alpha2, Beta1, Beta2, Gamma1, Gamma2)
eegdat['trial'] = paste('trial.', eegdat$subject.id, '.', eegdat$video.id, sep = '')



View(eegdat.raw)
View(eegdat)


delta <- tapply(eegdat$Delta, eegdat$trial, mean.of.logs)
theta <- tapply(eegdat$Theta, eegdat$trial, mean.of.logs)
alpha1 <- tapply(eegdat$Alpha1, eegdat$trial, mean.of.logs)
alpha2 <- tapply(eegdat$Alpha2, eegdat$trial, mean.of.logs)
beta1 <- tapply(eegdat$Beta1, eegdat$trial, mean.of.logs)
beta2 <- tapply(eegdat$Beta2, eegdat$trial, mean.of.logs)
gamma1 <- tapply(eegdat$Gamma1, eegdat$trial, mean.of.logs)
gamma2 <- tapply(eegdat$Gamma2, eegdat$trial, mean.of.logs)

confusion.bool <- tapply(eegdat$subject.confusion, eegdat$trial, function(x) { if (any(x == 1)) 1 else 0     })
subject <- tapply(eegdat$subject.id, eegdat$trial, mean)

View(confusion.bool)

delta.df <- data.frame(delta, subject, confusion.bool)

ggplot(delta.df, aes(confusion.bool, delta, color = factor(subject))) +
  geom_point()
