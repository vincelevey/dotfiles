;;; -*- lexical-binding: t -*-

(when (display-graphic-p)
  (unbind-key "C-x C-c")
  (unbind-key "C-x C-d")
  (unbind-key "C-x C-z")
  (unbind-key "M-o")

  (when (eq system-type 'darwin)
    ;; set transparency
    ;(set-frame-parameter (selected-frame) 'alpha '(95 95))
    ;(add-to-list 'default-frame-alist '(alpha 95 95))
    
    (when (fboundp 'ns-do-hide-emacs)
      (global-set-key (kbd "M-h") 'ns-do-hide-emacs))

    (global-set-key (kbd "M-RET") 'toggle-frame-fullscreen)
    (global-set-key [mouse-2] 'mouse-yank-at-click)

    ;; use Spotlight under macOS instead of locate
    (defun locate-use-mdfind-name (search-string)
      (list "mdfind" "-name" (shell-quote-argument search-string)))

    (setq
     delete-by-moving-to-trash t
     locate-make-command-line 'locate-use-mdfind-name
     mac-command-modifier 'meta
     mac-option-modifier 'super
     mac-right-command-modifier nil
     mac-right-option-modifier nil
     mouse-drag-copy-region t
     select-active-regions 'only
     ))

  (when (eq system-type 'gnu/linux)
    (global-unset-key [M-mouse-1])
    (global-unset-key [M-mouse-2])
    (global-unset-key [M-mouse-3])
    (global-unset-key [M-down-mouse-1])
    (global-unset-key [M-drag-mouse-1])

    (defun clear-secondary-selection ()
      "Clear those annoying secondary selections."
      (interactive)
      (delete-overlay mouse-secondary-overlay)
      ))

  (when (eq system-type 'windows-nt)
    (setq select-active-regions nil)
    (setq mouse-drag-copy-region t)
    (global-set-key [mouse-2] 'mouse-yank-at-click)
    ))
