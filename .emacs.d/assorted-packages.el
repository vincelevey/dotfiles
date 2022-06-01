;;; -*- lexical-binding: t -*-

(use-package all-the-icons
  :when (display-graphic-p)
  :config
  (when (not (member "all-the-icons" (font-family-list)))
    (all-the-icons-install-fonts t)))

(use-package bind-key
  :bind (("C-x C-b" . ibuffer)
         ("M-j"     . (lambda () (interactive) (delete-indentation -1)))
         ([f1]      . undo)
         ([f12]     . (lambda () (interactive) (switch-to-buffer "*scratch*")))
         ([f13]     . mac-toggle-tab-group-overview)
         ))

(use-package csharp-mode
  :defer t
  :init
  (add-hook 'csharp-mode-hook
            (lambda ()
              (setq c-basic-offset 2)
              (electric-pair-local-mode 1)
              )
            ))

(use-package deadgrep
  :after (project)
  :bind (("C-x g" . #'deadgrep)))

(use-package diminish)

(use-package dired
  :ensure nil
  :config
  (progn
    (when (> emacs-major-version 25)
      (define-key dired-mode-map [mouse-2] #'dired-mouse-find-file))
    
    (when (eq system-type 'darwin)
      (setq dired-guess-shell-alist-user
            (list
             (list "\\.pdf\\'"   "open")
             (list "\\.gif\\'"   "open")
             (list "\\.jpe?g\\'" "open")
             (list "\\.png\\'"   "open")
             (list "\\.tiff\\'"  "open")
             ))

      ;; dired use GNU ls
      (let ((gls "/usr/local/opt/coreutils/bin/gls"))
        (if (file-exists-p gls)
            (setq
             insert-directory-program gls
             dired-listing-switches "-alGhv --group-directories-first"
             dired-use-ls-dired t))
        ))
    ))

(use-package dockerfile-mode
  :mode "Dockerfile\\'")

(use-package doom-modeline
  :requires all-the-icons
  :when (display-graphic-p)
  :config (doom-modeline-mode))

(use-package git-timemachine)

(use-package go-mode
  :init
  (add-hook 'go-mode-hook
            (lambda ()
              (add-hook 'before-save-hook 'gofmt-before-save)
              (setq tab-width 2)
              )
            ))

(use-package highlight-indent-guides
  :when (display-graphic-p)
  :commands (highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-method 'character)
  (highlight-indent-guides-responsive 'top))

(use-package ipcalc)

(use-package ispell
  :init
  (setq ispell-program-name "/usr/local/bin/hunspell")
  :config
  (setq ispell-hunspell-add-multi-dic "en_GB")
  (setq ispell-dictionary "en_GB"))

(use-package json-mode
  :pin gnu)

(use-package keychain-environment
  :when (string-equal system-type "darwin")
  :config
  (keychain-refresh-environment))

(use-package magit
  :bind (("C-x m"   . magit-status)
         ("C-x C-m" . magit-status)
         ))

(use-package markdown-mode)

(use-package material-theme
  :ensure t
  :config
  (load-theme 'material t))

;; required for deadgrep
(use-package project)

(use-package smartparens
  :ensure yaml-mode
  :hook (yaml-mode . smartparens-mode))

(use-package terraform-mode
  :init
  (defun terraform-mode-hackery ()
    (cond ((zerop (buffer-size))
           (let* ((mod (buffer-modified-p)))
             (insert
              "/**\n"
              "* # Title: level 1 heading\n"
              "*\n"
              "* Description\n"
              "*/\n")
             (set-buffer-modified-p mod))))
    nil)
  :hook ((terraform-mode . terraform-mode-hackery)
         (terraform-mode . terraform-format-on-save-mode)
         (terraform-mode . ws-butler-mode)))

(use-package typescript-mode
  :defer t)

(use-package vterm
  :defer t)

(use-package vterm-toggle
  :config
  (setq vterm-toggle-scope 'project)
  :bind (("C-x t" . vterm-toggle)
         ("s-n"   . vterm-toggle-forward)
         ("s-p"   . vterm-toggle-backward)
         ))

(use-package ws-butler
  :diminish ws-butler-mode
  )

(use-package yaml-mode
  :hook ((yaml-mode . display-line-numbers-mode)
         (yaml-mode . highlight-indent-guides-mode)
         (yaml-mode . ws-butler-mode)))
