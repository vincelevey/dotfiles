;;; -*- lexical-binding: t -*-

(use-package all-the-icons)

(use-package all-the-icons-dired
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package bind-key
  :bind (("C-x C-b" . buffer-menu)
         ("M-j"     . (lambda () (interactive) (delete-indentation -1)))
         ("<f1>"    . undo)
         ("<f12>"   . (lambda () (interactive) (switch-to-buffer "*scratch*")))
         ("<f13>"   . mac-toggle-tab-group-overview)
         ))

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

(use-package dockerfile-mode
  :mode "Dockerfile\\'")

(use-package doom-modeline
  :if (display-graphic-p)
  :config (doom-modeline-mode))

(use-package highlight-indent-guides
  :if (display-graphic-p)
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
  :if (string-equal system-type "darwin")
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

(use-package yaml-mode
  :hook ((yaml-mode . display-line-numbers-mode)
         (yaml-mode . highlight-indent-guides-mode)))
