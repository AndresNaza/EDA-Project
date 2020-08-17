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


### Plot 4

### Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

### Subset SCC table to obtain coal combustion-related sources only. To do that, filter those records that contain the word "Coal"
### on the short.name field

coal_sources <- SCC %>% filter(stringr::str_detect(Short.Name,"Coal"))


### Filter NEI data for coal combustion-related sources, and summarize emissions by year

subset_4 <- NEI %>%  inner_join(coal_sources, by=c("SCC"="SCC")) %>% group_by(year) %>% summarise(Total_emission= sum(Emissions))


### Plot coal combustion-related sources changes from 1999-2008, and save it into a png file.

ggplot(subset_4,aes(x=year, y=Total_emission)) + 
  geom_point() + 
  geom_line() + 
  labs(x="Year", y="Total PM2.5 coal combustion-related emissions (in tons)")

dev.copy(png,"plot4.png",width=480,height=480)

dev.off()
