setwd("~/Data Science/airpollution")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(dplyr)

NEI <- subset(NEI, fips == "24510")
NEI <- group_by(NEI, year, type)
typed <- summarize(NEI, total = sum(Emissions))

g <- ggplot(typed, aes(as.numeric(as.character(year)), total))
p <- g + geom_point() + facet_grid(.~ typed$type) + geom_smooth(method = "lm", col = "steelblue") + xlab("Year") + ylab("Total emissions in Baltimore") + ggtitle("PM2.5 emissions for Baltimore by type and year") + theme_minimal()
print(p)

dev.copy(png, "plot3.png")
dev.off()
