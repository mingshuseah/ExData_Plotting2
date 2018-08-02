# Download and read data
zipUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFile <- "NEI_data.zip"
if (!file.exists(zipFile)) {
    download.file(zipUrl, zipFile, mode = "wb")
    unzip(zipFile, exdir="NEI_data")
}
NEI <- readRDS("~/NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/NEI_data/Source_Classification_Code.rds")

# Plot 4 - Emissions from coal combustion-related sources
coal <- subset(SCC, grepl("Coal",EI.Sector))
png("plot4.png")
coal_yearly <- aggregate(Emissions~year,data=subset(NEI,is.element(NEI$SCC, coal$SCC)),sum)
ggplot(coal_yearly, aes(x=year, y=Emissions)) + geom_line() + geom_point() +
    scale_x_continuous(breaks=seq(1999,2008,by=3)) +
    labs(title="PM2.5 emissions from coal combustion-related sources",
         y="PM2.5 Emissions (tons)")
dev.off()