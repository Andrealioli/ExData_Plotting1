# downloading and unziping file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"


#Create a subdirectory called data and download the file
dir.create("./project1")
download.file(url,destfile="./project1/Dataset.zip")
#Loading in the data files
unzip("./project1/Dataset.zip",exdir="./project1")
#Setting work directory
setwd("~/project1")

#Loading file
file_path<- paste(getwd(), paste("household_power_consumption", ".txt", sep=""), sep="/")
house_con_file <- read.table(file_path, header=TRUE, sep=";")
#Subsseting the data 
house_con_file$Date <- as.Date(house_con_file$Date, format="%d/%m/%Y")
house_con_file <- subset(house_con_file, Date >= "2007-02-01" & Date<= "2007-02-02") 
#Combining the conlumns of date and time 
house_con_file$Date1 <- paste(house_con_file$Date,house_con_file$Time)
house_con_file$Date1 <- strptime(house_con_file$Date1, format="%Y-%m-%d %H:%M:%S")
#Plotting the graphic
house_con_file[,7] <- as.numeric(as.character(house_con_file[,7]))
house_con_file[,8] <- as.numeric(as.character(house_con_file[,8]))
house_con_file[,9] <- as.numeric(as.character(house_con_file[,9]))
#Plotting Sub 1
windows(width=10, height=10)
par(mfrow=c(2,2))
#Plotting Graphic 1 
plot_1 <- as.numeric(as.character(house_con_file$Global_active_power))
plot(house_con_file$Date1, plot_1, type="n",ylab="Global Active Power (kilowatts)", xlab="")
lines(house_con_file$Date1, plot_1)
#Plotting Graphic 2
plot_2 <- as.numeric(as.character(house_con_file$Voltage))
plot(house_con_file$Date1, plot_2, type="n",ylab="Voltage", xlab="datetime")
lines(house_con_file$Date1, plot_2)
#Plotting Graphic 3
plot(house_con_file$Date1, house_con_file[,7], type="n",ylab="Energy sub metering", xlab="")
lines(house_con_file$Date1, house_con_file[,7], col="black")
lines(house_con_file$Date1, house_con_file[,8], col="red")
lines(house_con_file$Date1, house_con_file[,9], col="blue")
legend_names <- colnames(house_con_file)[7:9]
legend("topright",legend_names, lty=c(1,1,1), lwd = c(0.2,0.2,0.2), 
       col=c("black","red", "blue"),cex=0.8, bty='n')


#Plotting 4 
plot_3 <- as.numeric(as.character(house_con_file$Global_reactive_power))
plot(house_con_file$Date1, plot_3, type="n",ylab="Global_reactive_power", xlab="datetime")
lines(house_con_file$Date1, plot_3)


#Saving the graphic in PNG
dev.copy(png, file="plot4.png", width = 480, height = 480, units="px", bg="white")
dev.off()


