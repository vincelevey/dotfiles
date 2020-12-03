;;; -*- lexical-binding: t -*-
(use-package dired
  :ensure nil
  :config
  (progn
    (when (eq system-type 'darwin)
      (setq dired-guess-shell-alist-user
            (list
             (list "\\.pdf\\'"   "open")
             (list "\\.gif\\'"   "open")
             (list "\\.jpe?g\\'" "open")
             (list "\\.png\\'"   "open")
             (list "\\.tiff\\'"  "open")
             ))

      ;; dired use GNU ls
      (let ((gls "/usr/local/opt/coreutils/bin/gls"))
        (if (file-exists-p gls)
            (setq
             insert-directory-program gls
             dired-listing-switches "-alGhv --group-directories-first"
             dired-use-ls-dired t))
        ))
    ))
