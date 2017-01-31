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
windows(width=8, height=10)
house_con_file[,7] <- as.numeric(as.character(house_con_file[,7]))
house_con_file[,8] <- as.numeric(as.character(house_con_file[,8]))
house_con_file[,9] <- as.numeric(as.character(house_con_file[,9]))
#Plotting Sub 1
plot(house_con_file$Date1, house_con_file[,7], type="n",ylab="Energy sub metering", xlab="", cex.axis=0.9, 
     cex.lab=0.9)
lines(house_con_file$Date1, house_con_file[,7], col="black")
#Plotting Sub 2
lines(house_con_file$Date1, house_con_file[,8], col="red")
#Plotting Sub 3
lines(house_con_file$Date1, house_con_file[,9], col="blue")

#Incluiding a legend
legend_names <- colnames(house_con_file)[7:9]
legend(x="topright",legend_names, lty=c(1,1,1), lwd = c(0.5,0.5,0.5), 
       col=c("black","red", "blue"), cex=0.8)

#Saving the graphic in PNG
dev.copy(png, file="plot3.png", width = 480, height = 480, units="px", bg="white")
dev.off()


