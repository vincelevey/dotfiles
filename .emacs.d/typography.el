;;; -*- lexical-binding: t -*-

(when (and (eq system-type 'darwin)
           (member "Iosevka" (font-family-list)))
  (set-face-attribute 'default nil :family "Iosevka" :height 140))

;; (when (and (eq system-type 'windows-nt)
;;            (member "Cascadia" (font-family-list)))
;;   (set-face-attribute 'default nil :family "Cascadia" :height 130))

(when (eq system-type 'windows-nt)
  (if (member "Cascadia" (font-family-list))
      (set-face-attribute 'default nil :family "Cascadia" :height 130)
    (set-face-attribute 'default nil :family "Consolas" :height 110)
    ))

;; ligature support
(when (fboundp 'mac-auto-operator-composition-mode)
  (mac-auto-operator-composition-mode))

(unless (member "all-the-icons" (font-family-list))
  (all-the-icons-install-fonts t))
