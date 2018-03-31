library(dplyr)

eeg.colnames <- c('subject.id', 'video.id', 'attention', 'meditation', 'raw.signal', 'Delta', 'Theta', 'Alpha1', 'Alpha2', 'Beta1', 'Beta2', 'Gamma1', 'Gamma2', 'expected.confusion', 'subject.confusion')
eegdat.raw <- read.csv('EEG data.csv', header = FALSE, col.names = eeg.colnames) 
View(eegdat.raw)

non.confusing <- eegdat.raw %>%
  dplyr::filter(subject.id == 0, video.id == 0, subject.confusion == 0) %>%
  dplyr::select(Delta, Theta, Alpha1, Alpha2, Beta1, Beta2, Gamma1, Gamma2)
non.confusing['time'] <- seq(1, length(non.confusing$Delta))
View(non.confusing)
write.csv(non.confusing, "non-confused-waves.csv")


confusing <- eegdat.raw %>%
  dplyr::filter(subject.id == 0, video.id == 1, subject.confusion == 1) %>%
  dplyr::select(Delta, Theta, Alpha1, Alpha2, Beta1, Beta2, Gamma1, Gamma2)
confusing['time'] <- seq(1, length(confusing$Delta))
View(confusing)
write.csv(confusing, "confused-waves.csv")