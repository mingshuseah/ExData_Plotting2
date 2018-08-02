# Download and read data
zipUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFile <- "NEI_data.zip"
if (!file.exists(zipFile)) {
    download.file(zipUrl, zipFile, mode = "wb")
    unzip(zipFile, exdir="NEI_data")
}
NEI <- readRDS("~/NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/NEI_data/Source_Classification_Code.rds")

# Plot 5 - Emissions from motor vehicle sources in Baltimore City
motor <- subset(SCC, grepl("Vehicles",EI.Sector))
png("plot5.png")
motor_baltimore <- aggregate(Emissions~year,data=subset(NEI,fips=="24510" & is.element(NEI$SCC, motor$SCC)),sum)
ggplot(motor_baltimore, aes(x=year, y=Emissions)) + geom_line() + geom_point() +
    scale_x_continuous(breaks=seq(1999,2008,by=3)) +
    labs(title="PM2.5 emissions from motor vehicle sources in Baltimore City",
         y="PM2.5 Emissions (tons)")
dev.off()