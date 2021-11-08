;;; -*- lexical-binding: t -*-

(require 'redo+)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "M-z") 'redo)

(delete-selection-mode t)
(column-number-mode)

(setq-default create-lockfiles nil)
