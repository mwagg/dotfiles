;; init.el --- Initialisation file for Emacs  -*- lexical-binding: t; -*-

;;; Commentary:
;;; Emacs Startup File --- initialisation for Emacs
;;; Package --- Summary
;;; Code:

(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Basic setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
      whitespace-style '(trailing tabs newline tab-mark newline-mark)
      auth-sources '("~/.authinfo.gpg"))

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

(defun save-current-buffer-if-needed ()
  "Save the current buffer if it has an unsaved change."
  (interactive)
  (when (and (buffer-file-name) (buffer-modified-p)) (save-buffer)))
(add-hook 'focus-out-hook #'save-current-buffer-if-needed)

;; relative line numbers
(add-hook 'prog-mode-hook (lambda ()
                            (setq display-line-numbers-type 'relative)
                            (display-line-numbers-mode)))
(setq global-linum-mode t)

;; kill trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; packaging
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; bootstrap use-package
(require 'package)

(setq package-enable-at-startup nil)
(setq use-package-always-ensure t)

(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
			 ("gnu"       . "http://elpa.gnu.org/packages/")
			 ("melpa"     . "https://melpa.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t
        auto-package-update-interval 4))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Mac specific stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; nice titlebar
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

;; Allow hash to be entered
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; UI
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; setup fonts
(let ((font-name (if (string-equal system-type "darwin")
                     "Source Code Pro 16"
                   "SourceCodePro-16")))
  (set-face-attribute 'default nil :font font-name )
  (set-frame-font font-name nil t))
(set-face-attribute 'fixed-pitch nil :family "Iosevka")
(set-face-attribute 'variable-pitch nil :family "Libre Baskerville")

(use-package all-the-icons
  :config
  (unless (member "all-the-icons" (font-family-list))
    (all-the-icons-install-fonts t)))

;; global text scaling
(define-globalized-minor-mode
  global-text-scale-mode
  text-scale-mode
  (lambda () (text-scale-mode 1)))

(defun global-text-scale-adjust (inc)
  "Add (INC) to the gloabl text scale."
  (interactive)
  (text-scale-set 1)
  (kill-local-variable 'text-scale-mode-amount)
  (setq-default text-scale-mode-amount (+ text-scale-mode-amount inc))
  (global-text-scale-mode 1))

(add-hook 'which-key-mode-hook (lambda ()
                                 (general-def
                                   "s-+" '(lambda ()
                                            (interactive)
                                            (global-text-scale-adjust 1))
                                   "s--" '(lambda ()
                                            (interactive)
                                            (global-text-scale-adjust -1)))))

;; themes
(use-package doom-themes
  :config
  (load-theme 'doom-nord t))
(add-hook 'general-override-mode-hook (lambda ()
                                        (tyrant-def
                                          ;; theme settings
                                          "t" '(:ignore t :which-key "themes")
                                          "tt" 'counsel-load-theme)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; global key bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package which-key
  :config
  (which-key-mode))

(use-package general
  :after which-key
  :config
  (defun find-user-init-file ()
    "Edit the `user-init-file', in same window."
    (interactive)
    (find-file user-init-file))

  (defun alternate-buffer (&optional window)
    "Switch back and forth between current and last buffer in the current WINDOW."
    (interactive)
    (let ((current-buffer (window-buffer window)))
      ;; if no window is found in the windows history, `switch-to-buffer' will
      ;; default to calling `other-buffer'.
      (switch-to-buffer
       (cl-find-if (lambda (buffer)
                     (not (eq buffer current-buffer)))
                   (mapcar #'car (window-prev-buffers window)))
       nil t)))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; editing multiple sections simultaneously
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package iedit
  :general
  (tyrant-def
    "se" 'iedit-mode)
  (general-def 'normal iedit-mode-keymap
    "f" #'iedit-restrict-function
    "l" #'iedit-restrict-current-line
    "q" #'iedit-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; evil
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package evil
  :init
  (setq evil-want-integration t
	evil-want-keybinding nil
	evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  :general
  (general-def 'normal
    "C-h" 'evil-window-left
    "C-l" 'evil-window-right
    "C-k" 'evil-window-up
    "C-j" 'evil-window-down))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-surround
  :after evil
  :config (global-evil-surround-mode 1))

(use-package evil-commentary
  :after evil
  :config (evil-commentary-mode 1)
  :general
  ('normal override-global-map
	   "gc" 'evil-commentary
	   "gC" 'evil-commentary-line))

(use-package evil-matchit
  :hook (prog-mode . evil-matchit-mode)
  :config
  (global-evil-matchit-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; git
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package magit
  :commands (magit-status)
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
  :general
  (tyrant-def
    "g"  '(:ignore t :which-key "git")
    "gs" 'magit-status
    "gb" 'magit-blame-addition))
(use-package evil-magit
  :hook (magit-mode . evil-magit-init))
(use-package magithub)

(use-package git-timemachine
  :general
  (tyrant-def
    "gt" #'git-timemachine))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; org mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org
  :defer t
  :config
  (setq org-default-notes-file "~/Sync/org/todos.org"
	org-agenda-files (list "~/Sync/org/todos.org"
                               "~/Sync/org/eporta.org")
	org-refile-targets '((nil :level . 2))
	org-todo-keywords '((sequence "☛ TODO(t)" "|" "✔ DONE(d)")
			    (sequence "⚑ WAITING(w)" "|")
			    (sequence "|" "✘ CANCELED(c)")))
  (use-package org-bullets
    :config
    (add-hook 'org-mode-hook 'org-bullets-mode)
    :init
    (setq org-bullets-bullet-list
          '("◎" "◉" "○" "⚫" "►" "◇")))

  (use-package evil-org
    :config
    (add-hook 'org-mode-hook 'evil-org-mode)
    (add-hook 'evil-org-mode-hook
              (lambda ()
                (evil-org-set-key-theme)))
    (require 'evil-org-agenda)
    (evil-org-agenda-set-keys))
  :general
  (tyrant-def
    "aoa" 'org-agenda
    "aot" 'open-org-todos)
  (local-leader-def org-mode-map
    "s" 'org-schedule
    "a" 'org-agenda
    "A" 'org-archive-subtree))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ivy/counsel/projects
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ivy
  :hook (after-init . ivy-mode)
  :config (setq ivy-use-virtual-buffers t
		ivy-count-format "(%d/%d) "
		ivy-initial-inputs-alist nil
		ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
  :commands (ivy-switch-buffer)
  :general
  (general-def ivy-mode-map
    "C-j" 'ivy-next-line
    "C-k" 'ivy-previous-line)
  (tyrant-def
    "bb" 'ivy-switch-buffer))

(use-package counsel
  :after (ivy)
  :config
  (setq counsel-grep-base-command "rg -i -M 120 --no-heading --line-number --color never '%s' %s")
  :general
  (tyrant-def
    "SPC" 'counsel-M-x
    "ff" 'counsel-find-file
    "fr" 'counsel-recentf
    "fL" 'counsel-locate))

(use-package projectile
  :config
  (projectile-mode))

(use-package counsel-projectile
  :after (projectile ivy)
  :init
  (setq projectile-completion-system 'ivy)
  :general
  (tyrant-def
    "p"   '(:ignore t :which-key "projectile")
    "pp" 'counsel-projectile-switch-project
    "pf"  'counsel-projectile-find-file
    "pb"  'counsel-projectile-switch-to-buffer
    "*" '(lambda ()
           (interactive)
           (counsel-git-grep nil (current-word)))
    "/" 'counsel-git-grep))

(use-package flyspell-correct-ivy
  :commands (flyspell-correct-word-generic)
  :hook
  (text-mode . flyspell-mode)
  (prog-mode . flyspell-prog-mode)
  :general
  (:keymaps '(flyspell-mode-map)
	    :states '(normal visual)
	    "zs" 'flyspell-correct-word-generic
            "z=" 'flyspell-buffer))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; general dev
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package aggressive-indent
  :config
  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'haml-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'terraform-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'elm-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'reason-mode))

(use-package flycheck
  :commands (flycheck-mode)
  :hook (prog-mode . flycheck-mode)
  :config
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint)))
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (defun my/use-eslint-from-node-modules ()
    (let* ((root (when (projectile-project-p)
                   (projectile-project-root)))
           (eslint (and root
                        (expand-file-name "node_modules/.bin/eslint"
                                          root))))
      (when (and eslint (file-executable-p eslint))
        (setq-local flycheck-javascript-eslint-executable eslint))))
  (add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)
  :general
  (tyrant-def
    "e" '(:ignore t :which-key "Errors")
    "el" 'flycheck-list-errors
    "en" 'flycheck-next-error
    "ep" 'flycheck-previous-error))

(use-package flycheck-inline
  :after flycheck
  :config
  (global-flycheck-inline-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets/")
        yas-indent-line 0)
  (yas-global-mode 1))
(use-package yasnippet-snippets
  :after yasnipper)

(use-package dumb-jump)
(use-package smart-jump
  :general
  ('normal
   "gd" 'smart-jump-go)
  :config
  (smart-jump-setup-default-registers))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package company
  :config
  (global-company-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; neotree
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package neotree
  :config
  (defun neotree-project-dir-toggle ()
    "Open NeoTree using the project root, using find-file-in-project,
or the current buffer directory."
    (interactive)
    (let ((project-dir
           (ignore-errors
           ;;; Pick one: projectile or find-file-in-project
                                        ; (projectile-project-root)
             (ffip-project-root)
             ))
          (file-name (buffer-file-name))
          (neo-smart-open t))
      (if (and (fboundp 'neo-global--window-exists-p)
               (neo-global--window-exists-p))
          (neotree-hide)
        (progn
          (neotree-show)
          (if project-dir
              (neotree-dir project-dir))
          (if file-name
              (neotree-find file-name))))))
  :general
  (tyrant-def
    "pt" #'neotree-project-dir-toggle))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; lisps
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package smartparens
  :hook ((prog-mode . smartparens-mode))
  :config
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
  (sp-local-pair 'clojure-mode "'" nil :actions nil)
  (sp-local-pair 'racket-mode "'" nil :actions nil)
  :general
  (general-def
    "C-<left>" #'sp-backward-slurp-sexp
    "S-C-<left>" #'sp-backward-barf-sexp
    "C-<right>" #'sp-forward-slurp-sexp
    "S-C-<right>" #'sp-forward-barf-sexp
    "M-s" #'sp-unwrap-sexp
    ))
(use-package evil-smartparens
  :hook
  (smartparens-mode . evil-smartparens-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; LSP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package lsp-mode
  :hook ((js-mode . lsp-mode)
	 (web-mode . lsp-mode)
         (elm-mode . lsp-mode)
         (python-mode . lsp-mode))
  :config
  (setq lsp-enable-on-type-formatting t))
(use-package lsp-ui
  :after lsp-mode)
(use-package company-lsp
  :after lsp-mode)
(use-package lsp-treemacs
  :after lsp-mode)
(use-package lsp-ivy
  :after lsp-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; javascript
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package js2-mode
  :config
  (setq indent-tabs-mode nil))
(use-package rjsx-mode)
(use-package eslintd-fix)
(use-package json-mode
  :hook (json-mode . (lambda ()
		       (make-local-variable 'js-indent-level)
		       (setq js-indent-level 2))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; elm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package elm-mode
  :mode "\\.elm\\'"
  :config
  (add-to-list 'company-backends 'company-elm)
  (setq elm-sort-imports-on-save t
	elm-format-on-save t
	elm-interactive-command '("elm" "repl")
	elm-reactor-command '("elm" "reactor")
	elm-reactor-arguments '("--port" "8000")
	elm-compile-command '("elm" "make")
	elm-compile-arguments '("--output=elm.js" "--debug")
	elm-package-command '("elm" "package")
	elm-package-json "elm.json"
        elm-tags-on-save t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; yaml
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package yaml-mode
  :mode "\\.yml\\'")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package emmet-mode
  :hook (sgml-mode css-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; terraform
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package terraform-mode
  :mode "\\.tf"
  :config
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; fish shell
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package fish-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package pyvenv)

(setq initial-scratch-message (concat "Startup time: " (emacs-init-time)))

(provide 'init)
;;; init.el ends here
