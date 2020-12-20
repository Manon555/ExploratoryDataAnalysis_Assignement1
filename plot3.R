### Exploratory Data Analysis Assignment 1 - R script for plot 3 ###

## Description of data set and variables ##

# Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. 
# Different electrical quantities and some sub-metering values are available.
# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
# - Date: Date in format dd/mm/yyyy
# - Time: time in format hh:mm:ss
# - Global_active_power: household global minute-averaged active power (in kilowatt)
# - Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# - Voltage: minute-averaged voltage (in volt)
# - Global_intensity: household global minute-averaged current intensity (in ampere)
# - Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# - Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# - Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

# Load packages
library(dplyr)

## Part 1: Loading and subsetting data ##

# estimate the required memory
# GB (for data frame with numeric data)
2075259*9*8/2^{30} # 0.139157 GB

# load data
con = unzip("exdata_data_household_power_consumption.zip")
data = read.table(con, header=TRUE, sep=";", colClasses=
                    c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"), na.strings="?")
# overview of data table
head(data)
str(data)
summary(data)

# convert Date and Time variables to Date/Time classes in R
data = mutate(data, Time=strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"), Date=as.Date(Date, "%d/%m/%Y"))
str(data)

# subset data using dates 2007-02-01 and 2007-02-02 only
data = filter(data, (Date=="2007-02-01" | Date =="2007-02-02"))


## Part 2: Plotting (plot 3) ##

# Change locale to get English weekdays 
Sys.setlocale("LC_TIME", "C")

# create line plot with colors and legend
png(file="plot3.png", width=480, height=480)
with(data,plot(Time, Sub_metering_1, type="l", xlab="", ylab="Energy Sub metering"))
with(data,points(Time, Sub_metering_2, type="l", col="red"))
with(data,points(Time, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=1, legend=names(data)[7:9], col=c("black","red","blue"))
dev.off()

