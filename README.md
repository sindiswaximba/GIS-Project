# GIS Project

Species occurrence data for *Clinus superciliosus* and *Psammogobius knysnaensis* came from the Global Biodiversity Information Facility (GBIF), an open-access biodiversity database. The records were downloaded in R using the rgbif package and filtered to include only observations from South Africa that had valid geographic coordinates. Up to 5,000 records per species were retrieved to analyze their spatial distribution. 

In addition, the coordinates of three rock pool sampling sites from the Intertidal Fish Survey in Cape Town (Mouille Point, Schusters Bay, and Dalebrook) were included. These sites represent locations where Prof. Colin Attwood and his research team previously sampled rock pool fish communities. These coordinates were obtained from an Excel dataset and used as reference points for mapping the local study area. The downloaded occurrence records were inspected and cleaned to remove observations with incorrect or questionable coordinates. The cleaned datasets were then converted into spatial objects using the sf package in R, with coordinates stored in the WGS84 coordinate reference system (EPSG:4326), which is commonly used in GIS mapping. 

The interactive maps were created to show the distribution of both fish species across South Africa using the mapview package. The second interactive map was made with the leaflet package to display the three sampling sites in Cape Town. These GIS-based visualizations allow for comparison between regional species occurrence patterns and the locations of the field sampling sites. All analyses and visualizations were conducted in R using several packages: rgbif for downloading GBIF records, tidyverse and dplyr for data manipulation, sf for spatial data handling, and mapview and leaflet for interactive mapping.

During the data cleaning process, several occurrence records were identified as problematic because they shared identical geographic coordinates. Four records (215, 876, 1011 and 1053) could not be permanently removed because when one point was deleted another record with the same geometry appeared underneath it. One of the classmates aslo tried to assist removing them, but we just could'nt.

Link to html: [https://rawcdn.githack.com/sindiswaximba/GIS-Project/cd26a8242d05692fc9d8bf1d7b3bdf42317a28b7/GIS-Project.html]

