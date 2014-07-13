###########################
# Generate the FOURTH PLOT
###########################

## Questions to consider
### 1
### The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory the dataset will require in memory
### before reading into R. Make sure your computer has enough memory (most modern computers should be fine).

numRows<-2075259
nCol<-9
estBytes<-8

print(paste0("Aproximate memry usage: ",numRows*nCol*estBytes, " bytes"))
print(paste0("Aproximate memry usage: ",numRows*nCol*estBytes/1000000, " Mb"))


### 2
### We will only be using data from the dates 2007-02-01 and 2007-02-02.
### One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.

### 3
### You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.

### 4
### Note that in this dataset missing values are coded as ?

## Read Data
mydata<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?",stringsAsFactors=FALSE)
head(mydata)
str(mydata)
trans<-mydata
trans$Date<-as.Date(mydata$Date,"%d/%m/%Y") #Convert string data to Date type data
# trans$Time<-strptime(mydata$Time,"%H:%M:%S",tz = "EST5EDT") if only Time is what you want
dateAndTime<-paste(mydata$Date,mydata$Time)
trans$Time<-strptime(dateAndTime,"%d/%m/%Y %H:%M:%S",tz = "EST5EDT")
## Converting as numeric the rest of variables Note: not strictly necessary for this plot
for (i in 3:9) {
  trans[,i]<-as.numeric(mydata[,i])
}
str(trans)
head(trans)
## select rows within desired range and Construct the plot
seldataX<-trans[trans$Date == "2007-02-01" | trans$Date == "2007-02-02",]
####
par(mfrow = c(2, 2))
#First Plot
plot(seldataX$Time,seldataX$Global_active_power,type='l',ylab="Global Active Power (kilowatts)",xlab="")
#Second Plot
plot(seldataX$Time,seldataX$Voltage,type="l",ylab="Voltage",xlab="datetime")
#Third Plot
plot(seldataX$Time,seldataX$Sub_metering_1,type='l',ylab="Energy sub metering",xlab="")
lines(seldataX$Time,seldataX$Sub_metering_2,col="red")
lines(seldataX$Time,seldataX$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))
#Fourth Plot
plot(seldataX$Time,seldataX$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")







# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
#First Plot
plot(seldataX$Time,seldataX$Global_active_power,type='l',ylab="Global Active Power (kilowatts)",xlab="")
#Second Plot
plot(seldataX$Time,seldataX$Voltage,type="l",ylab="Voltage",xlab="datetime")
#Third Plot
plot(seldataX$Time,seldataX$Sub_metering_1,type='l',ylab="Energy sub metering",xlab="")
lines(seldataX$Time,seldataX$Sub_metering_2,col="red")
lines(seldataX$Time,seldataX$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))
#Fourth Plot
plot(seldataX$Time,seldataX$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")
dev.off()

# THE END (FOURTH PLOT)
###########################