setwd("~/Data Science/airpollution")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(dplyr)

NEI <- subset(NEI, fips == "24510")
pm25sum <- with(NEI, tapply(Emissions, year, sum))
pm25sum <- tbl_df(data.frame(year = names(pm25sum), total = pm25sum))

with(pm25sum, plot(as.numeric(as.character(year)), total, type = "l", lwd = 2, col = "steelblue", xlab = "Year", ylab = "Total PM2.5 emissions in Baltimore", main = "Total emissions in Baltimore vs year"))

dev.copy(png, "plot2.png")
dev.off()

