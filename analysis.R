eegdata.raw <- read.csv('EEG data.csv', header = FALSE)

library(dplyr)
library(ggplot2)
library(gridExtra)

global.attention <- eegdata.raw %>%
  select(V3) %>%
  unlist()

global.attention.mean <- mean(global.attention)
global.attention.sd <- sd(global.attention)

create.attention.df <- function(eegdata.raw, subject.id, video.id, normalize = TRUE, global.normalize = TRUE) {
  attention <- eegdata.raw %>%
    filter(V1 == subject.id, V2 == video.id) %>%
    select(V3) %>%
    unlist()
  time <- seq(1, length(attention))
  
  if (normalize) {
    if (global.normalize) {
      attention <- (attention - global.attention.mean) / global.attention.sd
    } else {
      attention <- (attention - mean(attention)) / sd(attention)
    }
  }
  
  df <- data.frame(attention = attention, time = time)
  
  return(df)
}

df.1.1 <- create.attention.df(eegdata.raw, 1, 1)
df.2.1 <- create.attention.df(eegdata.raw, 2, 1)
df.3.1 <- create.attention.df(eegdata.raw, 3, 1)
df.4.1 <- create.attention.df(eegdata.raw, 4, 1)

p1 <- ggplot() +
  geom_line(data = df.1.1, aes(time, attention), color='blue') +
  geom_line(data = df.2.1, aes(time, attention), color='red') +
  geom_line(data = df.3.1, aes(time, attention), color='green') +
  geom_line(data = df.4.1, aes(time, attention), color='orange')


eegdata.raw %>% filter(V1 == 1, V2 == 1) %>% select(V3) %>% summarize(mean(V3))
eegdata.raw %>% select(V3) %>% summarize(mean(V3))

plot.ranges <- function(df.data) {
  plot6 <- ggplot(df.data) +
    geom_line(aes(time, V6)) +
    ggtitle('Delta') +
    scale_y_log10()
  plot7 <- ggplot(df.data) +
    geom_line(aes(time, V7)) +
    ggtitle('Theta') +
    scale_y_log10()
  plot8 <- ggplot(df.data) +
    geom_line(aes(time, V8)) +
    ggtitle('Alpha low') +
    scale_y_log10()
  plot9 <- ggplot(df.data) +
    geom_line(aes(time, V9)) +
    ggtitle('Alpha high') +
    scale_y_log10()
  plot10 <- ggplot(df.data) +
    geom_line(aes(time, V10)) +
    ggtitle('Beta low') +
    scale_y_log10()
  plot11 <- ggplot(df.data) +
    geom_line(aes(time, V11)) +
    ggtitle('Beta high') + 
    scale_y_log10()
  plot12 <- ggplot(df.data) +
    geom_line(aes(time, V12)) +
    ggtitle('Gamma low') +
    scale_y_log10()
  plot13 <- ggplot(df.data) +
    geom_line(aes(time, V13)) +
    ggtitle('Gamma high') +
    scale_y_log10()
  
  grid.arrange(plot6, plot7, plot8, plot9, plot10, plot11, plot12, plot13)
}

subject.video.df <- function(subject.id, video.id) {
  df.data <- eegdata.raw %>%
    filter(V1 == subject.id, V2 == video.id) %>%
    select(V6, V7, V8, V9, V10, V11,V12, V13)
  
  df.data['time'] <- seq(1, length(df.data$V6))  
  return(df.data)
}

plot.ranges(subject.video.df(0, 0))
plot.ranges(subject.video.df(1, 0))
plot.ranges(subject.video.df(0, 1))
