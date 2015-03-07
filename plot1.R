#to read in the data
dat = read.table("household_power_consumption.txt",
                 sep=";",
                 dec=".",
                 header=TRUE,
                 stringsAsFactors=FALSE,
                 na.strings="?",
                 colClasses=c(rep("character",2), rep("numeric",7)))
dat$Date  <- as.Date(dat$Date, "%d/%m/%Y") #sort date class
dat2  <-  subset(dat, Date =="2007-02-01") #choose relevant subset of data
dat3  <-  subset(dat, Date =="2007-02-02")
dat4  <- rbind(dat2, dat3)

#to deal with time - "datetime" is the new composed Date-Time vector
datetime  <- 1:2880
datetime  <- lapply(datetime, function(x) paste(dat4$Date[x], dat4$Time[x], sep = " "))
datetime <- as.character(datetime)
datetime <- as.POSIXct(datetime)

#reldata is the relevant dataset with the additional combined date-time col
reldata  <- cbind(dat4, datetime)

#Compose plot1.png

#Plot 1
png(filename = "plot1.png", width = 480, height = 480)
hist(reldata$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
dev.off()

