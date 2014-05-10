library(data.table)

# download file
file_name <- "household_power_consumption"
txt_file <- paste0(file_name, ".txt")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", zip_file)

# unzip file
zip_file <- paste0(file_name, ".zip")
unzip(zip_file)

# read file into table
dt <- read.table(txt_file, header=T, sep=";", na.strings = "?", colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric" ))

# convert first column to Date type
dt_date <- as.Date(dt$Date, "%d/%m/%Y")

# select 2 days of data
dt_2d <- dt[dt_date >= as.Date("2007-02-01") & dt_date <= as.Date("2007-02-02"),]

# convert first to columns to POSIXct typw
dt_time <- strptime(paste(dt_2d$Date, dt_2d$Time), "%d/%m/%Y %H:%M:%S")

# add POSIXct column to data
dt_c <- cbind(dt_time, dt_2d)

# draw plot
png("plot3.png")
plot(dt_c[,1], dt_c[,8], type="l", xlab="", ylab="Energy sub metering")
lines(dt_c[,1], dt_c[,9], col="red")
lines(dt_c[,1], dt_c[,10], col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1))
dev.off()