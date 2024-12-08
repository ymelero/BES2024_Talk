################################
##### This script generates species distribution maps for specified butterfly species across Europe overlaid with climate data (mean annual temperature). 
##### It highlights the relationship between species occurrences and climatic variables, useful for understanding butterfly responses to weather anomalies.
################################

# Load required libraries
library(geodata)    # For downloading and handling climate data
library(sf)         # For working with spatial vector data (Simple Features)
library(terra)      # For handling raster data
library(ggplot2)    # For data visualization
library(rgbif)      # For accessing GBIF occurrence data

# Get occurrence data from GBIF for Ochlodes sylvanus in Europe
occ <- occ_data(scientificName = "Satyrium spini",  # Species name
                hasCoordinate = TRUE,                  # Filter to include only records with coordinates
                continent = "Europe",                  # Limit data to Europe
                limit = 50000)                         # Maximum number of records to retrieve

# Convert GBIF occurrence data to an sf object for visualization
occ_sf <- st_as_sf(occ$data, coords = c("decimalLongitude", "decimalLatitude"), crs = 4326)

# Download WorldClim climate data (bio variables) with 10-minute resolution for the year 2020
# 'var = "bio"' specifies that bioclimatic variables are being downloaded
# 'res = 10' sets the resolution to 10 minutes (~18 km)
# 'path = tempdir()' sets a temporary directory to store the downloaded files
climate_data <- worldclim_global(var = "bio", res = 10, path = tempdir(), year = 2020)

# Crop the climate data to the extent of Europe
# Define the geographic extent for Europe (longitude and latitude boundaries)
extent_europe <- ext(-25, 45, 35, 71)  # Approximate extent for Europe
europe_climate <- crop(climate_data, extent_europe)

# Select the annual mean temperature (bio1) variable from the climate dataset
bio1 <- europe_climate$wc2.1_10m_bio_1

# Additional visualization with a different color scheme
plot(bio1, main = "")
plot(occ_sf, col = "#A6CEE3", add = TRUE, pch = 1, cex = 0.2)  # Plot occurrence points in blue
