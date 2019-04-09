;; init.el --- Initialisation file for Emacs  -*- lexical-binding: t; -*-

;;; Commentary:
;;; Emacs Startup File --- initialisation for Emacs
;;; Package --- Summary
;;; Code:
(eval-and-compile
  (setq gc-cons-threshold 402653184
	gc-cons-percentage 0.6))
(defvar temp--file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

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
      scroll-conservatively 100)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq sh-indentation 2)

;; show tabs
(setq whitespace-style '(trailing tabs newline tab-mark newline-mark))

(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; setup fonts
(set-face-attribute 'default nil :font "mononoki-12" )
(set-frame-font "mononoki-12" nil t)
(set-face-attribute 'fixed-pitch nil :family "Iosevka")
(set-face-attribute 'variable-pitch nil :family "Libre Baskerville")

;; paths
(defvar my-bin-paths '("~/.local/bin"))
(dolist (path my-bin-paths)
  (setenv "PATH" (concat (getenv "PATH") (concat ":" path)))
  (setq exec-path (append exec-path (list path))))

;; configure custom
(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

(load "~/.emacs.d/funcs")

;; save buffers when losing focus
(add-hook 'focus-out-hook #'save-current-buffer-if-needed)

;; relative line numbers
(add-hook 'prog-mode-hook (lambda ()
			    (setq display-line-numbers-type 'relative)
			    (display-line-numbers-mode)))

;; kill trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; bootstrap use-package
(require 'package)

(setq package-enable-at-startup nil)
(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
			 ("gnu"       . "http://elpa.gnu.org/packages/")
			 ("melpa"     . "https://melpa.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; global text scaling
(define-globalized-minor-mode
  global-text-scale-mode
  text-scale-mode
  (lambda () (text-scale-mode 1)))

;; which-key
(use-package which-key
  :config
  (which-key-mode))

;; general
(use-package general
  :after which-key
  :init
  (general-override-mode 1)
  :config
  (general-def
    "s-+" '(lambda ()
	     (interactive)
	     (global-text-scale-adjust 1))
    "s--" '(lambda ()
	     (interactive)
	     (global-text-scale-adjust -1)))

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

  (tyrant-def
    "" nil
    "c" (general-simulate-key "C-c")
    "h" (general-simulate-key "C-h")
    "u" (general-simulate-key "C-u")
    "x" (general-simulate-key "C-x")
    "TAB" 'alternate-buffer

    ;; theme settings
    "t" '(:ignore t :which-key "themes")

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
    "ws" 'eshell

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
    "q" 'quit-window))

;; evil
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
;; smartparens
(use-package smartparens
  :hook ((emacs-lisp-mode . smartparens-strict-mode)
	 (clojure-mode . smartparens-strict-mode)
	 (enh-ruby-mode . smartparens-mode)
	 (elm-mode . smartparens-mode))
  :config
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
  (sp-local-pair 'clojure-mode "'" nil :actions nil)
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

;; aggressive indent
(use-package aggressive-indent
  :config
  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'haml-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'terraform-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'elm-mode))

;; ivy-mode
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
;; counsel
(use-package counsel
  :after (ivy)
  :config
  (setq counsel-grep-base-command "rg -i -M 120 --no-heading --line-number --color never '%s' %s")
  :general
  (tyrant-def
    "SPC" 'counsel-M-x
    "tt" 'counsel-load-theme
    "ff" 'counsel-find-file
    "fr" 'counsel-recentf
    "fL" 'counsel-locate))
;; projectile
(use-package projectile
  :config
  (projectile-mode)
  (add-hook 'projectile-after-switch-project-hook #'set-eyebrowse-workspace-name-to-project))

(use-package counsel-projectile
  :after (projectile ivy)
  :init
  (setq projectile-completion-system 'ivy)
  :general
  (tyrant-def
    "p"   '(:ignore t :which-key "projectile")
    "p'" #'open-terminal-in-project-root
    "pp" 'counsel-projectile-switch-project
    "pt" #'projectile-find-tag
    "pf"  'counsel-projectile-find-file
    "pb"  'counsel-projectile-switch-to-buffer
    "*" '(lambda ()
           (interactive)
           (counsel-git-grep nil (current-word)))
    "/" 'counsel-git-grep))
;; spelling
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

;; projectile
(use-package projectile
  :config
  (projectile-mode)
  (add-hook 'projectile-after-switch-project-hook #'set-eyebrowse-workspace-name-to-project))

;; flycheck
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


;; magit
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

;; auto completion
(use-package company
  :config
  (global-company-mode))

;; ;; mode line
(use-package telephone-line
  :config
  (setq telephone-line-primary-left-separator 'telephone-line-abs-left telephone-line-primary-right-separator 'telephone-line-abs-right)
  (setq telephone-line-lhs
        '((evil   . (telephone-line-evil-tag-segment))
          (accent . (telephone-line-vc-segment
		     telephone-line-projectile-segment
                     telephone-line-process-segment))
          (nil    . (telephone-line-buffer-segment))))
  (setq telephone-line-rhs
	'((nil    . (telephone-line-misc-info-segment))
          (accent . (telephone-line-major-mode-segment))
          (evil   . (telephone-line-airline-position-segment))))
  (telephone-line-mode 1))

;; Clojure
(use-package clojure-mode
  :mode "\\.clj\\|\\.edn\\'"
  :general
  (local-leader-def 'clojure-mode-map
    "'" 'cider-jack-in
    "ee" 'cider-eval-last-sexp
    "eb" 'cider-eval-buffer
    "ef" 'cider-eval-defun-at-point
    "ew" 'cider-eval-last-secp-and-replace
    "er" 'cider-ns-refresh
    "ss" 'cider-switch-to-repl-buffer
    "sq" 'cider-quit
    "=" 'cider-format-buffer
    "ta" 'cider-test-run-project-tests
    "tt" 'cider-test-run-test
    "tb" 'cider-test-show-report
    "hh" 'cider-doc
    "hn" 'cider-browse-ns
    "r" '(:ignore t :which-key "refactor")
    "ra" '(:ignore t :which-key "add")
    "rap" 'cljr-add-project-dependency
    "rar" 'cljr-add-require-to-ns))
(use-package cider
  :after clojure-mode)
(use-package clj-refactor
  :hook (clojure-mode-hook . clj-refactor-mode)
  :after clojure-mode)
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; ruby
(define-key global-map (kbd "SPC") #'insert-space-in-brackets)

(use-package enh-ruby-mode
  :config
  (setq ruby-insert-encoding-magic-comment nil)
  :mode ("\\(Rake\\|Thor\\|Guard\\|Gem\\|Vagrant\\)file\\'"
 	 "\\.\\(rb\\|rabl\\|ru\\|builder\\|rake\\|thor\\|gemspec\\|jbuilder\\)\\'"))
(use-package bundler
  :after enh-ruby-mode
  :general
  (local-leader-def 'enh-ruby-mode-map
    "b" '(:ignore t :which-key "bundler")
    "bc" 'bundle-check
    "bi" 'bundle-install
    "bs" 'bundle-console
    "bu" 'bundle-update
    "bx" 'bundle-exec
    "bo" 'bundle-open ))
(use-package rbenv
  :after enh-ruby-mode
  :config
  (global-rbenv-mode))
(use-package rubocop
  :after enh-ruby-mode
  :hook (enh-ruby-mode . rubocop-mode)
  :general
  (local-leader-def 'enh-ruby-mode-map
    "rr" '(:ignore t :with-key "rubocop")
    "rrd" 'rubocop-check-directory
    "rrD" 'rubocop-autocorrect-directory
    "rrf" 'rubocop-check-current-file
    "rrF" 'rubocop-autocorrect-current-file
    "rrp" 'rubocop-check-project
    "rrP" 'rubocop-autocorrect-project))
(use-package rspec-mode
  :after enh-ruby-mode
  :general
  (local-leader-def 'enh-ruby-mode-map
    "t" '(:ignore t :which-key "rspec")
    "ta" 'rspec-verify-all
    "tb" 'rspec-verify
    "tc" 'rspec-verify-continue
    "td" 'ruby/rspec-verify-directory
    "te" 'rspec-toggle-example-pendingness
    "tf" 'rspec-verify-method
    "tl" 'rspec-run-last-failed
    "tm" 'rspec-verify-matching
    "tr" 'rspec-rerun
    "tt" 'rspec-verify-single
    "t~" 'rspec-toggle-spec-and-target-find-example
    "t TAB" 'rspec-toggle-spec-and-target))
(use-package ruby-tools
  :after enh-ruby-mode
  :hook (enh-ruby-mode . ruby-tools-mode))
(use-package rake
  :after enh-ruby-mode
  :general
  (local-leader-def 'enh-ruby-mode-map
    "k" '(:ignore t :which-ley "rake")
    "kk" 'rake
    "kr" 'rake-rerun
    "kR" 'rake-regenerate-cache
    "kf" 'rake-find-task))
(use-package haml-mode
  :mode "\\.haml\\'")

;; matchit
(use-package evil-matchit
  :hook (prog-mode . evil-matchit-mode)
  :config
  (global-evil-matchit-mode 1))

;; yaml
(use-package yaml-mode
  :mode "\\.yml\\'")

;; elm
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

;; ranger
(use-package ranger
  :general
  (tyrant-def
    "rp" #'ranger-project-root-dir
    "rr" #'ranger))

;; iedit
(use-package iedit
  :general
  (tyrant-def
    "se" 'iedit-mode)
  (general-def 'normal iedit-mode-keymap
    "f" #'iedit-restrict-function
    "l" #'iedit-restrict-current-line
    "q" #'iedit-mode))

;; smart/dumb jump
(use-package dumb-jump)
(use-package smart-jump
  :general
  ('normal
   "gd" 'smart-jump-go)
  :config
  (smart-jump-setup-default-registers))

;; org mode
(use-package org
  :defer t
  :config
  (setq org-default-notes-file "~/Sync/org/todos.org"
	org-agenda-files (list "~/Sync/org/todos.org")
	org-refile-targets '((nil :level . 2))
	org-todo-keywords '((sequence "☛ TODO(t)" "|" "✔ DONE(d)")
			    (sequence "⚑ WAITING(w)" "|")
			    (sequence "|" "✘ CANCELED(c)")))
  :general
  (tyrant-def
    "aoa" 'org-agenda
    "aot" 'open-org-todos
    "aoj" 'org-journal-new-entry)
  (local-leader-def org-mode-map
    "s" 'org-schedule
    "a" 'org-agenda
    "A" 'org-archive-subtree))
(use-package org-bullets
  :after org-mode
  :hook
  (org-mode . org-bullet)
  :init
  (setq org-bullets-bullet-list
	'("◉" "◎" "⚫" "○" "►" "◇")))
(use-package evil-org
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))
(use-package org-journal
  :after org
  :config
  (setq org-journal-dir "~/Sync/org/journal"))

;; javascript
(use-package js2-mode
  :config
  (setq js-indent-level 2)
  (setq-default indent-tabs-mode nil))

;; JSON
(use-package json-mode)

;; css
(setq css-indent-offset 2)

;; eyebrowse
(use-package eyebrowse
  :config
  (setq eyebrowse-wrap-around t)
  (eyebrowse-mode 1)
  :general
  (general-def 'normal
    "M-n" #'eyebrowse-create-window-config
    "M-d" #'eyebrowse-close-window-config
    "M-h" #'eyebrowse-prev-window-config
    "M-l" #'eyebrowse-next-window-config))

;; terraform
(use-package terraform-mode
  :mode "\\.tf")

;; doom themes
(use-package doom-themes
  :config
  (load-theme 'doom-molokai t))

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t
        auto-package-update-interval 4)
  (auto-package-update-maybe))

(use-package fish-mode)

;; snippets
(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets/")
        yas-indent-line 0)
  (yas-global-mode 1))

(eval-and-compile
  (add-hook 'emacs-startup-hook '(lambda ()
				   (setq gc-cons-threshold 16777216
					 gc-cons-percentage 0.1
					 file-name-handler-alist temp--file-name-handler-alist))))
(setq initial-scratch-message (concat "Startup time: " (emacs-init-time)))

(provide 'init)
;;; init.el ends here
