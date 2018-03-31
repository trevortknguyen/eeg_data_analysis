library(dplyr)
library(ggplot2)
library(gridExtra)

eeg.colnames <- c('subject.id', 'video.id', 'attention', 'meditation', 'raw.signal', 'Delta', 'Theta', 'Alpha1', 'Alpha2', 'Beta1', 'Beta2', 'Gamma1', 'Gamma2', 'expected.confusion', 'subject.confusion')
eegdat.raw <- read.csv('EEG data.csv', header = FALSE, col.names = eeg.colnames) 
View(eegdat.raw)

mean.of.logs <- function(x) mean(log(x))

delta <- tapply(eegdat.raw$Delta, eegdat.raw$video.id, mean.of.logs)
theta <- tapply(eegdat.raw$Theta, eegdat.raw$video.id, mean.of.logs)
alpha1 <- tapply(eegdat.raw$Alpha1, eegdat.raw$video.id, mean.of.logs)
alpha2 <- tapply(eegdat.raw$Alpha2, eegdat.raw$video.id, mean.of.logs)
beta1 <- tapply(eegdat.raw$Beta1, eegdat.raw$video.id, mean.of.logs)
beta2 <- tapply(eegdat.raw$Beta2, eegdat.raw$video.id, mean.of.logs)
gamma1 <- tapply(eegdat.raw$Gamma1, eegdat.raw$video.id, mean.of.logs)
gamma2 <- tapply(eegdat.raw$Gamma2, eegdat.raw$video.id, mean.of.logs)

y.avg.confusion <- tapply(eegdat.raw$subject.confusion, eegdat.raw$video.id, mean)


df.by.video <- data.frame(
  video.id = c('video0', 'video1', 'video2', 'video3', 'video4', 'video5', 'video6', 'video7', 'video8', 'video9'),
  delta,
  theta,
  alpha1,
  alpha2,
  beta1,
  beta2,
  gamma1,
  gamma2,
  y = y.avg.confusion
)
View(df.by.video)

delta.b <- coefficients(lm(y ~ delta, df.by.video))[1]
delta.m <- coefficients(lm(y ~ delta, df.by.video))[2]

beta2.b <- coefficients(lm(y ~ beta2, df.by.video))[1]
beta2.m <- coefficients(lm(y ~ beta2, df.by.video))[2]

gamma2.b <- coefficients(lm(y ~ gamma2, df.by.video))[1]
gamma2.m <- coefficients(lm(y ~ gamma2, df.by.video))[2]


delta.plot <- ggplot(df.by.video) +
  geom_abline(intercept = delta.b, slope = delta.m) +
  geom_point(aes(delta, y))
theta.plot <- ggplot(df.by.video) +
  geom_point(aes(theta, y))
alpha1.plot <- ggplot(df.by.video) +
  geom_point(aes(alpha1, y))
alpha2.plot <- ggplot(df.by.video) +
  geom_point(aes(alpha2, y))
beta1.plot <- ggplot(df.by.video) +
  geom_point(aes(beta1, y))
beta2.plot <- ggplot(df.by.video) +
  geom_abline(intercept = beta2.b, slope = beta2.m) +
  geom_point(aes(beta2, y))
gamma1.plot <- ggplot(df.by.video) +
  geom_point(aes(gamma1, y))  
gamma2.plot <- ggplot(df.by.video) +
  geom_abline(intercept = gamma2.b, slope = gamma2.m) +
  geom_point(aes(gamma2, y))

grid.arrange(delta.plot, theta.plot, alpha1.plot, alpha2.plot, beta1.plot, beta2.plot, gamma1.plot, gamma2.plot)

plot(df.by.video, gap=0)

linear.model <- lm(y ~ delta + theta + alpha1 + alpha2 + beta1 + beta2 + gamma1 + gamma2, df.by.video)
