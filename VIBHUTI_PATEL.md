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

Four examples are shown and they are individually numbered. 

## 1. Using Recursion to Accumulate Results

```
(define (delete-repeated e)
  (if (null? e) '()
      (cons (car e) (delete-repeated (filter (lambda (x) (not (equal? x (car e)))) 
                                    (cdr e))))))
```
Above coded function is used to delete the repeated value in the list and to return the list with all uniqe values.
```
(filter (lambda (x) (not (equal? x (car e)))) (cdr e))
```
This filter procedure is filter the ```x``` (which is added in the list earlier ```cons (car e)```) from rest of the list (```(cdr e)```).
then ```(car e)``` where ```e``` is returned from ```filter``` procedure, is added in the list and ```(delete-repeated e)``` function is
called again. 

Ultimately, when there are no more elements to be had, the routine terminates and returns the null-list. 

This generates a recursive process from the recursive definition.
## 2. Modify the elements in the list using Map

```
(define country-time-zones (delete-repeated (map (lambda (x) (car (string-split x "/"))) (all-tzids))))
```
Here, I am doing ```(car (string-split x "/")))``` procedure on ```x``` element of list ```(all-tzids)``` (containg all timezones id over
the world), And then mapping the list and return the list. After that, calling the procedure ```delete-repeated``` to delete the repeated 
values from the list.

```all-tzids``` returns the list like as example: 
```
'("Africa/Abidjan"
    "Africa/Accra"
    "Africa/Addis_Ababa"
    "Africa/Algiers"
    "US/Mountain"
    "US/Pacific"
    "US/Pacific-New"
    "US/Samoa"
    "Africa/Bangui"
    "Africa/Banjul")
```    
so,

(string-split x "/") returns ```'("Africa" "Abidjan")```

(car (string-split x "/")) returns ```"Africa"```

This function is used for seprating countries name from (all-tzids) list and creating list of those countries for user selections.

## 3. Filtering a List of cities Objects for Only Those which are in the country

```
(define (set-city-time-zones-choices str)
  (let ((result (map (lambda (x) (if (null? (cdr (string-split x "/"))) (car (string-split x "/")) (cadr (string-split x "/"))))
                     (filter (lambda (x) (string=? str (car (string-split x "/")))) (all-tzids)))))
    (begin (send city-timezones-from-field set-value (car result))
           (send city-timezones-from-field update-choices result))))
```           

Here, ```str``` is the country name which is selected by user. 

```
(filter (lambda (x) (string=? str (car (string-split x "/")))) (all-tzids))
```

Using filter function procedure, I am filtering the cities which have country name ```str```  

```
(lambda (x) (string=? str (car (string-split x "/"))))
```
This procedure is for comparing strings. In this process, I am comparing country name - strings.

## 4. Selectors and Predicates using Procedural Abstraction

```

; <member> procedure returns list if element exists in list otherwise returns #f
; thats why this kind of logic is used in function below
(define (search-in-list elem lst)
  (not (boolean? (member elem lst))))


; checking days in months
(define (day-list-creater)
  (let ((year (string->number (send time-convertor-from-year-date-field get-value)))
        (mon (send time-convertor-from-month-date-field get-value)))
    (cond ((search-in-list mon '("JAN" "MARCH" "MAY" "JULY" "AUG" "OCT" "DEC")) (day/year-list-helper 31 1 '()))
          ((search-in-list mon '("APRIL" "JUNE" "SEP" "NOV")) (day/year-list-helper 30 1 '()))
          ((and (string=? mon "FEB") (= (remainder year 4) 0)) (day/year-list-helper 29 1 '()))
          (else (day/year-list-helper 28 1 '())))))
```

Here, function is to create the list of dates which depends on month and year (could be leap year). 
```search-in-list``` procedure is used to check that element is existing in list or not.

```
(define (search-in-list elem lst)
  (not (boolean? (member elem lst))))
```

In this function, ```(member)``` procedure is used. "member" procedure returns list if element exists in list otherwise returns #f.

Now There are two cases for return value data-type of "member" function:

  Case 1: returns #f if not exists

  here, #f is boolean data-type. So ```(boolean? (member elem lst))``` returns #t. ```(not #t)``` returns #f. That means element does not
exist in the list.

  Case 2: returns list of elements if exists

  In this case, list is not boolean data-type. So ```(boolean? (member elem lst))``` returns #f. ```(not #f)``` returns #t. That means 
element does exist in the list.

## Racket-GUI library
I got to explore GUI library in racket. 
The windowing toolbox provides the basic building blocks of GUI programs, including frames (top-level windows), modal dialogs, menus,
buttons, check boxes, text fields, and radio buttons—all as classes.
I read document on racket/gui library and created one by one elements for user interface of World-Clock app.


*this document is written using professor Fred Martin's referenced file.
          
