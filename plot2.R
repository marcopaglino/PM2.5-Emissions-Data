# Have total emissions from PM2.5 decreased in the 
# Baltimore City, Maryland from 1999 to 2008?

# read the PM2.5 Emissions Data file
pm25em<-readRDS("data/summarySCC_PM25.rds")

# compute the sum of total emission for each year
# (from 1999 to 2008) in the Baltimore City
totEmBaltpy<-tapply(pm25em[pm25em$fips=='24510',]$Emissions,
                    pm25em[pm25em$fips=='24510',]$year,
                    sum,
                    na.rm=T)

#create a data frame to plot the data
totEmissionBaltpm25<-data.frame(year=names(totEmBaltpy),
                            totEm=totEmBaltpy, 
                            row.names = NULL)

# open the bitmap device
png(file="plot2.png")

# plot the data without axis
plot.default(totEmissionBaltpm25$year,
             totEmissionBaltpm25$totEm,
             pch=20,
             cex=3,
             type='p', axes=F, 
             ylab="PM2.5 Total Emissions (thousands of tons)", 
             xlab="year")

# add the x axis
axis(side=1, 
     at=as.numeric(totEmissionBaltpm25$year), 
     labels = totEmissionBaltpm25$year)

# add the y axis
axis(side=2, 
     at=totEmissionBaltpm25$totEm, 
     las=2, 
     cex.axis=1, 
     labels = round(totEmissionBaltpm25$totEm/1000,2))

#add main title
mtext("Total PM2.5 emissions from all sources from 1999 to 2008 in Baltimore City")

# close the device
dev.off()
