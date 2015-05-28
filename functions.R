require('ggplot2', quietly = TRUE, warn.conflicts = FALSE)
require('scales', quietly = TRUE, warn.conflicts = FALSE)


plot.earthquake.mag.vs.datetime <- function() {
  ggplot(data = earthquakes, 
         mapping = aes(x = time_posixct, y = mag, size = mag), 
         height = 960, width = 540) + 
    geom_point() + 
    scale_x_datetime("Time of Day", breaks = date_breaks("3 hour"),
                     labels = date_format("%H:%M")) + 
    scale_y_continuous("Magnitude") + 
    facet_wrap(~date, ncol = 7) + 
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
}


# Filter earthquakes by date.
filter.earthquakes <- function(earthquakes, from = NA, to = NA) {
  eqs <- earthquakes %>% arrange(date_time_posixct)
  from <- ifelse(is.na(from), eqs$date_time_posixct[1], from)
  to <- ifelse(is.na(to), eqs$date_time_posixct[nrow(eqs)], to)
  eqs %>% filter(date_time_posixct >= from & eqs$date_time_posixct <= to)
}

# Calculates inter-event times
inter.event.times <- function(event_times, units = "mins") {
  date_time <- sort(event_times)
  date_time_past <- c(date_time[1:length(date_time) - 1])
  difftime(time1 = date_time[2:length(date_time)], time2 = date_time_past, units = units)
}

# Calculates inter-earthquake times.
inter.earthquake.time <- function(earthquakes, units = "mins") {
  inter.event.times(earthquakes$date_time_posixct, units = units)
}

# Plots inter-event times.
plot.inter.event.times <- function(inter.event.times, main = "Inter-event Time", xlab = "Time Unit", ylab = "# Events", ...) {
  inter.event.times %>% 
    as.numeric() %>% 
    hist(main = main, xlab = xlab, ylab = ylab, ...)
}
