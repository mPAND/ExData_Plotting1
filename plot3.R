setwd("/Users/manueldavidpandian/eda-ca1/")

if (! file.exists("data/household_power_consumption.txt") ) {
  dir.create("data")
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                , destfile="data/exdata.zip"
                , method ="curl"
                )
  setwd("data")
  unzip("exdata.zip") 
}

library(data.table)
d1<- fread(input="household_power_consumption.txt",na.strings="?")

is.data.table(d1)
d1[, Date2:= paste(Date,Time,sep=" ") ]
d1[, dfinal:= as.POSIXct(x=Date2,format="%d/%m/%Y %H:%M:%S",)]
d1[, Time:=NULL]
d1[, Date:=NULL]
d1[, Date2:=NULL]
d2<- d1[ dfinal >= as.POSIXct("2007-02-01",format="%Y-%m-%d") &
      dfinal < as.POSIXct("2007-02-03",format="%Y-%m-%d")]

setwd("/Users/manueldavidpandian/eda-ca1/")

attach(d2)
png(filename="plot3.png",width=480,height=480)
plot(x=dfinal,y=Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
lines(x=dfinal,y=Sub_metering_1,type="l")
lines(x=dfinal,y=Sub_metering_2,type="l",col="red")
lines(x=dfinal,y=Sub_metering_3,type="l",col="blue")
legend("topright",legend=c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3") , col=c("black","red","blue"),lty=c(1,1,1))
dev.off()
