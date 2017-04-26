# world-clock

   In this century, the growth of technology is at its another level and the world is working round the clock and coordinating with other countries' time zone to do great team work. So, when someone says that he or she will contact on this time according to his or her time zone, that time it is very difficult to calculate time for other person who is in different time zone. The solution of this inconvenience is “The World-Clock” application. World - clock is an application which is useful to check current time for selected time zone. There is another important functionality of time-convertor which converts future or past time and date in other time zone. For this project, we get to know how many time zones are in the world and what is the time offset of those time zones with UTC time. We have calculated time using offset of selected time zone from UTC. For output, we have used 24-hour base format for time and mm/dd/yyyy format for date. During this project, we have learned a lot about libraries we used, function of racket, GitHub and experienced team work.

### Analysis
We are mostly using functions and techniques which we have learnt in class to bear on the project. 

- Data abstraction: For checking Time Zone's offset time from UTC time.

- Recursion: We will use Recursion techniqe to do match base on 24 hour and 60 minute. This math functions are used to convert time from one time zone into another time zone.
  
- map/filter/reduce: We will use this method to check timezone and its data (offset time from UTC) from list.
  
- functional approaches: (utc-seconds->tzoffset tzid seconds) returns the offset in second from UTC in effect at that moment of time in the given time zone. We can use functional approach to convert offset from second to hours, so we can easily add or subtract from UTC.  

- state-modification approaches: We may use this method to handle DAY LIGHT TIME SAVING funcionality while giving output to user. 

- lazy evaluation approaches: We have not dicided yet about this. So if we find something during our project work, then we will mantioned it later on.
 

### Libraries
Racket Libraries that we used include:
1. racket/gui/base
2. tzinfo
3. racket/date


### External Technologies
Accorsing to documentation on rackey/tzinfo library, UNIX systems usually come with a compiled version of the IANA database (typically in /usr/share/zoneinfo). tzinfo will use the system’s database if available. However, if the tzdata package is installed, that will be used instead. Since Windows systems do not come with a zoneinfo database, Windows users must install tzdata to use tzinfo. So, we had to install tzdata (which is available on GitHub publicly) to use tzinfo.

### Data Sets or other Source Materials
We have not used other source materials in project. But we have used time zone data from other website as a research work and for test purpose. 

### Deliverable and Demonstration
We developed a program which prompt the user to select time zone to see current time. User can also check the time in different time zone by selecting any date and time.  

### Evaluation of Results
Successful implementation is defined as having:
1. Ability to select country and city from the list to see current time. 
2. convert time by selecting date, time and different time zones

## Architecture Diagram

![ouput image](/Architecture_Diagram.png?raw=true "ouput image")

This diagram includes implementation/design, evaluation and testing parts.
We have collected enough information about timezones. So now next step is to use those information in our project work. After this research, Vibhuti has started developing graphical user interface using recket/gui library. This gui design is shown below. And Prachi has been exploring racket/tzinfo library. She is writing some basic functions to display current time for selected time zone.
Then we convert time from one time zone to another. User get output for time in 24-hour base format and date in mm/dd/yyyy format. 
Forth step is evaluation and testing. We have done enough testing and compared output with expected result. 

## Schedule

### First Milestone (Sun Apr 9)
By the first milestone, we have done two parts. First part was user interface and second was time convertor functionality. The plan was to have time zone converter working for different locations with respective time zone. User can also check the current time by selecting country/city from drop down menu.

### Second Milestone (Sun Apr 16)
We evaluated the requirements of the project and then done enough testing for the application. 

### Public Presentation (Wed Apr 26)
we have working “World Clock” application.

## Group Responsibilities

### Prachi Patel @prachiipatel
I worked on the implementation of the application, using two libraries ‘tzinfo’ and ‘racket/date’. The tzinfo library provides an interface for querying the Internet Assigned Numbers Authority time zone database. It is helpful when the selected time zone ID falls into a gap between offset, when daylight saving time starts or ends. So, the user will be able to find the time on different locations with respective time zone. 

### Vibhuti Patel @vibhutipatel18 
I am team leader. I am working on designing and coding part of graphical user interface. Once structure is ready, I will
add events and functionality in GUI. After that, I will be helping to write code for converting time functionality.   
