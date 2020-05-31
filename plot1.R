# Have total emissions from PM2.5 decreased 
# in the United States from 1999 to 2008? 

# read the PM2.5 Emissions Data file
pm25em<-readRDS("data/summarySCC_PM25.rds")

# compute the sum of total emission for each year (from 1999 to 2008)
totEmpy<-tapply(pm25em$Emissions,pm25em$year, sum, na.rm=T)

#create a data frame to plot the data
totEmissionpm25<-data.frame(year=names(totEmpy), totEm=totEmpy, row.names = NULL)

# open the bitmap device
png(file="plot1.png")

# plot the data without axis
plot.default(totEmissionpm25$year,
             totEmissionpm25$totEm,
             pch=20,
             cex=3,
             type='p', axes=F, 
             ylab="PM2.5 Total Emissions (million of tons)", 
             xlab="year")

# add the x axis
axis(side=1, 
     at=as.numeric(totEmissionpm25$year), 
     labels = totEmissionpm25$year)

# add the y axis
axis(side=2, 
     at=totEmissionpm25$totEm, 
     las=2, 
     cex.axis=1, 
     labels = round(totEmissionpm25$totEm/1000000,2))

#add main title
mtext("Total PM2.5 emissions from all sources from 1999 to 2008")

# close the device
dev.off()
