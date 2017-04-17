
; project : world clock
; (UML student project for OPL course)
; Team: vibhuti patel (vibhuti_patel1@student.uml.edu)
;       prachi patel  (prachi_patel@student.uml.edu)
; Date: 04-17-2017
; copy rights @ Professor: Fred martin

#lang racket

(require racket/gui/base)
(require tzinfo)
(require tzinfo/source)
(require racket/date)

; Make a frame by instantiating the frame% class
(define main-frame (new frame% [label "World Clock"]
                               [width 464]
                               [height 531]
                               [stretchable-width #t]
                               [stretchable-height #f]))


; Make a static text message in the frame
(define msg-current-time (new message% [parent main-frame]
                          [label "Hello, World!
                You can check current time for all TIME ZONES"]))


;tab on windows
(define tab-panel (new tab-panel%
                       (parent main-frame)
                       (choices (list "CURRENT-TIME-CHECK"
                                      "TIME-CONVERTOR"))
                       (callback
                               (lambda (tp event)
                                (case (send tp get-selection)
                                 ((0) (send tp change-children (lambda (children) (list time-check-panel))))
                                 ((1) (send tp change-children (lambda (children) (list time-convertor-panel))))
                                 )))))


;*********
;*********
; current-time-check tab stuff
(define time-check-panel (new panel% (parent tab-panel)))

(define time-check-panel-top (new vertical-panel% (parent time-check-panel)))
(define time-check-text (new message% (parent time-check-panel-top) (label "\n \n ETC current Time and Date:")))
 
; Racket has a built-in date structure:
; returns current date only for "EST" time-zone


;24 hour clock timing stracture

;  second : (integer-in 0 60)
;  minute : (integer-in 0 59)
;  hour : (integer-in 0 23)
;  day : (integer-in 1 31)
;  month : (integer-in 1 12)
;  year : exact-integer?
;  week-day : (integer-in 0 6)
;  year-day : (integer-in 0 365)


;returns Today date procedure
(define (todays-date)
    (let ((date (seconds->date (current-seconds))))
      (string-append* (list (number->string (date-month date)) " / "
                            (number->string (date-day date)) " / "
                            (number->string (date-year date))))))

;returns Current time procedure
(define (current-time)
      (let ((date (seconds->date (current-seconds))))
        (string-append* (list (number->string (date-hour date)) ":"
                              (number->string (date-minute date)) ":"
                              (number->string (date-second date))))))

 

(define (timezone-name) (string-append "US / " "Boston:    " (todays-date) "  &  " (current-time)))

(define estern-timezone-time-check-text (new message% (parent time-check-panel-top) (label (timezone-name))))

(define current-etc-time-update-button (new button% [parent time-check-panel-top]
             [label "UPDATE"]
             ; Callback procedure for a button click:
             [callback (lambda (button event)
                   (send estern-timezone-time-check-text set-label (timezone-name))
                         (selected-time-zone (send timezones-field get-value)))]))

; botton part for selecting time zone

(define space-time-check-text (new message% (parent time-check-panel-top) (label "\n \n")))
(define selecting-time-check-text (new message% (parent time-check-panel-top) (label "Select Timezone to check current Time and Date: ")))

(define timezones-field (new combo-field%
                         (label "Time-zones")
                         (parent time-check-panel-top)
                         (choices (all-tzids))
                         (callback (lambda (cf event)
                                     (selected-time-zone (send timezones-field get-value))))
                         (init-value "UTC")))
; Selected time zone
(define (selected-time-zone str)
  (current-time-convertor str (tzoffset-utc-seconds (utc-seconds->tzoffset (system-tzid) (current-seconds)))
                              (tzoffset-utc-seconds (utc-seconds->tzoffset str (current-seconds)))))

; (+ (current-seconds) systemid-time-offset) = UTC time
; (+ (current-seconds) systemid-time-offset selected-time-zone-offset)
;             = UTC time + selected time zone = Selected time zone current time
; HERE: condition is checked that timezone time is ahead of UTC time or behind. 
  
(define (current-time-convertor str systemid-time-offset selected-time-zone-offset)
  (if (negative? systemid-time-offset)
      (modify-time-daylightsaving str (seconds->date (+ (current-seconds) (abs systemid-time-offset) selected-time-zone-offset)))
      (modify-time-daylightsaving str (seconds->date (+ (current-seconds) (* -1 systemid-time-offset) selected-time-zone-offset)))))



(define (modify-time-daylightsaving str time)
  (set-coverted-current-time
   (string-append* (list str ":    "
                        (number->string (date-month time)) " / "
                        (number->string (date-day time)) " / "
                        (number->string (date-year time)) "       "
                        (number->string (date-hour time)) ":"
                        (number->string (date-minute time)) ":"
                        (number->string (date-second time))))))

(define space-time-check-text2 (new message% (parent time-check-panel-top) (label "\n")))
;(selected-time-zone "UTC")
(define selected-time-converted-text (new message% (parent time-check-panel-top)
                                          (label "UTC:    4 / 11 / 2017       1:24:8 ")
                                          (auto-resize #t)))

(define (set-coverted-current-time str)
  (send selected-time-converted-text set-label str))




;*********
;*********
; time - covertor tab stuff
(define time-convertor-panel (new panel% (parent tab-panel)))

(define time-convertor-panel-top (new vertical-panel% (parent time-convertor-panel)))
(define time-convertor-text (new message% (parent time-convertor-panel-top) (label "TIME & DATE CONVERTOR-->")))

(define (delete-repeated e)
  (if (null? e) '()
      (cons (car e) (delete-repeated (filter (lambda (x) (not (equal? x (car e)))) 
                                    (cdr e))))))
(define country-time-zones (delete-repeated (map (lambda (x) (car (string-split x "/"))) (all-tzids))))

;;****** FROM FIELD ******
(define time-convertor-instruction1-text (new message% [parent time-convertor-panel-top] [label "\n FROM:"]))
(define timezones-from-field (new combo-field%
                                  (label "COUNTRY-Time-zones")
                                  (parent time-convertor-panel-top)
                                  (choices country-time-zones)
                                  (callback (lambda (cf event)
                                     (set-city-time-zones-choices (send timezones-from-field get-value))))
                                  (init-value "Asia")))

;(define space-time-converter-text1 (new message% (parent time-convertor-panel-top) (label " ")))
(define city-timezones-from-field (new (class combo-field%
                                         (super-new)
                                         (inherit get-menu append)
                                         (define/public (update-choices choice-list)
                                           ; remove all the old items
                                           (map
                                            (lambda (i)
                                              (send i delete))
                                            (send (get-menu) get-items))
                                           ; set up the menu with all new items
                                           (map
                                            (lambda (choice-label)
                                              (append choice-label))
                                            choice-list)
                                           (void)
                                           ))
                                  (label "CITY-country-Time-zones")
                                  (parent time-convertor-panel-top)
                                  (choices '("Kolkata"))
                                  (callback (lambda (cf event)
                                     (void)))
                                  (init-value "Kolkata")))


;(send city-timezones-from-field get-value)
(define (set-city-time-zones-choices str)
  (let ((result (map (lambda (x) (if (null? (cdr (string-split x "/"))) (car (string-split x "/")) (cadr (string-split x "/"))))
                     (filter (lambda (x) (string=? str (car (string-split x "/")))) (all-tzids)))))
    (begin (send city-timezones-from-field set-value (car result))
           (send city-timezones-from-field update-choices result))))


;; take date(MM-DD-YEAR) & time (HH:MM:SS)
(define (day/year-list-helper end n lst)
    (if (> n end)
        lst
        (day/year-list-helper end (+ n 1) (append lst (list (number->string n))))))

; <member> procedure returns list if element exists in list otherwise returns #f
; thats why this kind of logic is used in function below
(define (search-in-list elem lst)
  (not (boolean? (member elem lst))))

(define (day-list-creater)
  (let ((year (string->number (send time-convertor-from-year-date-field get-value)))
        (mon (send time-convertor-from-month-date-field get-value)))
    (cond ((search-in-list mon '("JAN" "MARCH" "MAY" "JULY" "AUG" "OCT" "DEC")) (day/year-list-helper 31 1 '()))
          ((search-in-list mon '("APRIL" "JUNE" "SEP" "NOV")) (day/year-list-helper 30 1 '()))
          ((and (string=? mon "FEB") (= (remainder year 4) 0)) (day/year-list-helper 29 1 '()))
          (else (day/year-list-helper 28 1 '())))))

(define (month-string-to-number str)
  (cond [(string=? str "JAN") 1]
        [(string=? str "FEB") 2]
        [(string=? str "MARCH") 3]
        [(string=? str "APRIL") 4]
        [(string=? str "MAY") 5]
        [(string=? str "JUNE") 6]
        [(string=? str "JULY") 7]
        [(string=? str "AUG") 8]
        [(string=? str "SEP") 9]
        [(string=? str "OCT") 10]
        [(string=? str "NOV") 11]
        [(string=? str "DEC") 12]))

(define (month-number-to-string n-str)
  (cond [(= n-str 1) "JAN"]
        [(= n-str 2) "FEB"]
        [(= n-str 3) "MARCH"]
        [(= n-str 4) "APRIL"]
        [(= n-str 5) "MAY"]
        [(= n-str 6) "JUNE"]
        [(= n-str 7) "JULY"]
        [(= n-str 8) "AUG"]
        [(= n-str 9) "SEP"]
        [(= n-str 10) "OCT"]
        [(= n-str 11) "NOV"]
        [(= n-str 12) "DEC"]))



(define time-convertor-from-date-text (new message% [parent time-convertor-panel-top] [label "\n DATE:"]
                                           [font small-control-font]))
(define time-convertor-date-panel (new horizontal-pane% (parent time-convertor-panel-top)))

; only included 1980-2030 years range
(define time-convertor-from-year-date-field (new combo-field%
                                                  (label "YEAR:")
                                                  (parent time-convertor-date-panel)
                                                  (choices (day/year-list-helper 2030 1980 '()))
                                                  (callback (lambda (cf event)
                                                              (send time-convertor-from-day-date-field update-choices (day-list-creater))))
                                                  (init-value "2017")))

(define time-convertor-from-month-date-field (new combo-field%
                                                  (label "MONTH:")
                                                  (parent time-convertor-date-panel)
                                                  (choices '("JAN" "FEB" "MARCH" "APRIL" "MAY"
                                                                   "JUNE" "JULY" "AUG" "SEP" "OCT"
                                                                   "NOV" "DEC"))
                                                  (callback (lambda (cf event)
                                                              (send time-convertor-from-day-date-field update-choices (day-list-creater))))
                                                  (init-value "JAN")))

(define time-convertor-from-day-date-field (new (class combo-field%
                                                  (super-new)
                                                  (inherit get-menu append)
                                                  (define/public (update-choices choice-list)
                                                    ; remove all the old items
                                                    (map
                                                     (lambda (i)
                                                       (send i delete))
                                                     (send (get-menu) get-items))
                                                    ; set up the menu with all new items
                                                    (map
                                                     (lambda (choice-label)
                                                       (append choice-label))
                                                     choice-list)
                                                    (void)
                                                    ))
                                                (label "DAY:")
                                                (parent time-convertor-date-panel)
                                                (choices (day-list-creater))
                                                (callback (lambda (cf event)
                                                              (void)))
                                                (init-value "1")))


;; TIME: (HH:MM:SS)
(define time-convertor-from-time-text (new message% [parent time-convertor-panel-top] [label "TIME:"]
                                           [font small-control-font]))
(define time-convertor-time-panel (new horizontal-pane% (parent time-convertor-panel-top)))

(define time-convertor-from-hour-time-field (new combo-field%
                                                  (label "HOUR:")
                                                  (parent time-convertor-time-panel)
                                                  (choices (day/year-list-helper 23 0 '()))
                                                  (callback (lambda (cf event)
                                                              (void)))
                                                  (init-value "0")))

(define time-convertor-from-min-time-field (new combo-field%
                                                  (label "MINTUE:")
                                                  (parent time-convertor-time-panel)
                                                  (choices (day/year-list-helper 59 0 '()))
                                                  (callback (lambda (cf event)
                                                              (void)))
                                                  (init-value "0")))

(define time-convertor-from-sec-time-field (new combo-field%
                                                  (label "SECOND:")
                                                  (parent time-convertor-time-panel)
                                                  (choices (day/year-list-helper 59 0 '()))
                                                  (callback (lambda (cf event)
                                                              (void)))
                                                  (init-value "0")))

;;****** TO FIELD ******
(define time-convertor-instruction2-text (new message% [parent time-convertor-panel-top] [label "\n TO:"]))
(define timezones-to-field (new combo-field%
                                  (label "COUNTRY-Time-zones")
                                  (parent time-convertor-panel-top)
                                  (choices country-time-zones)
                                  (callback (lambda (cf event)
                                     (set-city-time-zones-choices-to-field (send timezones-to-field get-value))))
                                  (init-value "America")))

;(define space-time-converter-text1 (new message% (parent time-convertor-panel-top) (label " ")))
(define city-timezones-to-field (new (class combo-field%
                                         (super-new)
                                         (inherit get-menu append)
                                         (define/public (update-choices choice-list)
                                           ; remove all the old items
                                           (map
                                            (lambda (i)
                                              (send i delete))
                                            (send (get-menu) get-items))
                                           ; set up the menu with all new items
                                           (map
                                            (lambda (choice-label)
                                              (append choice-label))
                                            choice-list)
                                           (void)
                                           ))
                                  (label "CITY-country-Time-zones")
                                  (parent time-convertor-panel-top)
                                  (choices '("New_York"))
                                  (callback (lambda (cf event)
                                     (void)))
                                  (init-value "New_York")))

;(send city-timezones-to-field get-value)
(define (set-city-time-zones-choices-to-field str)
  (let ((result (map (lambda (x) (if (null? (cdr (string-split x "/"))) (car (string-split x "/")) (cadr (string-split x "/"))))
                     (filter (lambda (x) (string=? str (car (string-split x "/")))) (all-tzids)))))
    (begin (send city-timezones-to-field set-value (car result))
           (send city-timezones-to-field update-choices result))))

;****************** TO END

; Create a dialog
(define error-dialog (instantiate dialog% ("ERROR!")))
; Add a text field to the dialog
(define error-dialog-text (new message% [parent error-dialog] [label "*** INCORRECT DATE ***"]))
; Add a horizontal panel to the dialog, with centering for buttons
(define error-panel1 (new horizontal-panel% [parent error-dialog]
                                     [alignment '(center center)]))

(define error-dialog-button (new button% [parent error-panel1] [label "Ok"][callback (lambda (button event)
                                                           (send error-dialog show #f))]))

(when (system-position-ok-before-cancel?)
  (send error-panel1 change-children reverse))


; Make a button in the frame
(define time-convertor-bt-text (new message% [parent time-convertor-panel-top] [label "Please press \"Convert\" to convert time:"]))
(define time-convertor-button (new button% [parent time-convertor-panel-top]
             [label "Convert"]
             ; Callback procedure for a button click:
             [callback (lambda (button event)
                   (if (search-in-list (send time-convertor-from-day-date-field get-value)
                                            (day-list-creater))
                       (time-con-timezones)
                       (send error-dialog show #t)))]))

(define (time-con-timezones)
  (time-zones-offset-con (if (string=? (send timezones-from-field get-value) (send city-timezones-from-field get-value))
                             (send timezones-from-field get-value)
                             (string-append (send timezones-from-field get-value) "/" (send city-timezones-from-field get-value)))
                         (if (string=? (send timezones-to-field get-value) (send city-timezones-to-field get-value))
                             (send timezones-to-field get-value)
                             (string-append (send timezones-to-field get-value) "/" (send city-timezones-to-field get-value)))))

;; negative from-tz means from-tz behind of UTC
;; positive   (+ (abs from-tz) to-tz) means from-tz behind to-tz
;; negative   (+ (abs from-tz) to-tz) means from-tz ahead to-tz

;; positive from-tz means from-tz ahead of UTC
;; positive   (+ (* from-tz -1) to-tz) means from-tz behind to-tz
;; negative   (+ (* from-tz -1) to-tz) means from-tz ahead to-tz

(define (time-zones-offset-con from-timezone-offset to-timezone-offset)
  (let ((from-tz (tzoffset-utc-seconds (utc-seconds->tzoffset from-timezone-offset (current-seconds))))
        (to-tz (tzoffset-utc-seconds (utc-seconds->tzoffset to-timezone-offset (current-seconds)))))
    (if (negative? from-tz)
        (if (positive? (+ (abs from-tz) to-tz))
            (add-sec-offset-to-tz (+ (abs from-tz) to-tz))
            (sub-sec-offset-to-tz (+ (abs from-tz) to-tz)))
        (if (positive? (+ (* from-tz -1) to-tz))
            (add-sec-offset-to-tz (+ (* from-tz -1) to-tz))
            (sub-sec-offset-to-tz (+ (* from-tz -1) to-tz))))))

(define (add-sec-offset-to-tz offset-sec)
  (let ((total-sec (+ (string->number (send time-convertor-from-sec-time-field get-value)) offset-sec)))
    (add-min-offset-to-tz (quotient total-sec 60) (list (remainder total-sec 60)) '())))

(define (add-min-offset-to-tz offset-min time-list date-list)
  (let ((total-min (+ (string->number (send time-convertor-from-min-time-field get-value)) offset-min)))
    (add-hour-offset-to-tz (quotient total-min 60) (append time-list (list (remainder total-min 60))) '())))

(define (add-hour-offset-to-tz offset-hour time-list date-list)
  (let ((total-hour (+ (string->number (send time-convertor-from-hour-time-field get-value)) offset-hour)))
    (add-day-offset-to-tz (quotient total-hour 24) (append time-list (list (remainder total-hour 24))) '())))

(define (days-in-mon)
  (let ((year (string->number (send time-convertor-from-year-date-field get-value)))
        (mon (send time-convertor-from-month-date-field get-value)))
    (cond ((search-in-list mon '("JAN" "MARCH" "MAY" "JULY" "AUG" "OCT" "DEC")) 31)
          ((search-in-list mon '("APRIL" "JUNE" "SEP" "NOV")) 30 )
          ((and (string=? mon "FEB") (= (remainder year 4) 0)) 29 )
          (else 28))))
(define (days-in-earlier-mon)
    (let ((year (string->number (send time-convertor-from-year-date-field get-value)))
        (mon (send time-convertor-from-month-date-field get-value)))
    (cond ((search-in-list mon '("JAN" "FEB" "APRIL" "JUNE" "AUG" "SEP" "NOV")) 31)
          ((search-in-list mon '("MAY" "JULY" "OCT" "DEC")) 30 )
          ((and (string=? mon "MARCH") (= (remainder year 4) 0)) 29 )
          (else 28))))

(define (add-day-offset-to-tz offset-day time-list date-list)
  (let ((total-day (+ (string->number (send time-convertor-from-day-date-field get-value)) offset-day))
        (day-mon (days-in-mon)))
    (add-month-offset-to-tz (quotient total-day day-mon) time-list (list (remainder total-day day-mon)))))

(define (add-month-offset-to-tz offset-month time-list date-list)
  (let ((total-month (+ (month-string-to-number (send time-convertor-from-month-date-field get-value)) offset-month)))
    (add-year-offset-to-tz (quotient total-month 12) time-list (append date-list (list (remainder total-month 12))))))

(define (add-year-offset-to-tz offset-year time-list date-list)
  (let ((total-year (+ (string->number (send time-convertor-from-year-date-field get-value)) offset-year)))
    (added-offset-to-tz time-list (append date-list (list total-year)))))

(define (added-offset-to-tz time-list date-list)
  (modify-from-to-time-converted-text (to-time-con-timezones-text)
                                      time-list 
                                      date-list))

;**************substraction*************************

(define (sub-sec-offset-to-tz offset-sec)
  (display "\n in sub sec \n")
  (display  offset-sec)
  (cond [(positive? (+ (string->number (send time-convertor-from-sec-time-field get-value)) offset-sec))
         (let ((total-sec (+ (string->number (send time-convertor-from-sec-time-field get-value)) offset-sec)))
           (sub-min-offset-to-tz (quotient total-sec 60) (list (remainder total-sec 60)) '()))]
        [(= (+ (string->number (send time-convertor-from-sec-time-field get-value)) offset-sec) 0)
         (let ((total-sec (+ (string->number (send time-convertor-from-sec-time-field get-value)) offset-sec)))
           (sub-min-offset-to-tz (* -1 (quotient total-sec 60)) (list (remainder total-sec 60)) '()))]
        [(and (< (+ (string->number (send time-convertor-from-sec-time-field get-value)) offset-sec) 0)
              (= (remainder offset-sec 60) 0))
         (let ((total-sec (+ (string->number (send time-convertor-from-sec-time-field get-value)) (abs offset-sec))))
           (sub-min-offset-to-tz (* -1 (quotient total-sec 60)) (list (remainder total-sec 60)) '()))]
        [(and (< (+ (string->number (send time-convertor-from-sec-time-field get-value)) offset-sec) 0)
              (= (remainder (abs offset-sec) 60) (string->number (send time-convertor-from-sec-time-field get-value))))
         (sub-min-offset-to-tz (* -1 (quotient (abs offset-sec) 60)) (list 0) '())]
        [(and (< (+ (string->number (send time-convertor-from-sec-time-field get-value)) offset-sec) 0)
              (< (remainder (abs offset-sec) 60) (string->number (send time-convertor-from-sec-time-field get-value))))
         (sub-min-offset-to-tz (* -1 (quotient (abs offset-sec) 60))
                               (list (- (string->number (send time-convertor-from-sec-time-field get-value)) (remainder (abs offset-sec) 60)))
                                     '())]
        [(and (< (+ (string->number (send time-convertor-from-sec-time-field get-value)) offset-sec) 0)
              (> (remainder (abs offset-sec) 60) (string->number (send time-convertor-from-sec-time-field get-value))))
         (let ((input-sec (string->number (send time-convertor-from-sec-time-field get-value))))
           (sub-min-offset-to-tz (+ -1 (* -1 (quotient (abs offset-sec) 60)))
                                 (list (- (+ input-sec 60) (remainder (abs offset-sec) 60)) '())))]))


(define (sub-min-offset-to-tz offset-min time-list date-list)
  (display "\n in sub min \n")
  (display  offset-min)
  (cond [(positive? (+ (string->number (send time-convertor-from-min-time-field get-value)) offset-min))
         (let ((total-min (+ (string->number (send time-convertor-from-min-time-field get-value)) offset-min)))
           (sub-hour-offset-to-tz (quotient total-min 60) (append time-list (list (remainder total-min 60))) '()))]
        [(= (+ (string->number (send time-convertor-from-min-time-field get-value)) offset-min) 0)
         (let ((total-min (+ (string->number (send time-convertor-from-min-time-field get-value)) offset-min)))
           (sub-hour-offset-to-tz (* -1 (quotient total-min 60)) (append time-list (list (remainder total-min 60))) '()))]
        [(and (< (+ (string->number (send time-convertor-from-min-time-field get-value)) offset-min) 0)
              (= (remainder offset-min 60) 0))
         (let ((total-min (+ (string->number (send time-convertor-from-min-time-field get-value)) (abs offset-min))))
           (sub-hour-offset-to-tz (* -1 (quotient total-min 60)) (append time-list (list (remainder total-min 60))) '()))]
        [(and (< (+ (string->number (send time-convertor-from-min-time-field get-value)) offset-min) 0)
              (= (remainder (abs offset-min) 60) (string->number (send time-convertor-from-min-time-field get-value))))
         (sub-hour-offset-to-tz (* -1 (quotient (abs offset-min) 60)) (append time-list (list 0)) '())]
        [(and (< (+ (string->number (send time-convertor-from-min-time-field get-value)) offset-min) 0)
              (< (remainder (abs offset-min) 60) (string->number (send time-convertor-from-min-time-field get-value))))
         (sub-hour-offset-to-tz (* -1 (quotient (abs offset-min) 60))
                               (append time-list (list (- (string->number (send time-convertor-from-min-time-field get-value)) (remainder (abs offset-min) 60))))
                                     '())]
        [(and (< (+ (string->number (send time-convertor-from-min-time-field get-value)) offset-min) 0)
              (> (remainder (abs offset-min) 60) (string->number (send time-convertor-from-min-time-field get-value))))
         (let ((input-min (string->number (send time-convertor-from-min-time-field get-value))))
           (sub-hour-offset-to-tz (+ -1 (* -1 (quotient (abs offset-min) 60)))
                                 (append time-list (list (- (+ input-min 60) (remainder (abs offset-min) 60)))) '()))]))

(define (sub-hour-offset-to-tz offset-hour time-list date-list)
  (display "\n in sub hour \n")
  (display  offset-hour)
  (cond [(positive? (+ (string->number (send time-convertor-from-hour-time-field get-value)) offset-hour))
         (let ((total-hour (+ (string->number (send time-convertor-from-hour-time-field get-value)) offset-hour)))
           (sub-day-offset-to-tz (quotient total-hour 24) (append time-list (list (remainder total-hour 24))) '()))]
        [(= (+ (string->number (send time-convertor-from-hour-time-field get-value)) offset-hour) 0)
         (let ((total-hour (+ (string->number (send time-convertor-from-hour-time-field get-value)) offset-hour)))
           (sub-day-offset-to-tz (* -1 (quotient total-hour 24)) (append time-list (list (remainder total-hour 24))) '()))]
        [(and (< (+ (string->number (send time-convertor-from-hour-time-field get-value)) offset-hour) 0)
              (= (remainder offset-hour 24) 0))
         (let ((total-hour (+ (string->number (send time-convertor-from-hour-time-field get-value)) (abs offset-hour))))
           (sub-day-offset-to-tz (* -1 (quotient total-hour 24)) (append time-list (list (remainder total-hour 24))) '()))]
        [(and (< (+ (string->number (send time-convertor-from-hour-time-field get-value)) offset-hour) 0)
              (= (remainder (abs offset-hour) 24) (string->number (send time-convertor-from-hour-time-field get-value))))
         (sub-day-offset-to-tz (* -1 (quotient (abs offset-hour) 24)) (append time-list (list 0)) '())]
        [(and (< (+ (string->number (send time-convertor-from-hour-time-field get-value)) offset-hour) 0)
              (< (remainder (abs offset-hour) 24) (string->number (send time-convertor-from-hour-time-field get-value))))
         (sub-day-offset-to-tz (* -1 (quotient (abs offset-hour) 24))
                               (append time-list (list (- (string->number (send time-convertor-from-hour-time-field get-value)) (remainder (abs offset-hour) 60))))
                                     '())]
        [(and (< (+ (string->number (send time-convertor-from-hour-time-field get-value)) offset-hour) 0)
              (> (remainder (abs offset-hour) 24) (string->number (send time-convertor-from-hour-time-field get-value))))
         (let ((input-hour (string->number (send time-convertor-from-hour-time-field get-value))))
           (sub-day-offset-to-tz (+ -1 (* -1 (quotient (abs offset-hour) 24)))
                                 (append time-list (list (- (+ input-hour 24) (remainder (abs offset-hour) 24)))) '()))]))

(define (sub-day-offset-to-tz offset-day time-list date-list)
  (display "\n in sub day \n")
  (display  offset-day)
  (cond [(positive? (+ (string->number (send time-convertor-from-day-date-field get-value)) offset-day))
         (let ((total-day (+ (string->number (send time-convertor-from-day-date-field get-value)) offset-day))
               (day-mon (days-in-mon)))
           (sub-month-offset-to-tz (quotient total-day day-mon) time-list (list (remainder total-day day-mon))))]
        [(= (+ (string->number (send time-convertor-from-day-date-field get-value)) offset-day) 0)
         (let ((total-day (+ (string->number (send time-convertor-from-day-date-field get-value)) offset-day))
            (day-mon (days-in-earlier-mon)))
           (sub-month-offset-to-tz -1 time-list (list day-mon)))]

        [(> (abs offset-day) (string->number (send time-convertor-from-day-date-field get-value)))
         (let ((input-day (string->number (send time-convertor-from-day-date-field get-value))))
           (sub-month-offset-to-tz -1 time-list (append date-list (list (- (+ input-day (days-in-earlier-mon)) (abs offset-day))))))]))

(define (sub-month-offset-to-tz offset-month time-list date-list)
  (if (positive?  (+ (month-string-to-number (send time-convertor-from-month-date-field get-value)) offset-month))
      (let ((total-month (+ (month-string-to-number (send time-convertor-from-month-date-field get-value)) offset-month)))
        (sub-year-offset-to-tz (quotient total-month 12) time-list (append date-list (list (remainder total-month 12)))))
      (sub-year-offset-to-tz -1 time-list (append date-list (list 12)))))
      
(define (sub-year-offset-to-tz offset-year time-list date-list)
  (let ((total-year (+ (string->number (send time-convertor-from-year-date-field get-value)) offset-year)))
    (substracted-offset-to-tz time-list (append date-list (list total-year)))))

(define (substracted-offset-to-tz time-list date-list)
  (modify-from-to-time-converted-text (to-time-con-timezones-text)
                                      time-list 
                                      date-list))

(define (to-time-con-timezones-text)
  (if (string=? (send timezones-to-field get-value) (send city-timezones-to-field get-value))
                             (send timezones-to-field get-value)
                             (string-append (send timezones-to-field get-value) "/" (send city-timezones-to-field get-value))))

;; time-list format '( ss mm hh)
;; date-list format '( dd mm yyyy)
(define (modify-from-to-time-converted-text str time-list date-list)
  (set-from-to-time-converted-text
   (string-append* (list str ":    "
                         (number->string (cadr date-list)) " / "
                         (number->string (car date-list)) " / "
                         (number->string (caddr date-list)) "       "
                         (number->string (caddr time-list)) ":"
                         (number->string (cadr time-list)) ":"
                         (number->string (car time-list))))))

(define space-time-convertor-to-text (new message% (parent time-convertor-panel-top) (label "Time Zone date(MM-DD-YEAR) & time (HH:MM:SS)")))

(define from-to-time-converted-text (new message% (parent time-convertor-panel-top)
                                          (label " ")
                                          (auto-resize #t)))

(define (set-from-to-time-converted-text str)
  (send from-to-time-converted-text set-label str))







;*******************************************************************

; Returns a list containing all of the time zone IDs in the database.
;(all-tzids)

; Show the frame by calling its show method
; before opening window, we keep primary tab open
(send tab-panel change-children (lambda (children) (list time-check-panel)))
; UTC time will be shown
(selected-time-zone "UTC")
(send main-frame show #t)

;*******************************************************************

