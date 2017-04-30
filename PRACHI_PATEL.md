# World-Clock in Racket

## Prachi Patel
### April 29, 2017

# Overview
This set of codes provides an interface to check current time for selected time zone. 
There is another important functionality of time-convertor which converts future or past time and date in other time zone. 
Format of the output is military time for time and mm/dd/yyyy for date. 

when someone says that he or she will contact on this time according to his or her time zone, 
that time it is confusing to calculate time for other person who is in different time zone. 
The solution of this inconvenience is “The World-Clock” application.


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
* The ```tzinfo``` library is used to get all time zone ids and offset-time data for time zones ids.
* The ```racket/date``` library is used to convert a date (structure) to a string.


# Key Code Excerpts

Here is a discussion of the most essential procedures, including a description of how they embody ideas from 
UMass Lowell's COMP.3010 Organization of Programming languages course.

Five examples are shown and they are individually numbered. 

## 1. 

```
(define (todays-date)
  (let ((date (seconds->date (current-seconds))))
    (string-append* (list (number->string (date-month date)) " / "
                          (number->string (date-day date)) " / "
                          (number->string (date-year date))))))

(define (current-time)
  (let ((date (seconds->date (current-seconds))))
    (string-append* (list (number->string (date-hour date)) ":"
                          (number->string (date-minute date)) ":"
                          (number->string (date-second date))))))
```
This set of codes gives current date and time. 
```seconds->date``` takes ```(current-second)``` its argument and returns an instance of the date* structure type which is already built in racket. 
The resulting date* reflects the time according to time zone.  
```number->string``` converts the argument to string. 

Same pattern is used to get date and time for selected time zone id.

```
(define (modify-time-daylightsaving str time)
  (set-coverted-current-time
   (string-append* (list str ":    "
                         (number->string (date-month time)) " / "
                         (number->string (date-day time)) " / "
                         (number->string (date-year time)) "       "
                         (number->string (date-hour time)) ":"
                         (number->string (date-minute time)) ":"
                         (number->string (date-second time))))))
 ```
 modify-time-daylightsaving takes timezone-id and current time for that time zone and returns date and time for that time zone id. 
 
## 2. Selectors and Predicates using Procedural Abstraction
```
(define (selected-time-zone str)
  (current-time-convertor str (tzoffset-utc-seconds (utc-seconds->tzoffset (system-tzid) (current-seconds)))
                          (tzoffset-utc-seconds (utc-seconds->tzoffset str (current-seconds)))))
```
```selected-time-zone``` procedure takes timezone as argument and call ```current-time-convertor``` which accepts timezone-id and offset of timezone-id from UTC in seconds. 
These procedure is helpful when the selected time zone ID falls into a gap between offset, when daylight saving time starts or ends. 
There is also a procedure called ```utc-seconds->tzoffset``` which returns a structure describing the off-set from UTC. 

If one select ```"America/New_York"``` from timezone-ids the it gives a structure of containing the offset and time zone “EDT” that means the daylight-saving time is in effect.

``` 
>(utc-seconds->tzoffset "America/New_York" (current-seconds))
(tzoffset -14400 #t "EDT")
```
```tzoffset-utc-seconds``` procedure gets the offset from the structure. 

```
(define (current-time-convertor str systemid-time-offset selected-time-zone-offset)
  (if (negative? systemid-time-offset)
      (modify-time-daylightsaving str (seconds->date (+ (current-seconds) (abs systemid-time-offset) selected-time-zone-offset)))
      (modify-time-daylightsaving str (seconds->date (+ (current-seconds) (* -1 systemid-time-offset) selected-time-zone-offset)))))
```

current-time-convertor accepts timezone-id offset of system-id and offset of that id, then checks if the system-id offset is negative or positive. If the system-id offset is negative then it is behind the UTC, means we need to add (current-seconds) to get UTC time and then add the offset of selected time zone.

in short,
```
; (+ (current-seconds) systemid-time-offset) = UTC time
; (+ (current-seconds) systemid-time-offset selected-time-zone-offset = current time for UTC + selected time zone = current time in selected time zone id
```

