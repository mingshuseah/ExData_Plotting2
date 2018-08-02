# Download and read data
zipUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFile <- "NEI_data.zip"
if (!file.exists(zipFile)) {
    download.file(zipUrl, zipFile, mode = "wb")
    unzip(zipFile, exdir="NEI_data")
}
NEI <- readRDS("~/NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/NEI_data/Source_Classification_Code.rds")

# Plot 1 - Total emissions by year
yearly <- aggregate(Emissions~year,NEI,sum)
png("plot1.png")
with(yearly, 
     plot(year,Emissions/10^6, type="b", pch=20, ylim=c(3,8),
          main="Total emissions by year", 
          xaxp=c(1999,2008,3),
          ylab="PM2.5 Emission (in million tons)"))
dev.off()