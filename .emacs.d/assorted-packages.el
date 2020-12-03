;;; -*- lexical-binding: t -*-

(use-package all-the-icons
  :if window-system
  :config
  (when (not (member "all-the-icons" (font-family-list)))
    (all-the-icons-install-fonts t)))

(use-package spacemacs-common
  :if window-system
  :ensure spacemacs-theme
  :config
  (load-theme 'spacemacs-dark t nil))

(use-package bind-key
  :bind (("C-x C-b" . buffer-menu)
         ("M-j"     . (lambda () (interactive) (delete-indentation -1)))
         ("<f5>"    . ispell-buffer)
         ("<f6>"    . ispell-region)
         ("<f8>"    . canonically-space-region)
         ("<f12>"   . (lambda () (interactive) (switch-to-buffer "*scratch*")))
         ))

(use-package ipcalc)
(use-package markdown-mode)

(use-package json-mode
  :pin gnu)

(use-package yaml-mode)

(use-package ansible
  :ensure yaml-mode
  :config
  (add-hook 'yaml-mode-hook #'(lambda () (ansible 1))))

(use-package smartparens
  :ensure yaml-mode
  :config
  (add-hook 'yaml-mode-hook #'smartparens-mode))

(use-package terraform-mode
  :config
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode))

;; (use-package puppet-mode
;;   :config
;;   (add-hook 'puppet-mode-hook
;;             (lambda ()
;;               (add-to-list 'write-file-functions 'delete-trailing-whitespace)
;;               )))

;; (use-package magit
;;   :bind (("C-x m" . magit-status)))
