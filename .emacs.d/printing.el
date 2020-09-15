(defconst PRINTER_NAME "SecurePrint_RPS1"
  "Printer to use within Emacs")

(defconst MY_PRINTER (concat "//" "EXXCMPCANRPS1.cmpd1.metoffice.gov.uk"
                             "/" PRINTER_NAME)
  "UNC location of printer")

(setq-default
 printer-name MY_PRINTER
 ps-printer-name MY_PRINTER
 ps-right-header (quote ("/pagenumberstring load"
                         ps-time-stamp-iso8601
                         ps-time-stamp-hh:mm:ss))
 )
