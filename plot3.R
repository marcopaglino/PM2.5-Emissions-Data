# which of the four source type point, nonpoint, onroad abd nonroad 
# have seen decreases or increases
# in emissions from 1999–2008 in Baltimore City

library(dplyr)
library(ggplot2)

# read the PM2.5 Emissions Data file
#pm25em<-readRDS("data/summarySCC_PM25.rds")

# subset Baltimore data
pm25Balt<-pm25em[pm25em$fips=='24510',]

# group data by year and by source type
byYT<-group_by(pm25Balt,year,type)

# sum value by the defined byYT group 
listEmBalt<-data.frame(summarise(byYT,emisSum=sum(Emissions)))

# open the bitmap device
png(file="plot3.png")

# print the graph using type as a factor
p<-ggplot(listEmBalt,aes(year,emisSum))
p+geom_point(aes(colour= factor(type)),size=4) + labs(y="PM2.5 Total Emissions (tons)") + labs(title="Total PM2.5 emissions by source from 1999 to 2008 in Baltimore City", color="source types")

# close the device
dev.off()


