;;; Vince Levey's Emacs init file.
;;;
(setq custom-file (expand-file-name "~/.emacs.d/custom.el"))
(load custom-file 'noerror)

(require 'cl-lib)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/custom-packages/"))

;; package setup
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; pin packages to certain archives
(setq package-pinned-packages
      '((json-mode . "gnu")
        ))

;; install use-package if necessary
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; enable use-package
(setq use-package-verbose t)
(require 'use-package)

(defun load-user-file (file)
  (interactive "f")
  "Load a file in the current user's Emacs configuration directory."
  (load (expand-file-name file user-emacs-directory)))

(load-user-file "assorted-packages")
(load-user-file "buffers")
(load-user-file "date-time")
(load-user-file "dired")
(load-user-file "emacs-client")
(load-user-file "html")
(load-user-file "mac-specific")
(load-user-file "my-functions")
(load-user-file "shell")
(load-user-file "text-editing")
(load-user-file "typography")
(load-user-file "tmpfiles")
(load-user-file "when-window-system")
(load-user-file "whitespace")

;; puppet erb minor mode
;(load "~/.emacs.d/custom-packages/eruby-mode")

;; variables not set in custom-file
(setq-default
 default-fill-column 71
 default-major-mode 'text-mode
 frame-title-format '("%b"))

(defalias 'yes-or-no-p 'y-or-n-p)

;; highlight the current line
(global-hl-line-mode +1)

(put 'downcase-region  'disabled nil)
(put 'upcase-region    'disabled nil)
(put 'eval-expression  'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; .emacs ends here
