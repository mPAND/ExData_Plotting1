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
png(filename="plot1.png",width=480,height=480)
hist(as.numeric(d2[,Global_active_power]),col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power", ylim=c(0,1200)  )
dev.off()
