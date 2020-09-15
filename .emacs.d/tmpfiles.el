(let ((my-temp-directory
       (concat "/tmp/" (user-login-name))))
  (unless (file-directory-p my-temp-directory)
    (make-directory my-temp-directory))
  (set-file-modes my-temp-directory (string-to-number "0700" 8))
  (setq  temporary-file-directory my-temp-directory))
