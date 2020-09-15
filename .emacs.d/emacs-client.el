(use-package server
  :if window-system
  :init
  (add-hook 'after-init-hook 'server-start t))

;; make C-x k end an emacsclient session
(add-hook 'server-switch-hook
          (lambda ()
            (when (current-local-map)
              (use-local-map (copy-keymap (current-local-map))))
            (when server-buffer-clients
              (local-set-key (kbd "C-x k") 'server-edit))))
