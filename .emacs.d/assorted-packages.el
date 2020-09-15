(use-package all-the-icons
  :if window-system
  :config
  (when (not (member "all-the-icons" (font-family-list)))
    (all-the-icons-install-fonts t)))

(use-package bind-key
  :bind (("C-x C-b" . buffer-menu)
         ("M-j"     . (lambda () (interactive) (delete-indentation -1)))
         ("<f5>"    . ispell-buffer)
         ("<f6>"    . ispell-region)
         ("<f8>"    . canonically-space-region)
         ("<f12>"   . (lambda () (interactive) (switch-to-buffer "*scratch*")))
         ))

;; (use-package magit
;;   :bind (("C-x m" . magit-status)))

;; (use-package git-emacs
;;   :load-path "custom-packages/git-emacs")

(use-package markdown-mode)

(use-package puppet-mode
  :config
  (add-hook 'puppet-mode-hook
            (lambda ()
              (add-to-list 'write-file-functions 'delete-trailing-whitespace)
              )))

(use-package ipcalc)

(use-package json-mode
  :pin gnu)

;; (use-package spaceline
;;   :if window-system
;; ;  :init
;; ;  (setq ns-use-srgb-colorspace nil) ;; now fixed
;;   :config
;;   (require 'spaceline-config)
;;   (spaceline-spacemacs-theme))

;; (use-package spaceline-all-the-icons
;;   :if window-system
;;   :after spaceline
;;   :config
;;   (spaceline-all-the-icons-theme))

(use-package spacemacs-common
  :if window-system
  :ensure spacemacs-theme
  :config
  (load-theme 'spacemacs-dark t nil))

(use-package yaml-mode)

;; (use-package zerodark-theme
;;   :if window-system
;;   :config
;;   (load-theme 'zerodark t nil)
;;   (zerodark-setup-modeline-format))
