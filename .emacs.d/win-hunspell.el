;;; -*- lexical-binding: t -*-

;; hunspell under Windows

(let ((hunspell "C:\\Users\\vince.levey\\somepath\\hunspell.exe"))
  (if (file-exists-p hunspell)
      (with-eval-after-load "ispell"
        (setenv "DICTPATH" "C:\\Users\\vince.levey\\somepath\\share\\hunspell")
        (setq-default ispell-program-name hunspell)
        (setq ispell-hunspell-add-multi-dic "en_GB")
        (setq ispell-dictionary "en_GB"))
    ))
