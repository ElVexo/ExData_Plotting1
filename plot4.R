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

#Export to png (moved here for strange formatting issues related to legend)
dev.copy(png, file = "ExData_Plotting1/plot4.png", height = 480, width = 480)

#Set plot area for 2x2 grid
par(mfrow = c(2,2),mar=c(4,4,1,1),oma=c(0,0,2,2))

#Plot A is same as plot 2

#Force Global Active Power values to be numeric
subhpc$Global_active_power <- as.numeric(as.character((subhpc$Global_active_power)))

#Draw plot
plot(subhpc$Date_time, subhpc$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "", cex = .75)

#Plot B is same as plot A, but using voltage

#Force Voltage values to be numeric
subhpc$Voltage <- as.numeric(as.character((subhpc$Voltage)))

#Draw plot
plot(subhpc$Date_time, subhpc$Voltage, type = "l", ylab = "Voltage", xlab = "datetime", cex = .75)

#Plot C is the same as plot 3

#Force Sub-metering values to be numeric
subhpc$Sub_metering_1 <- as.numeric(as.character((subhpc$Sub_metering_1)))
subhpc$Sub_metering_2 <- as.numeric(as.character((subhpc$Sub_metering_2)))
subhpc$Sub_metering_3 <- as.numeric(as.character((subhpc$Sub_metering_3)))

#Draw plot
plot(subhpc$Date_time, subhpc$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", cex = .75)
points(subhpc$Date_time, subhpc$Sub_metering_2, type = "l", col = "Red")
points(subhpc$Date_time, subhpc$Sub_metering_3, type = "l", col = "Blue")

#Add legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1), lwd = c(2.5,2.5), 
       col = c("black", "blue", "red"), cex = .75, bty = "n", xjust = 0)

#Plot D is the same as plot 1, but using Global Reactive Power

#Force Global Reactive Power values to be numeric
subhpc$Global_reactive_power <- as.numeric(as.character((subhpc$Global_reactive_power)))

#Draw plot
plot(subhpc$Date_time, subhpc$Global_reactive_power, type = "l", ylab = "global_reactive_power", xlab = "datetime", cex = .75)

dev.off()