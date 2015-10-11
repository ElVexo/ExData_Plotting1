#Load libraries
library(lubridate)

#Load raw data file.
hpc <- read.csv("data/household_power_consumption.txt", sep = ";", header = TRUE)

#Subset data to only the two days we are interested in.
subhpc <- subset(hpc, hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007")

#Create a single datetime fields from the separate date and time fields.
subhpc$Date_time <- dmy_hms(paste(subhpc$Date, subhpc$Time))

#Reorder coumns.
subhpc <- subhpc[,c(10,3,4,5,6,7,8,9)]

#Replace ?s with NAs.
subhpc[, 2:8][subhpc[, 2:8] == "?"] <- NA

#Force Global Active Power values to be numeric
subhpc$Global_active_power <- as.numeric(as.character((subhpc$Global_active_power)))

#Set plot area
par(mfrow = c(1,1))

#Draw histogram
hist(subhpc$Global_active_power, col = "Red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#Save histogram
dev.copy(png, file = "ExData_Plotting1/plot1.png", height = 480, width = 480)
dev.off()
