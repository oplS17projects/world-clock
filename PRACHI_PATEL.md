# World-Clock in Racket

## Prachi Patel
### April 30, 2017

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

## 1. Using "date" Structure

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
```(current-second)``` Returns the current time in seconds since midnight January 1, 1970 for system time zone. 


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
```utc-seconds->tzoffset``` and ```tzoffset-utc-seconds``` procedures are in ```tzinfo``` library. 

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
## 3. Using Iteration to Accumulate Results
```
(define (day/year-list-helper end n lst)
  (if (> n end)
      lst
      (day/year-list-helper end (+ n 1) (append lst (list (number->string n))))))
```
```day/year-list-helper``` procedure takes start, end, convert in to string and returns a list of strings. 

Vibhuti Wrote a procedure called ```day-list-creater``` 
which creates a list of dates for respective month and year. 
(e.g. if its leap year then there are 29 days in February otherwise 28 days)

```
(define (day-list-creater)
  (let ((year (string->number (send time-convertor-from-year-date-field get-value)))
        (mon (send time-convertor-from-month-date-field get-value)))
    (cond ((search-in-list mon '("JAN" "MARCH" "MAY" "JULY" "AUG" "OCT" "DEC")) (day/year-list-helper 31 1 '()))
          ((search-in-list mon '("APRIL" "JUNE" "SEP" "NOV")) (day/year-list-helper 30 1 '()))
          ((and (string=? mon "FEB") (= (remainder year 4) 0)) (day/year-list-helper 29 1 '()))
          (else (day/year-list-helper 28 1 '())))))
```

```day-list-creater``` calls a procedure ```day/year-list-helper``` which takes the last date of the month, 1 (same for all month) and empty list. ```day/year-list-helper``` gives list of strings of all date of the respective month. 

## 4. Creating a list of strings
```
(define (time-zones-offset-con from-timezone-offset to-timezone-offset)
  (let ((from-tz (tzoffset-utc-seconds (utc-seconds->tzoffset from-timezone-offset (current-seconds))))
        (to-tz (tzoffset-utc-seconds (utc-seconds->tzoffset to-timezone-offset (current-seconds)))))
    (if (positive? (+ (abs from-tz) to-tz))
        (add-sec-offset-to-tz (+ (abs from-tz) to-tz))
        (sub-sec-offset-to-tz (+ (abs from-tz) to-tz)))))
```
```time-zones-offset-con``` accepts two arguments, one is ```from-timezone-offset``` (time zone id which used has selected) and second is ```to-time-zone-offset``` (time zone id in which time has to convert to). It will find the get the offsets for both time zones and find the difference between them. Then it will call ```add-sec-offset-to-tz``` or ```sub-sec-offset-to-tz``` based on the result of from-tz(offset of ```from-timezone-offset``` from UTC) 
```
(define (add-sec-offset-to-tz offset-sec)
  (let ((total-sec (+ (string->number (send time-convertor-from-sec-time-field get-value)) offset-sec)))
    (add-min-offset-to-tz (quotient total-sec 60) (list (remainder total-sec 60)) '())))

(define (add-min-offset-to-tz offset-min time-list date-list)
  (let ((total-min (+ (string->number (send time-convertor-from-min-time-field get-value)) offset-min)))
    (add-hour-offset-to-tz (quotient total-min 60) (append time-list (list (remainder total-min 60))) '())))

(define (add-hour-offset-to-tz offset-hour time-list date-list)
  (let ((total-hour (+ (string->number (send time-convertor-from-hour-time-field get-value)) offset-hour)))
    (add-day-offset-to-tz (quotient total-hour 24) (append time-list (list (remainder total-hour 24))) '())))
```

```add-sec-offset-to-tz``` will accept the sum of both time zones, then get the seconds the user has selected to convert and convert that from string to seconds. Add those seconds and ```offset-sec``` then assign that value to ```total-sec```. at last, ```add-min-offset-to-tz``` procedure is call which will have arguments of quotient of total-sec 60 and list of remainders of total-sec and 60. ```add-min-offset-to-tz``` will work same way but the value of (quotient total-sec 60) will be added to total minutes. Same as that ```add-min-offset-to-tz procedure``` will call add-hour-offset-to-tz. 
