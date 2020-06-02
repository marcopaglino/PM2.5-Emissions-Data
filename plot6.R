# How have emissions from motor vehicle sources 
# changed from 1999–2008 in Baltimore City?

#library(dplyr)
library(ggplot2)

# read the PM2.5 Emissions Data file
#pm25em<-readRDS("data/summarySCC_PM25.rds")

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
# for each year (from 1999 to 2008) in Baltimore City and in LA
totEmVehicleBaltpy<-tapply(mergedVehiclepm25[mergedVehiclepm25$fips=='24510',]$Emissions,
                           mergedVehiclepm25[mergedVehiclepm25$fips=='24510',]$year,
                           sum,
                           na.rm=T)

totEmVehicleLApy<-tapply(mergedVehiclepm25[mergedVehiclepm25$fips=='06037',]$Emissions,
                           mergedVehiclepm25[mergedVehiclepm25$fips=='06037',]$year,
                           sum,
                           na.rm=T)


#create  data frames for each city
totVehpm25Balt.df<-data.frame(year=names(totEmVehicleBaltpy), 
                              totEm=totEmVehicleBaltpy, city="Baltimore",row.names = NULL)

totVehpm25LA.df<-data.frame(year=names(totEmVehicleLApy), 
                            totEm=totEmVehicleLApy, city="Los Angeles",row.names = NULL)

#create  data frames with variations trhough the year for each city
deltaBalt=data.frame(year=totVehpm25Balt.df[2:4,"year"], 
           delta=abs(diff(totVehpm25Balt.df$totEm)),city="Baltimore")

deltaLA=data.frame(year=totVehpm25LA.df[2:4,"year"], 
           delta=abs(diff(totVehpm25LA.df$totEm)),city="Los Angeles")

#bind the data frame by row 
totVehpm25delta.df<-rbind(deltaBalt, deltaLA)

# open the bitmap device
png(file="plot6.png")


p2<-ggplot(totVehpm25delta.df,aes(year,delta))
p2+geom_point(size=4,alpha=0.5, aes(col=factor(city)))+labs(y="Delta PM2.5 Total Emissions (tons)") + labs(title="Total PM2.5 emissions changes from motor vehicle sources \n from 1999 to 2008 in Baltimore City and Los Angeles", color="city") + theme(plot.title = element_text(size=10,hjust = 0.5))  

# close the device
dev.off()


