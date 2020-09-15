(defun kill-buffer-but-not-some ()
  (interactive)
  (if (member (buffer-name (current-buffer)) not-to-kill-buffer-list)
      (bury-buffer)
    (kill-buffer (current-buffer))
    ))

(setq not-to-kill-buffer-list '("*scratch*" "*Messages*" "*eshell*"))
(substitute-key-definition 'kill-buffer 'kill-buffer-but-not-some global-map)

(require 'minibuf-electric-gnuemacs)
