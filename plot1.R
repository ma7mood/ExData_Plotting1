## Reading the Data
#####################

# There are 2,075,259 rows and from UCI repository link we know there are 47 months
# Therefore each month has approximately (2,075,259/47 ~= 44155) rows 
# From UCI repository link we also know that the first month is december 2006, 
# and as we need the third month (february 2007), we can pull in approximately
# (44,155*3 = 132,465) rows from the start.

power <- read.table('household_power_consumption.txt', 
                    header = TRUE, 
                    sep = ';', 
                    colClasses = c('character', 'character', rep('numeric', 7)), 
                    nrows = 132464, 
                    comment.char = "", 
                    na.strings = "?")

# convert the time variable from character to POSIXct class. 
# POSIXlt class cannot be plotted using plot() function.
# strptime() attaches the current date to the values of the 
# time variable, so to prevent that, we use the paste() function 
# to attach the the 'Date' variable to our 'Time' variable.
power$Time <- as.POSIXct(strptime(paste(power$Date, " ", power$Time), 
                                  format = "%d/%m/%Y %H:%M:%S"))

# convert the date column from character class to Date class
power$Date <- as.Date(strptime(power$Date, format = "%d/%m/%Y"))

# take the subset consisting of the only two dates we require
powerSub <- subset(power, Date >= '2007-02-01' & Date <= '2007-02-02')

## Plotting The Graph
#####################

# the default height and width are 480 pixels
# opening our png device
png(filename = 'plot1.png')

# A simple histogram with the appropriate title and axis labels
hist(powerSub$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     col = 'red')

# shutdown the current device (png device)
dev.off()