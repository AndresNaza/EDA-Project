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


### Plot 2

### Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008?
### Use the base plotting system to make a plot answering this question.

### Filter data for Baltimore City and summarize data on Emissions by year.

subset_2 <- NEI %>%  filter(fips == "24510")  %>% group_by(year) %>% summarise(Total_emission= sum(Emissions))

### Plot existing relation, using R base plot system, and save it into a png file.

plot(subset_2$year,subset_2$Total_emission,xlab = "Year",ylab = "Total PM2.5 emissions in Baltimore City (in tons)", type = "b")

dev.copy(png,"plot2.png",width=480,height=480)

dev.off()
