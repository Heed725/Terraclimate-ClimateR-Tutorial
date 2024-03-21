## Terraclimate Map visualization using ClimateR Tutorial
This Tutorial below is on How to create climateR maps using Terraclimate dataset  this will Include Yearly,Monthly and Finally Mean As illustrated ,The Main Country/Area of Interest would be Kingdom of Saudi Arabia and Before I continue Much Special Thanks to Creator of ClimateR Mike Johnson -[@mikejohnson51] you can check it out and ClimateR official Repository link below

https://github.com/mikejohnson51/climateR

# How to Install ClimateR Package 
ClimateR can be Installed using the below codes you need to install ClimateR codes 

```r
remotes::install_github("mikejohnson51/AOI") # suggested!
remotes::install_github("mikejohnson51/climateR")

```
# Other Packages to Install which might be required
Other Packages needed might be terra,tidyterra,ggplot2,sf,shapefiles ;- which can be installed in Rstudio by going to Package ,Install then writing name of one of 5 packages listed above

# Tutorial for Yearly Temperature Map of Area of Interest 
So first thing is to load/write up the packages to be used 

```r
library(climateR)
library(terra)
library(tidyterra)
library(ggplot2)
library(sf)
library(shapefiles)
```
Then you write a code to fetch area of Interest using 3-Country code of The country of Interest

```r
SAU = AOI::aoi_get(country = "SAU")

```
The you write the codes to fetch the raster files containing climate(Take note on Parameter or varname) and the years can change wherever year you want let say 2000 to 2010 ,but for this example Only two years were used 2011 and 2012

```r
test_data = getTerraClim(
  AOI = SAU,
  varname = "tmax",
  startDate = "2011-01-01",
  endDate   = "2012-12-01"
)
```

Then You write code for Indexing and masking the Raster 

```r
data = tapp(test_data[[1]],
            rep(1:(nlyr(test_data[[1]]) / 12), 12),
            mean) |>
  mask(project(vect(SAU), crs(test_data[[1]])))

names(data) = c("2011", "2012")
```

Then finally You write code for adding annotation and coloring the Raster

```r
ggplot() +
  geom_spatraster(data = data) +
  geom_spatvector(data = SAU, fill = NA, lwd = 1) +
  facet_wrap( ~ lyr) +
  scale_fill_whitebox_c(
    palette  = "muted",
    n.breaks = 12,
    guide    = guide_legend(reverse = TRUE)
  ) +
  labs(title = "Yearly temperature of Saudi Arabia of the years 2011 and 2012",
       fill = "Temperature (°C)") + # Add title
  theme_minimal()
```
The full Code would be like this 
```r
library(climateR)
library(terra)
library(tidyterra)
library(ggplot2)
library(sf)
library(shapefiles)

SAU = AOI::aoi_get(country = "SAU")

test_data = getTerraClim(
  AOI = SAU,
  varname = "tmax",
  startDate = "2011-01-01",
  endDate   = "2012-12-01"
)

data = tapp(test_data[[1]],
            rep(1:(nlyr(test_data[[1]]) / 12), 12),
            mean) |>
  mask(project(vect(SAU), crs(test_data[[1]])))

names(data) = c("2011", "2012")

ggplot() +
  geom_spatraster(data = data) +
  geom_spatvector(data = SAU, fill = NA, lwd = 1) +
  facet_wrap( ~ lyr) +
  scale_fill_whitebox_c(
    palette  = "muted",
    n.breaks = 12,
    guide    = guide_legend(reverse = TRUE)
  ) +
  labs(title = "Yearly temperature of Saudi Arabia of the years 2011 and 2012",
       fill = "Temperature (°C)") + # Add title
  theme_minimal()
```

The final Output on This section would look like This 
![Saudi Arabia Yearly](https://github.com/Heed725/Terraclimate-ClimateR/assets/86722789/25c32983-31fa-46b0-98ce-f97e0d560032)


# Tutorial for Monthly Temperature Map of Area of Interest 

The Monthly Temperature slight things changes on Indexing and Annotation

```r
library(climateR)
library(terra)
library(tidyterra)
library(ggplot2)
library(sf)
library(shapefiles)

SAU = AOI::aoi_get(country = "SAU")

test_data = getTerraClim(
  AOI = SAU,
  varname = "tmax",
  startDate = "2011-01-01",
  endDate   = "2012-12-01"
)

data = tapp(test_data[[1]],
            rep(1:12, (nlyr(test_data[[1]]) / 12)),
            mean) |>
  mask(project(vect(SAU), crs(test_data[[1]])))

names(data) = c("January", "February","March","April","May","June","July","August","September","October","November","December")

ggplot() +
  geom_spatraster(data = data) +
  geom_spatvector(data = SAU, fill = NA, lwd = 1) +
  facet_wrap( ~ lyr) +
  scale_fill_whitebox_c(
    palette  = "muted",
    n.breaks = 12,
    guide    = guide_legend(reverse = TRUE)
  ) +
  labs(title = "Monthly Day temperature of Saudi Arabia for years 2011 and 2012",fill = "Temperature (°C)") +
  theme_minimal()
```
Which would result into This Output

![Monthly Saudi Arabia](https://github.com/Heed725/Terraclimate-ClimateR/assets/86722789/9bca64bf-c5d2-4fa1-b1b7-7f19e3261d4d)

# Mean Temperature Map of Area of Interest 

So it also differs from the other as full code is as follows 
```r
library(climateR)
library(terra)
library(tidyterra)
library(ggplot2)
library(sf)
library(shapefiles)

SAU = AOI::aoi_get(country = "SAU")

test_data = getTerraClim(
  AOI = SAU,
  varname = "tmax",
  startDate = "2011-01-01",
  endDate   = "2012-12-01"
)

data = mask(mean(test_data[[1]]), project(vect(SAU), crs(test_data[[1]])))

ggplot() +
  geom_spatraster(data = data) +
  geom_spatvector(data = SAU, fill = NA, lwd = 1) +
  scale_fill_whitebox_c(
    palette  = "muted",
    n.breaks = 12,
    guide    = guide_legend(reverse = TRUE)
  ) +
  labs(title = "Mean Daily Max Temperature of Saudi Arabia for the years 2011 and 2012 ",fill = "Temperature (°C)") + 
  theme_minimal()
```
![Mean Saudi Arabia](https://github.com/Heed725/Terraclimate-ClimateR/assets/86722789/f4bf3b0d-5775-4e36-a5f7-b1fb43464bca)

# Concerning Other Visual Climatic Maps for Example Rainfall 
So for this case we have visualized Temperature map using code

```r
varname = "tmax"
```
Concerning other visual all you need to do is to change varname if you want for Rainfall 

```r
varname = "ppt"
```
And Min Temperature 

```r
varname = "tmin"
```
# An One Example on Monthly Rainfall Data for Area of Interest
So for Rainfall Visualization for Rainfall we write code as follows 

```r
library(climateR)
library(terra)
library(tidyterra)
library(ggplot2)
library(sf)
library(shapefile)

SAU = AOI::aoi_get(country = "SAU")

test_data = getTerraClim(
  AOI = SAU,
  varname = "ppt",
  startDate = "2011-01-01",
  endDate   = "2012-12-01"
)

data = tapp(test_data[[1]],
            rep(1:12, (nlyr(test_data[[1]]) / 12)),
            mean) |>
  mask(project(vect(SAU), crs(test_data[[1]])))

names(data) = c("January", "February","March","April","May","June","July","August","September","October","November","December")

ggplot() +
  geom_spatraster(data = data) +
  geom_spatvector(data = SAU, fill = NA, lwd = 1) +
  facet_wrap( ~ lyr) +
  scale_fill_whitebox_c(
    palette  = "deep",
    n.breaks = 12,
    guide    = guide_legend(reverse = TRUE)
  ) +
  labs(title = "Monthly Precipitation of Saudi Arabia for years 2011 and 2012",fill = "Precipitation (mm)") +
  theme_minimal()
```
The result would look like this below
![Mnt](https://github.com/Heed725/Terraclimate-ClimateR/assets/86722789/7508e2d1-e206-4295-850f-b2e04d2d90de)

# Area of Interest using shapefile 
For instance you have an area of interest that is not country wise let say its sub-country or it can be a basin not to worry it can still be used in terraclimate using Shapefile and sf packages,You need to prepare it in QGIS or Arc-GIS pro then export it to place you want to save (My preference is normally local disk ) then you can easily fetch shapefile through Pathway and continue as normal for Instance in this example I'm going to illustrate for Makkah region/province which is sub-region of Kingdom of Saudi Arabia ,Prepared shapefile from QGIS Through GADM then saved it and made the code below ;-

```r
library(climateR)
library(terra)
library(tidyterra)
library(ggplot2)
library(sf)
library(shapefiles)

MAK <- st_read("C:/Makkah.shp")
test_data = getTerraClim(
  AOI = MAK,
  varname = "tmax",
  startDate = "2011-01-01",
  endDate   = "2012-12-01"
)

data = tapp(test_data[[1]],
            rep(1:12, (nlyr(test_data[[1]]) / 12)),
            mean) |>
  mask(project(vect(MAK), crs(test_data[[1]])))

names(data) = c("January", "February","March","April","May","June","July","August","September","October","November","December")

ggplot() +
  geom_spatraster(data = data) +
  geom_spatvector(data = MAK, fill = NA, lwd = 1) +
  facet_wrap( ~ lyr) +
  scale_fill_whitebox_c(
    palette  = "muted",
    n.breaks = 12,
    guide    = guide_legend(reverse = TRUE)
  ) +
  labs(title = "Monthly Temperature of Makkah Province for years 2011 and 2012",fill = "Temperature (°C)") +
  theme_minimal()
```
Which would bring This Output 

![MAK](https://github.com/Heed725/Terraclimate-ClimateR/assets/86722789/be71ea91-dc18-4f52-89ee-9d10bd1650b3)

# Adjusting Longitude and Latitude
Sometimes The default coordinates doesn't appear nicely (For example above coordinate) so all you need to do is to Adjust using coord_sf function as illustrated below ,xlim represent Longitude while ylim represent latitude which you can adjust manually

```r
library(climateR)
library(terra)
library(tidyterra)
library(ggplot2)
library(sf)
library(shapefiles)

MAK <- st_read("C:/Makkah.shp")
test_data = getTerraClim(
  AOI = MAK,
  varname = "tmax",
  startDate = "2011-01-01",
  endDate   = "2012-12-01"
)

data = tapp(test_data[[1]],
            rep(1:12, (nlyr(test_data[[1]]) / 12)),
            mean) |>
  mask(project(vect(MAK), crs(test_data[[1]])))

names(data) = c("January", "February","March","April","May","June","July","August","September","October","November","December")

ggplot() +
  geom_spatraster(data = data) +
  geom_spatvector(data = MAK, fill = NA, lwd = 1) +
  facet_wrap( ~ lyr) +
  scale_fill_whitebox_c(
    palette  = "muted",
    n.breaks = 12,
    guide    = guide_legend(reverse = TRUE)
  ) +
  labs(title = "Monthly Temperature of Makkah Province for years 2011 and 2012",fill = "Temperature (°C)") +
  theme_minimal() +
  coord_sf(xlim = c(36, 45), ylim = c(21, 29)) # Adjust longitude values as needed
```
It would result to This Map/Output
![Makkah 2](https://github.com/Heed725/Terraclimate-ClimateR-Tutorial/assets/86722789/8d57587f-4cb6-4ae7-9e53-83d8eb593ebc)

# Final Touches - Pallete explanation
So I wanted to share you the pallete is used found in Tidyterra
The words "muted" and "deep" are color palette used ,normally for Temperature and Rainfall Representation Below is PNG of more color pallete

![Palette](https://github.com/Heed725/Terraclimate-ClimateR/assets/86722789/a0594fe9-f483-4058-bfc5-eb6c6384f64b)

# Citation and reference 

Special thanks to Mike Johnson and Citation is as follows

```r
@Manual{,
  title = {climateR: climateR},
  author = {Mike Johnson},
  year = {2023},
  note = {R package version 0.3.2},
  url = {https://github.com/mikejohnson51/climateR},
}
```






















