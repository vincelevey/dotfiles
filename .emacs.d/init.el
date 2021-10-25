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
(setq use-package-always-ensure t)
(setq use-package-verbose t)
(require 'use-package)

(defun load-user-file (file)
  (interactive "f")
  "Load a file in the current user's Emacs configuration directory."
  (load (expand-file-name file user-emacs-directory)))

(load-user-file "assorted-packages")
(load-user-file "buffers")
(load-user-file "date-time")
(load-user-file "emacs-client")
(load-user-file "html")
(load-user-file "my-functions")
(load-user-file "shell")
(load-user-file "text-editing")
(load-user-file "typography")
(load-user-file "tmpfiles")
(load-user-file "when-window-system")
(load-user-file "whitespace")

;; variables not set in custom-file
(setq-default
 default-fill-column 71
 default-major-mode 'text-mode
 frame-title-format '("%b")
 )

(setq
 inhibit-startup-screen t
 initial-major-mode 'text-mode
 initial-scratch-message nil
 ring-bell-function 'ignore
 sentence-end-double-space nil
 )

(defalias 'yes-or-no-p 'y-or-n-p)

;; highlight the current line for selected major modes
(require 'hl-line)
(add-hook 'prog-mode-hook #'hl-line-mode)
(add-hook 'text-mode-hook #'hl-line-mode)

;; selectively turn on line numbers
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(put 'downcase-region  'disabled nil)
(put 'upcase-region    'disabled nil)
(put 'eval-expression  'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; .emacs ends here
