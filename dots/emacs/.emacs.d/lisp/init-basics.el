;; init-basics.el --- Initialisation file for Emacs  -*- lexical-binding: t; -*-

;;; Commentary:
;;; Set basic settings to make Emacs nice

;;; Code:

;; sensible defaults to make Emacs nice
(setq delete-old-versions -1
      version-control t
      vc-make-backup-files t
      backup-directory-alist `(("." . "~/.emacs.d/backups")) ; which directory to put backups file
      vc-follow-symlinks t
      auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t))
      inhibit-startup-screen t
      ring-bell-function 'ignore
      coding-system-for-read 'utf-8
      coding-system-for-write 'utf-8
      locale-coding-system 'utf-8
      sentence-end-double-space nil
      create-lockfiles nil
      tags-revert-without-query 1
      scroll-conservatively 100
      compilation-scroll-output t
      whitespace-style '(trailing tabs newline tab-mark newline-mark))

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq sh-indentation 2)

(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; configure custom
(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

;; save buffers when losing focus
(add-hook 'focus-out-hook #'save-current-buffer-if-needed)

;; relative line numbers
(add-hook 'prog-mode-hook (lambda ()
			    (setq display-line-numbers-type 'relative)
			    (display-line-numbers-mode)))

;; kill trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(provide 'init-basics)
;;; init-basics.el ends here
