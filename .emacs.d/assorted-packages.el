;;; -*- lexical-binding: t -*-

(use-package all-the-icons
  :when (display-graphic-p)
  :config
  (when (not (member "all-the-icons" (font-family-list)))
    (all-the-icons-install-fonts t)))

(use-package bind-key
  :bind (("C-x C-b" . buffer-menu)
         ("M-j"     . (lambda () (interactive) (delete-indentation -1)))
         ([f1]      . undo)
         ([f12]     . (lambda () (interactive) (switch-to-buffer "*scratch*")))
         ([f13]     . mac-toggle-tab-group-overview)
         ))

(use-package deadgrep
  :bind (("s-g" . deadgrep)))

(use-package dired
  :ensure nil
  :config
  (progn
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

(use-package dired-sidebar
  :bind (("s-d" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)
  (setq dired-sidebar-theme 'nerd)
  (setq dired-sidebar-use-custom-font t))

(use-package dockerfile-mode
  :mode "Dockerfile\\'")

(use-package doom-modeline
  :requires all-the-icons
  :when (display-graphic-p)
  :config (doom-modeline-mode))

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
  :bind (("C-x g"   . magit-status)
         ("C-x C-g" . magit-status)
         ))

(use-package markdown-mode)

(use-package material-theme
  :ensure t
  :config
  (load-theme 'material t))

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
         (terraform-mode . terraform-format-on-save-mode)))

(use-package vterm
  :defer t)

(use-package vterm-toggle
  :config
  (setq vterm-toggle-scope 'project)
  :bind (("s-t" . vterm-toggle)
         ("s-n" . vterm-toggle-forward)
         ("s-p" . vterm-toggle-backward)
         ))

(use-package yaml-mode
  :hook ((yaml-mode . display-line-numbers-mode)
         (yaml-mode . highlight-indent-guides-mode)))
