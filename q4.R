setwd("~/Data Science/airpollution")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(dplyr)

list <- as.character(SCC[grepl("Coal", SCC$Short.Name), ][["SCC"]])
NEI <- subset(NEI, SCC %in% list)

pm25sum <- with(NEI, tapply(Emissions, year, sum))
pm25sum <- tbl_df(data.frame(year = names(pm25sum), total = pm25sum))
g <- ggplot(pm25sum, aes(as.numeric(as.character(year)), total))
p <- g + geom_point() + geom_smooth(method = "loess", col = "steelblue") + xlab("Year") + ylab("Total PM2.5 emissions from Coal sources") + ggtitle("Total emission of PM2.5 from Coal sources by year") + theme_minimal()
print(p)

dev.copy(png, "plot4.png")
dev.off()

