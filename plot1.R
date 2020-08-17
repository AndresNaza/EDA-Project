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



### Plot 1

### Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
### Using the base plotting system, make a plot showing the total PM2.5 emission from all
### sources for each of the years 1999, 2002, 2005, and 2008.

### Summarize all data by year.

subset_1 <- NEI %>% group_by(year) %>% summarise(Total_emission= sum(Emissions))

### Plot existing relation, using R base plot system, and save it into a png file.

plot(subset_1$year,subset_1$Total_emission,xlab = "Year",ylab = "Total PM2.5 emissions (in tons)", type = "b")

dev.copy(png,"plot1.png",width=480,height=480)

dev.off()
