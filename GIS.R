#### Load required packages

library(rgbif)      # Access and download species occurrence data from GBIF
library(tidyverse)  # Data manipulation tools
library(dplyr)      # Data manipulation
library(sf)         # Handling spatial data
library(leaflet)    # Interactive web maps
library(htmltools)  # Formatting popups
library(mapview)    # Quick interactive spatial visualisation
library(leafpop)    # Create popup tables for mapview

### Species 1: *Clinus superciliosus*

#### Obtain the GBIF taxon key (unique species ID)

taxon1 <- name_backbone("Clinus superciliosus")$speciesKey

#### Download up to 5000 occurrence records for South Africa, restricted to observations with valid geographic coordinates for spatial analysis

occ1 <- occ_search(taxonKey = taxon1,
                  country = "ZA",   # South Africa
                  limit = 5000,
                  hasCoordinate = TRUE)

#### Extract the occurrence data as a dataframe and inspect first few rows

df1 <- occ1$data
head(df1)

#### Remove records with incorrect or suspicious coordinates
##### These were manually identified as problematic observations

df1<-df1[-c(1059,868,867,866,1011,1045,229,1055,991,1111,1113,854,879,1104,310,1049,451,984,888,969,870,1103,873,1037,1089,1042,1094,1096,1020,975,961,865,1088),]

#### Convert dataframe into a spatial object (sf class)
##### Coordinates are longitude and latitude in WGS84 (EPSG:4326)

df1 <- st_as_sf(df1, coords = c("decimalLongitude", "decimalLatitude"), crs = 4326)

#### Confirm that the object is spatial

class(df1)

### Species 2: *Psammogobius knysnaensis*

#### Obtain the GBIF taxon key (unique species ID)

taxon2 <- name_backbone("Psammogobius knysnaensis")$speciesKey

#### Download up to 5000 occurrence records for South Africa, restricted to observations with valid geographic coordinates for spatial analysis

occ2 <- occ_search(taxonKey = taxon2,
                   country = "ZA",   # South Africa
                   limit = 5000,
                   hasCoordinate = TRUE)

#### Extract the occurrence data as a dataframe and inspect first few rows
df2 <- occ2$data
head(df2)

#### Remove records with incorrect or suspicious coordinates

df2<-df2[-c(234,9,184,195,59,225,159,117,325,327,118,57,159,220,219,218,217,216),]

#### Convert dataframe into a spatial object (sf class)

df2 <- st_as_sf(df2, coords = c("decimalLongitude", "decimalLatitude"), crs = 4326)

#### Confirm that the object is spatial

class(df2)

### Create Interactive Map

#### Create initial interactive map layer for *Clinus superciliosus*

m<-mapview(df1,
           col.regions = 'blue',
        popup = 
          popupTable(df1,
                     zcol = c("species")),
        legend = FALSE) 

#### Add second species layer for *Psammogobius knysnaensis*

m<-m+ mapview(df2,
              col.regions ='red',
                 popup = 
                   popupTable(df2,
                              zcol = c("species")),
                 legend = FALSE)  

#### Add custom legend to explain colors

m@map<-m@map %>%
  addLegend(position= 'topleft',
            title = 'Fish species',
            colors = c('blue','red'),
            labels = c("Clinus superciliosus","Psammogobius knysnaensis"))

#### Display final interactive map

m

### Create Rock Pool Sampling Sites

sites <- data.frame(
  Site = c("Mouille Point", "Schusters Bay", "Dalebrook"),
  Latitude = c(-33.89947, -34.19917, -34.12403),
  Longitude = c(18.40345, 18.37222, 18.45292)
)

#### Convert to spatial (sf) object

sites_sf <- st_as_sf(
  sites,
  coords = c("Longitude", "Latitude"),
  crs = 4326
)

#### Assign colors for each site

site_pal <- colorFactor(
  palette = c("red", "blue", "green"),
  domain = sites$Site
)

#### Create interactive map

leaflet(data = sites_sf) %>%
  
#### Add base map tiles (OpenStreetMap)
addTiles() %>%
  
#### Add circle markers for each site
  
addCircleMarkers(
  radius = 8,
  color = ~site_pal(Site),
  stroke = TRUE,
  fillOpacity = 0.8,
  popup = ~paste0("<b>Sampling Site:</b> ", Site)
) %>%
  
#### Add legend explaining colors
  
addLegend(
  "topleft",
  pal = site_pal,
  values = ~Site,
  title = "Sampling Sites"
)
