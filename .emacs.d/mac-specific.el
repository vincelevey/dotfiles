;;; -*- lexical-binding: t -*-

(when (and (eq system-type 'darwin)
           (window-system))
  (when (fboundp 'ns-do-hide-emacs)
    (global-set-key (kbd "M-h") 'ns-do-hide-emacs))

  (global-set-key (kbd "M-RET") 'toggle-frame-fullscreen)

  (setq
   delete-by-moving-to-trash t
   mac-command-modifier 'meta
   mac-option-modifier 'super
   mac-right-command-modifier nil
   mac-right-option-modifier nil
   )

  (use-package keychain-environment
    :config
    (keychain-refresh-environment))

  ;; use Spotlight under macOS instead of locate
  (defun locate-use-mdfind-name (search-string)
    (list "mdfind" "-name" (shell-quote-argument search-string)))
  (setq locate-make-command-line 'locate-use-mdfind-name))
