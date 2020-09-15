;;; -*- lexical-binding: t -*-
(when window-system
  (global-set-key (kbd "C-x C-c") nil)
  (global-set-key (kbd "C-x C-z") nil)

  ;; set transparency
  (set-frame-parameter (selected-frame) 'alpha '(95 95))
  (add-to-list 'default-frame-alist '(alpha 95 95))

  (when (eq window-system 'x)
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
    )
  )
