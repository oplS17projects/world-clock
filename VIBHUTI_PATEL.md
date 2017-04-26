# Graphical User Interface for World-Cloack app in Racket

## Vibhuti Patel
### April 26, 2017

# Overview
World - clock is an application which is useful to check current time for selected time zone. There is another important functionality of
time-convertor which converts future or past time and date in other time zone. 

The first set of code provides an graphical user interface to select time-zone for checking current time. Also second set of code
provides user interface to enter mm/dd/yyyy hour-minute-sec time inputs and time-zones for displaying converted time-date from one
timezone to another one.
Its most important feature is that algorithm do addition and substraction between offset-time (timezone difference from UTC) and given
time for time converting process.

when someone says to person that he or she will contact on this time according to his or her time zone, then it is very difficult to
calculate time for that person who is seating in different time zone. 

This code calculate time according to time-zone using TZinfo database library (which is containing data related to offset of timezone time
form UTC time) and format in date-time for displaying to user.

For output, we have used 24-hour base format for time and mm/dd/yyyy format for date.


**Authorship note:** All of the code described here was written by myself.

# Libraries Used
The code uses four libraries:

```
(require racket/gui/base)
(require tzinfo)
(require tzinfo/source)
(require racket/date)
```

* The ```racket/gui/base``` library provides the ability to make Graphical User Interface.
* The ```tzinfo``` library is used to get all-ids for time-zone and offset-time data for timezones.
* The ```racket/date``` library is used to convert a date (structure) to a string.  

# Key Code Excerpts

Here is a discussion of the most essential procedures, including a description of how they embody ideas from 
UMass Lowell's COMP.3010 Organization of Programming languages course.

Five examples are shown and they are individually numbered. 

## 1. Using Recursion to Accumulate Results

## 2. Filtering a List of File Objects for Only Those of Folder Type

