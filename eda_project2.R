NEI <- readRDS("~/R/NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/R/NEI_data/Source_Classification_Code.rds")

yearly <- aggregate(Emissions~year,NEI,sum)
with(yearly, 
     plot(year,Emissions/10^6, type="b", pch=20,
          main="Total emissions by year", 
          ylab="PM2.5 Emission (in million tons)"))

baltimore <- aggregate(Emissions~year,data=subset(NEI,fips=="24510"),sum)
with(baltimore, 
     plot(year,Emissions, type="b", pch=20,
          main="Total emissions in Baltimore City", 
          ylab="PM2.5 Emission (tons)"))

baltimore_bytype <- aggregate(Emissions~year+type,data=subset(NEI,fips=="24510"),sum)
ggplot(baltimore_bytype, aes(x=year, y=Emissions, colour=type)) + geom_line() + geom_point() +
    scale_x_continuous(breaks=seq(1999,2008,by=3)) +
    labs(title="PM2.5 Emissions in Baltimore City by type of source",
         y="PM2.5 Emissions (tons)")

coal <- subset(SCC, grepl("Coal",EI.Sector))
coal_yearly <- aggregate(Emissions~year,data=subset(NEI,is.element(NEI$SCC, coal$SCC)),sum)
ggplot(coal_yearly, aes(x=year, y=Emissions)) + geom_line() + geom_point() +
    scale_x_continuous(breaks=seq(1999,2008,by=3)) +
    labs(title="PM2.5 emissions from coal combustion-related sources",
         y="PM2.5 Emissions (tons)")

motor <- subset(SCC, grepl("Vehicles",EI.Sector))
motor_baltimore <- aggregate(Emissions~year,data=subset(NEI,fips=="24510" & is.element(NEI$SCC, motor$SCC)),sum)
ggplot(motor_baltimore, aes(x=year, y=Emissions)) + geom_line() + geom_point() +
    scale_x_continuous(breaks=seq(1999,2008,by=3)) +
    labs(title="PM2.5 emissions from motor vehicle sources in Baltimore City",
         y="PM2.5 Emissions (tons)")

motor_comp <- aggregate(Emissions~year+fips,data=subset(NEI,(fips=="24510"|fips=="06037") & is.element(NEI$SCC, motor$SCC)),sum)
ggplot(motor_comp, aes(x=year,y=Emissions,colour=fips)) + geom_line() + geom_point() +
    scale_x_continuous(breaks=seq(1999,2008,by=3)) +
    labs(title="PM2.5 emissions from motor vehicle sources",
         y="PM2.5 Emissions (tons)") +
    scale_color_manual(name = "City",
                       labels = c("Los Angeles County","Baltimore City"), 
                       values = c("blue","red"))
