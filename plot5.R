# How have emissions from motor vehicle sources 
# changed from 1999–2008 in Baltimore City?

#library(dplyr)
library(ggplot2)

# read the PM2.5 Emissions Data file
# pm25em<-readRDS("data/summarySCC_PM25.rds")

# read the Source Classification Code Table
SCClist<-readRDS("data/Source_Classification_Code.rds")

# subset all the sources that contain the world
# Vehicle in the short name variable. This variable
# contains contributions from all the four category levels
SCC.vehicle<-SCClist[grep('[Vv]ehicle',SCClist$Short.Name),]

# merge the pm25 emission data with the filtered
# category list
mergedVehiclepm25=merge(pm25em,SCC.vehicle,by="SCC")

# compute the sum of total emission from motor vehicle sources
# for each year (from 1999 to 2008) in Baltimore City
totEmVehicleBaltpy<-tapply(mergedVehiclepm25[mergedVehiclepm25$fips=='24510',]$Emissions,
                    mergedVehiclepm25[mergedVehiclepm25$fips=='24510',]$year,
                    sum,
                    na.rm=T)

#create a data frame to plot the data
totVehicleEmissionpm25<-data.frame(year=names(totEmVehicleBaltpy), totEm=totEmVehicleBaltpy, row.names = NULL)

# open the bitmap device
png(file="plot5.png")

# print the graph using type as a factor
p<-ggplot(totVehicleEmissionpm25,aes(year,totEm))
p+geom_point(size=4)+labs(y="PM2.5 Total Emissions (tons)") + labs(title="Total PM2.5 emissions from motor vehicle sources \n from 1999 to 2008 in Baltimore City") + theme(plot.title = element_text(hjust = 0.5))

# close the device
dev.off()


