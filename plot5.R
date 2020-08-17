### Load libraries

library(tidyverse)


### Check if raw data is already in working directory. If not, download the file from the web.

if (!file.exists("raw_data.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","raw_data.zip")
}


### Check if raw data set is already unzipped in working directory. Else, unzip it.

if (!file.exists("Source_Classification_code.rds") | !file.exists("summarySCC_PM25.rds")){
  unzip("raw_data.zip")
}


### Read raw data into R. 

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


### Plot 5

### How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

### Subset SCC table to obtain motor vehicles sources only. To do that, filter those records that contain the word "Motor Vehicles" 
### or "Motorcycles" on the SCC.Level.Three field

motor_vehicles_sources <- SCC %>% filter(stringr::str_detect(SCC.Level.Three,"Motor Vehicles")| stringr::str_detect(SCC.Level.Three,"Motorcycles") )


### Filter NEI data for motor vehicles sources in Baltimore City, and summarize emissions by year

subset_5 <- NEI %>%  inner_join(motor_vehicles_sources, by=c("SCC"="SCC"))%>%  filter(fips == "24510") %>% group_by(year) %>% summarise(Total_emission= sum(Emissions))


### Plot coal combustion-related sources changes from 1999-2008, and save it into a png file.

ggplot(subset_5,aes(x=year, y=Total_emission)) + 
  geom_point() + 
  geom_line() + 
  labs(x="Year", y="Total PM2.5 emissions (in tons)", title = "Emissions from motor vehicle sources in Baltimore City")

dev.copy(png,"plot5.png",width=480,height=480)

dev.off()

