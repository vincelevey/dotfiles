;;; -*- lexical-binding: t -*-

(use-package ansible
  :ensure yaml-mode
  :config
  (add-hook 'yaml-mode-hook #'(lambda () (ansible 1))))

(use-package bind-key
  :bind (("C-x C-b" . buffer-menu)
         ("M-j"     . (lambda () (interactive) (delete-indentation -1)))
         ("<f5>"    . ispell-buffer)
         ("<f6>"    . ispell-region)
         ("<f8>"    . canonically-space-region)
         ("<f12>"   . (lambda () (interactive) (switch-to-buffer "*scratch*")))
         ))

(use-package ipcalc)

(use-package json-mode
  :pin gnu)

(use-package magit)

(use-package markdown-mode)

(use-package smartparens
  :ensure yaml-mode
  :config
  (add-hook 'yaml-mode-hook #'smartparens-mode))

(use-package spacemacs-common
  :if window-system
  :ensure spacemacs-theme
  :config
  (load-theme 'spacemacs-dark t nil))

(use-package terraform-mode
  :init
  (defun terraform-mode-hackery ()
    (cond ((zerop (buffer-size))
           (let* ((mod (buffer-modified-p)))
             (insert
              "/**\n"
              "* ## Title: level 2 heading\n"
              "*\n"
              "* Description\n"
              "*/\n")
             (set-buffer-modified-p mod))))
    nil)
  (add-hook 'terraform-mode-hook #'terraform-mode-hackery)
  (add-hook 'terraform-mode-hook #'display-line-numbers-mode)
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode))

(use-package yaml-mode
  :init
  (add-hook 'yaml-mode-hook #'display-line-numbers-mode))
