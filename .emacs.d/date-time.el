;; ISO week number in calendar
(setq calendar-week-start-day 1
      calendar-intermonth-text
      '(propertize
        (format "%2d"
                (car
                 (calendar-iso-from-absolute
                  (calendar-absolute-from-gregorian (list month day year)))))
        'font-lock-face 'font-lock-function-name-face))

(defun display-startup-echo-area-message ()
  (message "~/.emacs loaded in %s" (emacs-init-time)))
