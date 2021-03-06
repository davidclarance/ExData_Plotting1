#to read in the data
dat = read.table("household_power_consumption.txt",
                 sep=";",
                 dec=".",
                 header=TRUE,
                 stringsAsFactors=FALSE,
                 na.strings="?",
                 colClasses=c(rep("character",2), rep("numeric",7)))
dat$Date  <- as.Date(dat$Date, "%d/%m/%Y")
dat2  <-  subset(dat, Date =="2007-02-01")
dat3  <-  subset(dat, Date =="2007-02-02")
dat4  <- rbind(dat2, dat3)

#to deal with time - "datetime" is the new composed Date-Time vector
datetime  <- 1:2880
datetime  <- lapply(datetime, function(x) paste(dat4$Date[x], dat4$Time[x], sep = " "))
datetime <- as.character(datetime)
datetime <- as.POSIXct(datetime)

#reldata is the relevant dataset with the additional combined date-time col
reldata  <- cbind(dat4, datetime)

# Compose Plot 3
png(filename = "plot3.png", width = 480, height = 480)
with(reldata, plot(datetime, Sub_metering_1, ylab = "Energy sub metering", xlab="", type = "l" ))
with(reldata, lines(datetime, Sub_metering_2, col = "red"))
with(reldata, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright",lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"))
dev.off()

