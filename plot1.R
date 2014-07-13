
###########################
# Generate the FIRST PLOT
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
hist(seldataX$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")

# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
png("plot1.png", width = 480, height = 480)
hist(seldataX$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")
dev.off()


# THE END (FIRST PLOT)
###########################
