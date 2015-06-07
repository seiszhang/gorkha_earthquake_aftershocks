require('ggplot2', quietly = TRUE, warn.conflicts = FALSE)
require('scales', quietly = TRUE, warn.conflicts = FALSE)
require('maps', quietly = TRUE, warn.conflicts = FALSE)
require('mapdata', quietly = TRUE, warn.conflicts = FALSE)
require('leaflet', quietly = TRUE, warn.conflicts = FALSE)


# Plot all earthquakes in a continuous timeline.
plot.earthquake.mag.in.timeline <- function(earthquakes) {
  ggplot(data = earthquakes, 
         mapping = aes(x = date_time_posixct, y = mag, size = mag), 
         height = 960, width = 540) + 
    geom_point() + 
    scale_x_datetime("Date/Time") + 
    scale_y_continuous("Magnitude") + 
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
}


plot.earthquake.mag.vs.datetime <- function(earthquakes) {
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


# Plot when earthquakes occured in time of day.
plot.earthquake.mag.vs.time.of.day <- function(earthquakes) {
  ggplot(data = earthquakes, 
         mapping = aes(x = time_posixct, y = mag, size = mag), 
         height = 960, width = 540) + 
    geom_point() + 
    scale_x_datetime("Time of Day", breaks = date_breaks("2 hour"),
                     labels = date_format("%H:%M")) + 
    scale_y_continuous("Magnitude") + 
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

# Plot inter-quake times.
plot.inter.quake.times <- function(inter.quake.times, main = "Inter-quake Time", xlab = "Time (in mins)", ylab = "# Quakes", ...) {
  inter.quake.times %>% 
    plot.inter.event.times(density = 10, col = "steel blue", breaks = 100, 
                           main = main, xlab = xlab, ylab = ylab, ...)
}

# Plot quakes in Nepal on a basic map.
plot.nepal.quakes.on.map <- function(earthquakes) {
  x.lim <- c(80.05, 88.2)
  y.lim <- c(26.35, 30.45)
  map("worldHires","Nepal", xlim = x.lim, ylim = y.lim, col="gray90", fill=TRUE)
  points(x = earthquakes$long, y = earthquakes$lat, xlim = x.lim, ylim = y.lim, pch = ".", cex = earthquakes$mag ^ 0.5)
  box()
}

# Plot quakes in Nepal on a leaflet map.
leaflet.plot.nepal.quakes.on.map <- function(earthquakes) {
  eq <- earthquakes %>% 
    mutate(mag_color = mag %>% as.integer() %>% as.factor())
  mag_colors <- eq %>% 
    with(colorFactor(heat.colors(mag %>% max() %>% ceiling() - 
                               mag %>% min() %>% floor()) %>% 
                       rev(), 
                     mag_color))
  eq %>% 
    leaflet() %>% 
    addProviderTiles("MapQuestOpen.Aerial", 
                     options = providerTileOptions(opacity = 1.0)) %>%
    addProviderTiles("Stamen.TonerLines",
                     options = providerTileOptions(opacity = 1.0)) %>%
    addProviderTiles("Stamen.TonerLabels") %>% 
    addCircles(lng = ~long, 
               lat = ~lat, 
               color = ~mag_colors(mag_color), 
               radius = ~2 * mag ^ 4, 
               opacity = 0.8, 
               fillOpacity = 0.5, 
               popup = ~as.character(mag)) %>% 
    addLegend(position = "topright", pal = mag_colors, values = ~mag_color, 
              title = "Magnitude")
}

# Plot Gorkha EQ & aftershocks on a map.
plot.gorkha.quakes.quakes.on.map <- function() {
  plot.nepal.quakes.on.map(earthquakes.from.2015.4.25)
}

# Plot Gorkha EQ & aftershocks on a leaflet map.
leaflet.plot.gorkha.quakes.quakes.on.map <- function() {
  leaflet.plot.nepal.quakes.on.map(earthquakes.from.2015.4.25)
}
