;;; -*- lexical-binding: t -*-
(setenv "PAGER" "cat")

;;(eshell-git-prompt-use-theme 'robbyrussell)

;; (setq eshell-prompt-regexp "^[^#%\n]*[#%] "
;;       eshell-prompt-function
;;       (lambda nil
;;         (concat
;;          "[" (user-login-name) "@" (system-name) ":"
;;          (if (string= (eshell/pwd) (getenv "HOME"))
;;              "~" (eshell/basename (eshell/pwd)))
;;          "]"
;;          (if (= (user-uid) 0) "# " "% ")
;;          )))

;;; like the default, but with "%" instead of "$"
;; (setq eshell-prompt-regexp "^[^#%\n]*[#%] "
;;       eshell-prompt-function
;;       (lambda nil
;;         (concat
;;          (if (string= (eshell/pwd) (getenv "HOME"))
;;              "~" (eshell/basename (eshell/pwd)))
;;          (if (= (user-uid) 0) " # " " % ")
;;          )))
        
(use-package eshell
  :init
  (add-hook 'eshell-mode-hook
            (lambda ()
              (add-to-list 'eshell-visual-commands "ssh")
              (add-to-list 'eshell-visual-commands "tail")
              (add-to-list 'eshell-visual-commands "top")
              (add-to-list 'eshell-visual-commands "bash")
              (add-to-list 'eshell-visual-commands "zsh")
              (eshell/alias "cal" "ncal -w")
              (eshell/alias "cls" "clear t")
              (eshell/alias "d" "dired $1")
              (eshell/alias "e" "find-file $1")
              (eshell/alias "h" "history")
              (eshell/alias "ll" "ls -l $*")

              (let ((df (if (file-exists-p "/usr/local/bin/gdf")
                            "/usr/local/bin/gdf"
                          "/bin/df")))
                (eshell/alias "df" (concat df " $*")))
              )
            ))

(when window-system
  (eshell))
