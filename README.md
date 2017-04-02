# world-clock

### Statement
   In this cetury, The growth of technology is at its another level. And for this growth, whole world is working round the clock and
coordinating with other countries' time zone to do great team work. So when some one says that he or she will call on this time according to his or her timezone, that time it is very difficult to calculate time for other person who is in different timezone. The solution of this inconvenience is world-clock application. World - clock is actually an application which is usefull to check current time of any
timezone in the world. There is another important functionality of time - convertor which is usefull to convert future or past time and
date in other timezone. For this project, we get to know how many timezones are in the world and what is the time offset of those
timezones with UTC time. To calculate time using offset of timezone which is challenging to do math using 24 hoursbase. Also We are using two main libraries for this project which are racket/gui and tzinfo. The GUI designing and coding for GUI is always fun part and
gives valuable exprience for front end devloping work. During this project, we will learn more about github use, will explore some usefull libraries and functions of racket (scheme) and have team work exprience.   

### Analysis
We are mostly using functions and techniques which we have learnt in class to bear on the project. 

- Data abstraction:
  For checking Time Zone's offset time from UTC time.

- Recursion: 
  We will use Recursion techniqe to do match base on 24 hour and 60 minute. This math functions are used to convert time from one time
  zone into another time zone.
  
- map/filter/reduce:
  We will use this method to check timezone and its data (offset time from UTC) from list.
  
- object-orientation? How?

- functional approaches:
 (utc-seconds->tzoffset tzid seconds) returns the offset in second from UTC in effect at that moment of time in the given time zone. We   can use functional approach to convert offset from second to hours, so we can easily add or subtract from UTC.  

- state-modification approaches: 
  We may use this method to handle DAY LIGHT TIME SAVING funcionality while giving output to user. 

- lazy evaluation approaches:
  We have not dicided yet about this. So if we find something during our project work, then we will mantioned it later on.
 

### External Technologies
Accorsing to documentation on rackey/tzinfo library, UNIX systems usually come with a compiled version of the IANA database (typically in
/usr/share/zoneinfo). tzinfo will use the system’s database if available. However, if the tzdata package is installed, that will be used
instead. Since Windows systems do not come with a zoneinfo database, Windows users must install tzdata to use tzinfo. So, we had to
install tzdata (which is available on GitHub publically) to use tzinfo. 

### Data Sets or other Source Materials
We are not using other source materials in project. But we are using timezone data from other website as a research work.

### Deliverable and Demonstration

### Evaluation of Results
We will do enough testing so if we find any bug during testing then we will debug it and solve it. We have enough data about timezone
offset with UTC time, so we will check our application output with our own calculation. Also we will use google time convertor application
to compare our output. And for output of current time, which is easy to compare with online available sources' data.

## Architecture Diagram
Upload the architecture diagram you made for your slide presentation to your repository, and include it in-line here.

Create several paragraphs of narrative to explain the pieces and how they interoperate.

## Schedule

### First Milestone (Sun Apr 9)
By the first milestone, There are two parts to be done. First part is user interface and second part is time convertor functionality.
The plan is to have time zone converter working for different locations with respective time zone. And also user can check the current
time by selecting time zone from drop down menu. 

### Second Milestone (Sun Apr 16)
We will evalute the requirment of the project first. And after that we will do enough testing for this application so we could not find
any bug while giving presentation publically. Thus, by the second milestone, we hope to our application working with expected output. 

### Public Presentation (Mon Apr 24, Wed Apr 26, or Fri Apr 28 [your date to be determined later])
For the public presentation, we will have a working World Clock application.

## Group Responsibilities

### Prachi Patel @prachiipatel
I will work on implementation of world clock. I will use two libraries tzinfo and racket/date. The tzinfo library provides an interface for querying the Internet Assigned Numbers Authority time zone database. It is helpful when the selected time zone ID falls into a gap between offset, when daylight saving time starts or ends. So, the user will be able to find the time on different locations with respective time zone. Once I get offset with UTC, it will be easy to get time and date for selected time zone. 

### Vibhuti Patel @vibhutipatel18 
I am team leader. I am working on designing and coding part of graphical user interface. Once structure is ready, I will
add events and functionality in GUI. After that, I will be helping to write code for converting time functionality.   
