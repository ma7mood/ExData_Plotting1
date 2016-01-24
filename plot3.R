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
png(filename = 'plot3.png')

# make an empty plot with relevant labels
# We use Sub_metering_1 for y-axis as its range encompasses the range of
# other energy submetering numbers
with(powerSub, 
     plot(Sub_metering_1 ~ Time, 
          type = 'n', 
          ylab = 'Energy sub metering', 
          xlab = ''))

# add the lines with specific colors.
with(powerSub, lines(Sub_metering_1 ~ Time, col = 'black'))
with(powerSub, lines(Sub_metering_2 ~ Time, col = 'red'))
with(powerSub, lines(Sub_metering_3 ~ Time, col = 'blue'))

# add the legend using the colors as specified above
with(powerSub, 
     legend("topright", 
            legend = names(powerSub[,7:9]), 
            col = c('black', 'red', 'blue'), 
            lty = 1))

dev.off()