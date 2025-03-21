library(climateR)
library(terra)
library(tidyterra)
library(ggplot2)
library(sf)
library(colorspace)

# Load Gloucestershire boundary shapefile
MOR <- st_read("C:/GLU.shp")  # Ensure this is Gloucestershire
MOR <- st_transform(MOR, crs = 4326)  # Transform to WGS84 if needed

# Retrieve temperature data (tmax)
test_data <- getTerraClim(
  AOI = MOR,
  varname = "tmax",
  startDate = "2000-01-01",
  endDate   = "2023-12-01"
)

# Compute average tmax over the full time period
avg_tmax <- mean(test_data[[1]], na.rm = TRUE) |>
  mask(project(vect(MOR), crs(test_data[[1]])))

# Plot average maximum temperature
ggplot() +
  geom_spatraster(data = avg_tmax) +
  geom_spatvector(data = MOR, fill = NA, lwd = 1, color = "black") +
  scale_fill_continuous_sequential(palette = "YlOrRd", na.value = "transparent") +
  labs(
    title = "Average Maximum Temperature in Gloucestershire (2000-2023)",
    fill = "Temperature (°C)"
  ) +
  theme_minimal()
