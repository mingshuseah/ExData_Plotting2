# Download and read data
zipUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFile <- "NEI_data.zip"
if (!file.exists(zipFile)) {
    download.file(zipUrl, zipFile, mode = "wb")
    unzip(zipFile, exdir="NEI_data")
}
NEI <- readRDS("~/NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/NEI_data/Source_Classification_Code.rds")

# Plot 3 - Emissions in Baltimore City by source type
baltimore_bytype <- aggregate(Emissions~year+type,data=subset(NEI,fips=="24510"),sum)
png("plot3.png")
ggplot(baltimore_bytype, aes(x=year, y=Emissions, colour=type)) + geom_line() + geom_point() +
    scale_x_continuous(breaks=seq(1999,2008,by=3)) +
    labs(title="PM2.5 Emissions in Baltimore City by source type",
         y="PM2.5 Emissions (tons)")
dev.off()