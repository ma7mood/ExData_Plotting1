### Reading the Data
#####################

# TWe read in the first 132,464 rows in the datset that includes the 2 dates we want
power <- read.table('household_power_consumption.txt', 
                    header = TRUE, 
                    sep = ';', 
                    colClasses = c('character', 'character', rep('numeric', 7)), 
                    nrows = 132464, 
                    comment.char = "", 
                    na.strings = "?")

# convert the time variable from character to POSIXct class.
power$Time <- as.POSIXct(strptime(paste(power$Date, " ", power$Time), 
                                  format = "%d/%m/%Y %H:%M:%S"))

# convert the date variable from character class to Date class
power$Date <- as.Date(strptime(power$Date, format = "%d/%m/%Y"))

# take the subset consisting of the only two dates we require
powerSub <- subset(power, Date >= '2007-02-01' & Date <= '2007-02-02')

## Plotting The Graph
#####################

# the default height and width are 480 pixels
png(filename = 'plot2.png')

# We want a line graph with no x-axis label
with(powerSub, 
     plot(Global_active_power ~ Time, 
          type = 'l', 
          ylab = 'Global Active Power (kilowatts)', 
          xlab = ""))

dev.off()