setwd("~/Data Science/airpollution")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(dplyr)
library(gridExtra)

NEIl <- subset(NEI, fips == "06037")
NEI <- subset(NEI, fips == "24510")

list <- as.character(SCC[grepl("Vehicle", SCC$SCC.Level.Two), ][["SCC"]])
NEI <- subset(NEI, SCC %in% list)
NEIl <- subset(NEIl, SCC %in% list)

pm25sum <- with(NEI, tapply(Emissions, year, sum))
pm25suml <- with(NEIl, tapply(Emissions, year, sum))
pm25sum <- tbl_df(data.frame(year = names(pm25sum), total = pm25sum))
pm25suml <- tbl_df(data.frame(year = names(pm25suml), total = pm25suml))

g <- ggplot(pm25sum, aes(as.numeric(as.character(year)), total))
gl <- ggplot(pm25suml, aes(as.numeric(as.character(year)), total))

pb <- g + geom_point() + geom_smooth(method = "loess", col = "steelblue") + xlab("Year") + ylab("PM2.5 emissions from Motor Vehicle sources") + ggtitle("PM2.5 from MV in Baltimore") + theme_minimal() + ylim(0, 7500)
pl <- gl + geom_point() + geom_smooth(method = "loess", col = "steelblue") + xlab("Year") + ylab("PM2.5 emissions from Motor Vehicle sources") + ggtitle("PM2.5 from MV in LA") + theme_minimal() + ylim(0, 7500)

print(grid.arrange(pb, pl, nrow = 1))

dev.copy(png, "plot6.png")
dev.off()

