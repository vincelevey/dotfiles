;; hunspell
(let ((hunspell "/usr/local/bin/hunspell"))
  (if (file-exists-p hunspell)
      (progn
        (setq-default ispell-program-name hunspell)
        (setq ispell-local-dictionary-alist nil)
        (add-to-list 'ispell-local-dictionary-alist
                     '("en_GB" "[A-Za-z]" "[^A-Za-z]" "[']" nil ("-d" "en_GB") nil utf-8))
        (setq ispell-dictionary "en_GB")
        )))
