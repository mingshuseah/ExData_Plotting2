# Download and read data
zipUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFile <- "NEI_data.zip"
if (!file.exists(zipFile)) {
    download.file(zipUrl, zipFile, mode = "wb")
    unzip(zipFile, exdir="NEI_data")
}
NEI <- readRDS("~/NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/NEI_data/Source_Classification_Code.rds")

# Plot 6 - Emissions from motor vehicles, Los Angeles and Baltimore
motor <- subset(SCC, grepl("Vehicles",EI.Sector))
motor_comp <- aggregate(Emissions~year+fips,data=subset(NEI,(fips=="24510"|fips=="06037") & is.element(NEI$SCC, motor$SCC)),sum)
png("plot6.png")
ggplot(motor_comp, aes(x=year,y=Emissions,colour=fips)) + geom_line() + geom_point() +
    scale_x_continuous(breaks=seq(1999,2008,by=3)) +
    labs(title="PM2.5 emissions from motor vehicle sources",
         y="PM2.5 Emissions (tons)") +
    scale_color_manual(name = "City",
                       labels = c("Los Angeles County","Baltimore City"), 
                       values = c("blue","red"))
dev.off()