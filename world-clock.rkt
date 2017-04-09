#lang racket

(require racket/gui/base)
(require tzinfo)
(require racket/date)

; Make a frame by instantiating the frame% class
(define main-frame (new frame% [label "World Clock"]
                               [width 300]
                               [height 400]))


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



; current-time-check tab stuff
(define time-check-panel (new panel% (parent tab-panel)))

(define time-check-panel-top (new vertical-panel% (parent time-check-panel)))
(define time-check-text (new message% (parent time-check-panel-top) (label "ETC current Time and Date:")))

(define timezone-name (string-append "US/" "New York"))
(define selected-timezone-time-check-text (new message% (parent time-check-panel-top) (label timezone-name)))




;*********
; time - covertor tab stuff
(define time-convertor-panel (new panel% (parent tab-panel)))

(define time-convertor-panel-top (new vertical-panel% (parent time-convertor-panel)))
(define time-convertor-text (new message% (parent time-convertor-panel-top) (label "TIME & DATE CONVERTOR:")))
; Make a button in the frame
(define time-convertor-bt-text (new message% [parent time-convertor-panel-top] [label "hi world"]))
(define time-convertor-button (new button% [parent time-convertor-panel-top]
             [label "OK"]
             ; Callback procedure for a button click:
             [callback (lambda (button event)
                   (send time-convertor-bt-text set-label ""))]))



; Show the frame by calling its show method
; before opening window, we keep primary tab open
(send tab-panel change-children (lambda (children) (list time-check-panel)))4
(send main-frame show #t)








; Create a dialog
(define dialog (instantiate dialog% ("Example")))
 
; Add a text field to the dialog
(new text-field% [parent dialog] [label "Your name"])
 
; Add a horizontal panel to the dialog, with centering for buttons
(define panel1 (new horizontal-panel% [parent dialog]
                                     [alignment '(center center)]))
 
; Add Cancel and Ok buttons to the horizontal panel
(new button% [parent panel1] [label "Cancel"])
(new button% [parent panel1] [label "Ok"])
(when (system-position-ok-before-cancel?)
  (send panel1 change-children reverse))
 
; Show the dialog
(send dialog show #f)


;*******************************************************************

; Returns a list containing all of the time zone IDs in the database.
;(all-tzids)

; this only retursn 
;Racket has a built-in date structure:
;returns current date only for "EST" time-zone

(define todays-date
    (let ((date (seconds->date (current-seconds))))
      (display (list (date-month date) '/
                     (date-day date) '/
                     (date-year date)))))

;returns current time 
(define current-time
      (let ((date (seconds->date (current-seconds))))
        (display (list (date-hour date) ':
                       (date-minute date) ':
                       (date-second date)))))




