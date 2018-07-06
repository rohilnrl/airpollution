setwd("~/Data Science/airpollution")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(dplyr)

pm25sum <- with(NEI, tapply(Emissions, year, sum))
pm25sum <- tbl_df(data.frame(year = names(pm25sum), total = pm25sum))

with(pm25sum, plot(as.numeric(as.character(year)), total, type = "l", lwd = 2, col = "steelblue", xlab = "Year", ylab = "Total PM2.5 emissions", main = "Total emissions vs year"))

dev.copy(png, "plot1.png")
dev.off()

