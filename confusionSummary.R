library(dplyr)
library(ggplot2)
library(gridExtra)

eegdat.raw <- read.csv('EEG data.csv') %>% select(V)
colnames(eegdat.raw) <- c('subject.id', 'video.id', 'attention', 'meditation', 'raw.signal', 'Delta', 'Theta', 'Alpha1', 'Alpha2', 'Beta1', 'Beta2', 'Gamma1', 'Gamma2', 'expected.confusion', 'subject.confusion')

sconf <- eegdat.raw %>% select(subject.id, video.id, expected.confusion, subject.confusion)
sconf.summary <- unique(sconf)

View(sconf.summary)