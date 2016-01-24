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
png(filename = 'plot4.png')

# Produce a 2 by 2 grid for plot presentation ordered column-wise
par(mfcol = c(2,2))

# 1st plot, same as the plot2.png without '(kilowatts)' on the y-axis
with(powerSub, 
     plot(Global_active_power ~ Time, 
          type = 'l', 
          ylab = 'Global Active Power', 
          xlab = ""))

# 2nd plot, same as our plot3.png
with(powerSub, 
     plot(Sub_metering_1 ~ Time, 
          type = 'n', 
          ylab = 'Energy sub metering', 
          xlab = ''))
with(powerSub, lines(Sub_metering_1 ~ Time, col = 'black'))
with(powerSub, lines(Sub_metering_2 ~ Time, col = 'red'))
with(powerSub, lines(Sub_metering_3 ~ Time, col = 'blue'))
with(powerSub, 
     legend("topright", 
            legend = names(powerSub[,7:9]), 
            col = c('black', 'red', 'blue'), 
            lty = 1, bty = 'n'))

# 3rd Plot, line graph, with x-axis label changed to 'datetime'
with(powerSub, plot(Voltage ~ Time, type = 'l', xlab = 'datetime'))

# 4th Plot, line graph with x-axis label changed to 'datetime'
with(powerSub, plot(Global_reactive_power ~ Time, 
                    type = 'l', xlab = 'datetime'))


dev.off()