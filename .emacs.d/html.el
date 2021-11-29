;;; -*- lexical-binding: t -*-

(unless (featurep 'xemacs)
  (defun set-keymap-name (map name)
    "Used in XEmacs to set the name of the keymap (for debugging
purposes only)."
    (declare (obsolete "never ported over from XEmacs" "19.28"))
    ))

(require 'jwz-html-mode)

(add-hook 'jwz-html-mode-hook
          (lambda ()
            (make-local-variable 'font-lock-defaults)
            (setq font-lock-defaults '(jwz-html-font-lock-keywords t))
            ))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . jwz-html-mode))
(add-to-list 'auto-mode-alist '("\\.xml\\'"   . jwz-html-mode))
