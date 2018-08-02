# Download and read data
zipUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFile <- "NEI_data.zip"
if (!file.exists(zipFile)) {
    download.file(zipUrl, zipFile, mode = "wb")
    unzip(zipFile, exdir="NEI_data")
}
NEI <- readRDS("~/NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/NEI_data/Source_Classification_Code.rds")

# Plot 2 - Emissions in Baltimore City
baltimore <- aggregate(Emissions~year,data=subset(NEI,fips=="24510"),sum)
png("plot2.png")
with(baltimore, 
     plot(year,Emissions, type="b", pch=20,
          main="Total emissions in Baltimore City", 
          xaxp=c(1999,2008,3),
          ylab="PM2.5 Emission (tons)"))
dev.off()