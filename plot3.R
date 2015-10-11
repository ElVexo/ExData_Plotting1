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

#Force Sub-metering values to be numeric
subhpc$Sub_metering_1 <- as.numeric(as.character((subhpc$Sub_metering_1)))
subhpc$Sub_metering_2 <- as.numeric(as.character((subhpc$Sub_metering_2)))
subhpc$Sub_metering_3 <- as.numeric(as.character((subhpc$Sub_metering_3)))

#Export to png
dev.copy(png, file = "ExData_Plotting1/plot3.png", height = 480, width = 480)

#Set plot area
par(mfrow = c(1,1))

#Draw plot
plot(subhpc$Date_time, subhpc$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
points(subhpc$Date_time, subhpc$Sub_metering_2, type = "l", col = "Red")
points(subhpc$Date_time, subhpc$Sub_metering_3, type = "l", col = "Blue")

#Add legend
legend("topright", legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"), lty = c(1,1), lwd = c(2.5,2.5), 
       col = c("black", "blue", "red"))

#Export to png
#dev.copy(png, file = "ExData_Plotting1/plot3.png", height = 480, width = 480)
dev.off()