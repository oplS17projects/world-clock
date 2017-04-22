# world-clock

### Statement
   In this century, the growth of technology is at its another level and the world is working round the clock and coordinating with other countries' time zone to do great team work. So, when someone says that he or she will contact on this time according to his or her time zone, that time it is very difficult to calculate time for other person who is in different time zone. The solution of this inconvenience is “The World-Clock” application. World - clock is an application which is useful to check current time for selected time zone. There is another important functionality of time-convertor which converts future or past time and date in other time zone. For this project, we get to know how many time zones are in the world and what is the time offset of those time zones with UTC time. We have calculated time using offset of selected time zone from UTC. For output, we have used 24-hour base format for time and mm/dd/yyyy format for date.
We are using tree main libraries for this project which are racket/gui, tzinfo and racket/date. The GUI designing and coding for GUI is always fun part and gives valuable experience for front end developing work. During this project, we have learned a lot about these tree libraries, function of racket, GitHub and experienced team work.

### Analysis
We are mostly using functions and techniques which we have learnt in class to bear on the project. 

- #### Data abstraction:
  For checking Time Zone's offset time from UTC time.

- #### Recursion: 
  We will use Recursion techniqe to do match base on 24 hour and 60 minute. This math functions are used to convert time from one time
  zone into another time zone.
  
- #### map/filter/reduce:
  We will use this method to check timezone and its data (offset time from UTC) from list.
  
- #### functional approaches:
 (utc-seconds->tzoffset tzid seconds) returns the offset in second from UTC in effect at that moment of time in the given time zone. We   can use functional approach to convert offset from second to hours, so we can easily add or subtract from UTC.  

- #### state-modification approaches: 
  We may use this method to handle DAY LIGHT TIME SAVING funcionality while giving output to user. 

- #### lazy evaluation approaches:
  We have not dicided yet about this. So if we find something during our project work, then we will mantioned it later on.
 

### External Technologies
Accorsing to documentation on rackey/tzinfo library, UNIX systems usually come with a compiled version of the IANA database (typically in /usr/share/zoneinfo). tzinfo will use the system’s database if available. However, if the tzdata package is installed, that will be used instead. Since Windows systems do not come with a zoneinfo database, Windows users must install tzdata to use tzinfo. So, we had to install tzdata (which is available on GitHub publically) to use tzinfo.

### Data Sets or other Source Materials
We have not used other source materials in project. But we have used time zone data from other website as a research work and for test purpose. 

### Deliverable and Demonstration

With this application, user can see the current time by selecting time zone and also, can convert time from one timezone to another timezone. This application is interactive. 

### Evaluation of Results
We had enough data about timezone offset with UTC time, so we have checked our application output by calculating data by own and have used google time convertor application to compare our output. Fot output of current time, which is easy to compare with online available sources' data.

## Architecture Diagram

![ouput image](/Architecture-diagram.png?raw=true "ouput image")

We need to follow this diagram from top to bottom to complete whole project in time. This diagram is including implimentaion/desing,
evalution and testing parts. 

We have collected enough information about timezones. So now next step is to use those information in our project work. After this
research, vibhuti has started developing graphical user interface using recket/gui library. This gui design is shown below. And prachi has
been exploring racket/tzinfo library. She is writing some basic functions to display current time of different time zones as output. 
 
![output-tab2 image](/world-clock-current-time-tab.png?raw=true "output-tab2 image")

Third step is converting time from one timezone to another. We are writing our own code to calculate time using time difference data.
Math calculation on 60 minute and 24 hour base will be interesting. Thus, we are taking time zone, other time zone (to convert in) and
future/past time detail as input from user and will return time as output.

Forth step is evalution and testing. We will test the whole application and will compare output with expecting result. Testing is the most
important part of the project so we will give enough time and effort for it. So, by the last of week of april, our project will be ready
to present.

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
