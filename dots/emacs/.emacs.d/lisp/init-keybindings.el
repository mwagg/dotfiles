;; init-keybindings.el --- Initialisation file for Emacs  -*- lexical-binding: t; -*-

;;; Commentary:
;;; Set up general package and global keybindings

;;; Code:

;; which-key
(use-package which-key
  :config
  (which-key-mode))

;; general
(use-package general
  :after which-key
  :config
  (general-create-definer tyrant-def
    :states '(normal visual insert motion emacs)
    :prefix "SPC"
    :non-normal-prefix "C-SPC")

  (general-create-definer despot-def
    :states '(normal insert)
    :prefix "SPC"
    :non-normal-prefix "C-SPC")

  (general-create-definer local-leader-def
    :states '(normal)
    :prefix ",")

  (general-define-key
   :keymaps 'key-translation-map
   "ESC" (kbd "C-g"))

  ;; navigating between windows
  (tyrant-def
    "" nil
    "c" (general-simulate-key "C-c")
    "h" (general-simulate-key "C-h")
    "u" (general-simulate-key "C-u")
    "x" (general-simulate-key "C-x")
    "TAB" 'alternate-buffer

    ;; buffers
    "b" '(:ignore t :which-key "buffers")

    ;; files
    "f" '(:ignore t :which-key "files")
    "fed" 'find-user-init-file
    "fs" 'save-buffer

    ;; Window operations
    "w"   '(:ignore t :which-key "window")
    "wm"  'maximize-window
    "w/"  'split-window-horizontally
    "wv"  'split-window-vertically
    "wm"  'maximize-window
    "wu"  'winner-undo
    "ww"  'other-window
    "wd"  'delete-window
    "wD" 'delete-other-windows
    "ws" #'projectile-run-eshell


    ;; applications
    "a" '(:ignore t :which-key "Applications")
    "ad" 'dired
    "ac" 'caletdar

    ;; Quit operations
    "q" '(:ignore t :which-key "quit emacs")
    "qq" 'evil-quit-all
    "qz" 'delete-frame)

  (general-def 'normal package-menu-mode-map
    "i"   'package-menu-mark-install
    "U"   'package-menu-mark-upgrades
    "d"   'package-menu-mark-delete
    "u"   'package-menu-mark-unmark
    "x"   'package-menu-execute
    "q" 'quit-window)

  (general-override-mode 1))

(provide 'init-keybindings)
;;; init-keybindings.el ends here
