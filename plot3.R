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


### Plot 3

### Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
### which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
### Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

### Filter data for Baltimore City and summarize data on Emissions by year and type variable.

subset_3 <- NEI %>%  filter(fips == "24510")  %>% group_by(year,type) %>% summarise(Total_emission= sum(Emissions))

### Plot existing relation, using ggplot system, and save it into a png file.

ggplot(subset_3,aes(x=year, y=Total_emission)) + 
  geom_point() + 
  geom_line() + 
  facet_wrap(~type) + 
  labs(x="Year", y="Total PM2.5 emissions in Baltimore City (in tons)", title = "Total emissions by source in Baltimore City")

dev.copy(png,"plot3.png",width=480,height=480)

dev.off()
