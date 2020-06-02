# How have emissions from coal combustion-related 
# sources changed from 1999–2008?

#library(dplyr)
library(ggplot2)

# read the PM2.5 Emissions Data file
pm25em<-readRDS("data/summarySCC_PM25.rds")

# read the Source Classification Code Table
SCClist<-readRDS("data/Source_Classification_Code.rds")

# subset all the sources that contain the world
# Coal in the short name variable. This variable
# contains contributions from all the four category levels
SCC.coal<-SCClist[grep('[Cc]oal',SCClist$Short.Name),]

# merge the pm25 emission data with the filtered
# category list
mergedCoalpm25=merge(pm25em,SCC.coal,by="SCC")

# compute the sum of total emission for each year (from 1999 to 2008)
totCoalEmpy<-tapply(mergedCoalpm25$Emissions,mergedCoalpm25$year, sum, na.rm=T)

#create a data frame to plot the data
totCoalEmissionpm25<-data.frame(year=names(totCoalEmpy), totEm=totCoalEmpy, row.names = NULL)

# open the bitmap device
png(file="plot4.png")

# print the graph using type as a factor
p<-ggplot(totCoalEmissionpm25,aes(year,totEm))
p+geom_point(size=4)+labs(y="PM2.5 Total Emissions (tons)") + labs(title="Total PM2.5 emissions from coal combustion-related sources \n from 1999 to 2008") + theme(plot.title = element_text(hjust = 0.5))

# close the device
dev.off()


