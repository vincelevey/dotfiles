;;; -*- Mode: Emacs-Lisp -*-
;;;
;;; Vince Levey's Emacs functions.

(unless (fboundp 'user-mail-address)
  (defun user-mail-address ()
    "Return the user's mail address."
    user-mail-address))

(defun re-autoload (function &rest other-autoload-args)
  (fmakunbound function)
  (apply 'autoload function other-autoload-args))

(defun chmod (mode)
  "Set the mode of the current file, in octal, as per the chmod program.
If the current file doesn't exist yet the buffer is saved to create it."
  (interactive "sMode (3 or 4 octal digits): ")
  (or (string-match "[0-3]?[0-7][0-7][0-7]" mode)
      (error "Invalid mode"))
  ;; make sure the file exists
  (unless (file-exists-p (buffer-file-name))
    (save-buffer))
  (set-file-modes (buffer-file-name) (string-to-number mode 8)))

(defun count-lines-buffer (b)
  "Print number of lines and characters in the specified buffer."
  (interactive "_b")
  (save-excursion
    (let ((buf (or b (current-buffer)))
          cnt)
      (set-buffer buf)
      (setq cnt (count-lines (point-min) (point-max)))
      (message "Buffer has %d lines, %d characters"
               cnt (- (point-max) (point-min)))
      cnt)))

(defun shell-script-mode-hackery ()
  (cond ((<= (count-lines-buffer (current-buffer)) 1)
	 (forward-line 1)
	 (let* ((mod (buffer-modified-p))
                (s (current-time-string))
                (year (substring s 20 24)))
	   (insert
            "#!/bin/bash\n"
            "# -*- tab-width: 2; indent-tabs-mode: nil; -*-\n"
	    "# Copyright (c) " year " Huboo\n"
            "#\n"
            "# Written by " user-full-name " <" user-mail-address ">\n"
	    "# Created: "
	    (let* ((s (current-time-string))
		   (day (substring s 8 10))
		   (mon (substring s 4 7))
		   (year (substring s 20 24)))
	      (concat day "-" mon "-" year))
	    ".\n\n")
	   (set-buffer-modified-p mod))))
  nil)
(add-hook 'sh-mode-hook 'shell-script-mode-hackery)

(defun perl-mode-hackery ()
  (cond ((<= (count-lines-buffer (current-buffer)) 1)
	 (forward-line 1)
	 (let* ((mod (buffer-modified-p))
                (s (current-time-string))
                (year (substring s 20 24)))
	   (insert
            "#!/usr/bin/perl -w\n"
            "# Copyright (c) " year " Huboo\n"
            "#\n"
            "# Written by " user-full-name " <" user-mail-address ">\n"
	    "# Created: "
	    (let* ((s (current-time-string))
		   (day (substring s 8 10))
		   (mon (substring s 4 7))
		   (year (substring s 20 24)))
	      (concat day "-" mon "-" year))
	    ".\n\n"
            "require 5;\n"
            "use diagnostics;\n"
            "use strict;\n"
            "\n"
            "my $progname = $0; $progname =~ s@.*/@@g;\n"
            "my $version = q{ $Revision: 0.00 $ }; "
            "$version =~ s/^[^0-9]+([0-9.]+).*$/$1/;\n"
            "\n"
            "my $verbose = 0;\n"
            "\n\n\n\n"
            "sub error {\n"
            "  my ($err) = @_;\n"
            "  print STDERR \"$progname: $err\\n\";\n"
            "  exit 1;\n"
            "}\n"
            "\n"
            "sub usage {\n"
            "  print STDERR \"usage: $progname [--verbose]\\n\";\n"
            "  exit 1;\n"
            "}\n"
            "\n"
            "sub main {\n"
            "  while ($#ARGV >= 0) {\n"
            "    $_ = shift @ARGV;\n"
            "    if ($_ eq \"--verbose\") { $verbose++; }\n"
            "    elsif (m/^-v+$/) { $verbose += length($_)-1; }\n"
            "    elsif (m/^-./) { usage; }\n"
            "    else { usage; }\n"
            "  }\n"
            "\n\n\n"
            "}\n"
            "\n"
            "main;\n"
            "exit 0;\n")
	   (set-buffer-modified-p mod))))
  nil)
(add-hook 'perl-mode-hook 'perl-mode-hackery)
(add-hook 'cperl-mode-hook 'perl-mode-hackery)

(defun new-shell ()
  (interactive)
  (if (not (get-buffer "*shell*"))
      (shell)
    (let ((buffer (buffer-name (generate-new-buffer "*shell*"))))
      (kill-buffer buffer)
      (save-excursion
	(set-buffer "*shell*")
	(rename-buffer "_shell_tmp_")
	(shell)
	(set-buffer "*shell*")
	(rename-buffer buffer)
	(set-buffer "_shell_tmp_")
	(rename-buffer "*shell*"))
      (switch-to-buffer buffer))))

(defun sortuniq-region (start end)
  (interactive "*r")
  (shell-command-on-region start end "sort --unique" t t))

(defun dict (word)
  (interactive (list
		(let* ((w (current-word))
		       (s (read-string (concat "Webster (" w "): "))))
		  (if (equal s "") w s))))
  (funcall browse-url-browser-function
	   (concat
;;	    "http://c.gp.cs.cmu.edu:5103/prog/webster?"
;;          "http://www.m-w.com/cgi-bin/mweb?book=Dictionary&va="
            "http://www.m-w.com/cgi-bin/dictionary?book=Dictionary&va="
	    word)
           "NEW-WINDOW"))

(defun google (&optional string)
  (interactive (list
		(let* ((w (current-word))
		       (s (read-string (concat "Google Search (" w "): "))))
		  (if (equal s "") w s))))
  (funcall browse-url-browser-function
	   (concat "http://www.google.com/search?q=" string)
           "NEW-WINDOW"))

(defun my-insert-changelog-header ()
  (interactive nil)
  (insert
   (concat "# "
           (format-time-string "%Y-%m-%d")
           "  " user-full-name "  <" user-mail-address ">\n")
   "#         * "))

(fset 'clog 'my-insert-changelog-header)

(defun new-scratch ()
  "Create and/or select a proper *scratch* buffer."
   (interactive)
   (get-buffer-create "*scratch*")
   (switch-to-buffer "*scratch*")
   (setq default-directory "~/") ; note: can be buffer-specific
   (funcall initial-major-mode))

(defun dos2unix ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

(defun unix2dos ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t) (replace-match "\r\n")))

(defun remove-newlines (start end)
  "Removes newlines from a region."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char start)
      (forward-line 1)
      (while (and (< (point) end) (not (eobp)))
        (delete-indentation)
        (forward-line 1)))))

(defun vincel-cite-region (start end)
  "Fill a region as a mail citation."
  (interactive "r")
  (save-excursion
    (save-restriction
      (goto-char start)
      (insert "> ")
      (let ((fill-prefix "> "))
        (fill-region-as-paragraph start (+ end 2))))))

(defun vincel-slice (arg)
  "Insert the contents of a file into the buffer, preceding it with a
\"cut here\" type of indicator line."
  (interactive "*fInsert file: ")
  (let ((file (file-name-nondirectory arg)))
    (insert
     (make-string 10 ?-)
     " slice 'n' dice "
     (make-string (- 45 (length file)) ?-)
     " file: " file "\n")
    (insert-file-contents arg)
    ))

(defmacro vincel-ignore-errors (&rest body)
  "Execute BODY; if an error occurs, return nil.
Otherwise, return result of last form in BODY.
Code stolen from Common Lisp."
  `(condition-case nil (progn ,@body) (error nil)))

(defun eshell/info (&optional subject)
  "Invoke `info', optionally opening the Info system to SUBJECT."
  (let ((buf (current-buffer)))
    (Info-directory)
    (if (not (null subject))
        (let ((node-exists (vincel-ignore-errors (Info-menu subject))))
          (if (not node-exists)
              (format "No menu item `%s' in node `(dir)Top'." subject))))))

(defun de-unicoddle ()
  "Tidy up a buffer by replacing all special Unicode
characters (smart quotes, etc.) with their saner cousins."
  (interactive)
  (let ((unicode-map '(("\u2018" . "'")
                       ("\u2019" . "'")
                       ("\u201a" . "'")
                       ("\ufffd" . "'")
                       ("\u201c" . "\"")
                       ("\u201d" . "\"")
                       ("\u201e" . "\"")
                       ("\u207c" . "|")
                       ("\u2013" . "-")
                       ("\u2014" . "-")
                       ("\u2022" . "*")
                       ("\u2026" . "...")
                       ("\u00a9" . "(c)")
                       ("\u00ae" . "(r)")
                       ("\u2122" . "TM")
                       ("\u00fc" . "ue")
                       ("\u263a" . ":)")
                       ("\u02dc" . " ")
                       ("\u00A0" . " ")
                       )))
    (save-excursion
      (cl-loop for (key . value) in unicode-map
            do
            (goto-char (point-min))
            (while (re-search-forward key nil t)
              (replace-match value nil nil)
              ))
      )))

(defun my-rpm-changelog-increment-version ()
  (interactive)
  (goto-char (point-min))
  (let* ((max (search-forward-regexp rpm-section-regexp))
         (version (rpm-spec-field-value "Version" max)))
    (rpm-add-change-log-entry (concat "Upgrade version to " version))
    ))
