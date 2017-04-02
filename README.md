# world-clock

### Statement
   In this cetury, The growth of technology is at its another level. And for this growth, whole world is working round the clock and
coordinating with other countries' time zone to do great team work. So when some one says that he or she will call on this time according
to his or her timezone, that time it is very difficult to calculate time for other person who is in different timezone. The solution of
this inconvenience is world-clock application. World - clock is actually an application which is usefull to check current time of any
timezone in the world. There is another important functionality of time - convertor which is usefull to convert future or past time and
date in other timezone. For this project, we get to know how many timezones are in the world and what is the time offset of those
timezones with UTC time. To calculate time using offset of timezone which is challenging to do math using 24 hoursbase. Also We are using
two main libraries for this project which are racket/gui and racket/tzinfo. The GUI designing and coding for GUI is always fun part and
gives valuable exprience for front end devloping work. During this project, we will learn more about github use, will explore some usefull
libraries and functions of racket (scheme) and have team work exprience.   

### Analysis
We are mostly using functions and techniques which we have learnt in class to bear on the project. 
Explain what approaches from class you will bring to bear on the project.

Been explicit about the techiques from the class that we will use. For example:

- Data abstraction:
  For checking Time Zone's offset time from UTC time.

- Recursion: 
  We will use Recursion techniqe to do match base on 24 hour and 60 minute. This math functions are used to convert time from one time
  zone into another time zone.
  
- map/filter/reduce:
  We will use this method to check timezone and its data (offset time from UTC) from list.
  
- object-orientation? How?

- functional approaches:
  Usally, calcute time difference is easy once we have timezone data. But it is difficult to calculate data from offset data of timezone.
  So for that we may use this approach to calculate date.

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
Explain exactly what you'll have at the end. What will it be able to do at the live demo?

What exactly will you produce at the end of the project? A piece of software, yes, but what will it do? Here are some questions to think about (and answer depending on your application).

Will it run on some data, like batch mode? Will you present some analytical results of the processing? How can it be re-run on different source data?

Will it be interactive? Can you show it working? This project involves a live demo, so interactivity is good.

### Evaluation of Results
How will you know if you are successful? 
If you include some kind of _quantitative analysis,_ that would be good.

## Architecture Diagram
Upload the architecture diagram you made for your slide presentation to your repository, and include it in-line here.

Create several paragraphs of narrative to explain the pieces and how they interoperate.

## Schedule
Explain how you will go from proposal to finished product. 

There are three deliverable milestones to explicitly define, below.

The nature of deliverables depend on your project, but may include things like processed data ready for import, core algorithms implemented, interface design prototyped, etc. 

You will be expected to turn in code, documentation, and data (as appropriate) at each of these stages.

Write concrete steps for your schedule to move from concept to working system. 

### First Milestone (Sun Apr 9)
Which portion of the work will be completed (and committed to Github) by this day? 

### Second Milestone (Sun Apr 16)
Which portion of the work will be completed (and committed to Github) by this day?  

### Public Presentation (Mon Apr 24, Wed Apr 26, or Fri Apr 28 [your date to be determined later])
What additionally will be completed before the public presentation?

## Group Responsibilities

### Prachi Patel @prachiipatel
will work on...

### Vibhuti Patel @vibhutipatel18 
Vibhuti is team lead. Vibhuti is working on designing and coding part of graphical user interface. Once structure is ready, vibhuti will
add events and functionality in GUI. After that, vibhuti will be helping to write code for converting time functionality.   
