;; init.el --- Initialisation file for Emacs  -*- lexical-binding: t; -*-

;;; Commentary:
;;; Emacs Startup File --- initialisation for Emacs
;;; Package --- Summary
;;; Code:

;;; speed up startup
(eval-and-compile
  (setq gc-cons-threshold 402653184
	gc-cons-percentage 0.6))
(defvar temp--file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Load path
;; Optimize: Force "lisp"" at the head to reduce the startup time.
(defun update-load-path (&rest _)
  "Update `load-path'."
  (push (expand-file-name "lisp" user-emacs-directory) load-path))

(advice-add #'package-initialize :after #'update-load-path)
(update-load-path)

(require 'init-basics)
(require 'init-package)
(require 'init-ui)
(require 'init-keybindings)
(require 'init-evil)
(require 'init-magit)
(require 'init-ruby)
(require 'init-org)
(require 'init-reason)
(require 'init-python)
(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))


(load "~/.emacs.d/funcs")

;; smartparens
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

;; aggressive indent
(use-package aggressive-indent
  :config
  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'haml-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'terraform-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'elm-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'reason-mode))

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

;; auto completion
(use-package company
  :config
  (global-company-mode))


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
;; (define-key global-map (kbd "SPC") #'insert-space-in-brackets)

;; (use-package enh-ruby-mode
;;   :config
;;   (setq ruby-insert-encoding-magic-comment nil)
;;   :mode ("\\(Rake\\|Thor\\|Guard\\|Gem\\|Vagrant\\)file\\'"
;;  	 "\\.\\(rb\\|rabl\\|ru\\|builder\\|rake\\|thor\\|gemspec\\|jbuilder\\)\\'"))
;; (use-package ruby-end)
;; (use-package bundler
;;   :after enh-ruby-mode
;;   :config
;;   (setq rubocop-prefer-system-executable t
;;         rubocop-autocorrect-on-save t)
;;   :general
;;   (local-leader-def 'enh-ruby-mode-map
;;     "b" '(:ignore t :which-key "bundler")
;;     "bc" 'bundle-check
;;     "bi" 'bundle-install
;;     "bs" 'bundle-console
;;     "bu" 'bundle-update
;;     "bx" 'bundle-exec
;;     "bo" 'bundle-open ))
;; (use-package rbenv
;;   :after enh-ruby-mode
;;   :config
;;   (global-rbenv-mode))
;; (use-package rubocop
;;   :after enh-ruby-mode
;;   :hook (enh-ruby-mode . rubocop-mode)
;;   :general
;;   (local-leader-def 'enh-ruby-mode-map
;;     "rr" '(:ignore t :with-key "rubocop")
;;     "rrd" 'rubocop-check-directory
;;     "rrD" 'rubocop-autocorrect-directory
;;     "rrf" 'rubocop-check-current-file
;;     "rrF" 'rubocop-autocorrect-current-file
;;     "rrp" 'rubocop-check-project
;;     "rrP" 'rubocop-autocorrect-project))
;; (use-package rspec-mode
;;   :after enh-ruby-mode
;;   :config
;;   (setq rspec-use-opts-file-when-available nil
;;         rspec-command-options "--format progress")
;;   :general
;;   (local-leader-def 'enh-ruby-mode-map
;;     "t" '(:ignore t :which-key "rspec")
;;     "ta" 'rspec-verify-all
;;     "tb" 'rspec-verify
;;     "tc" 'rspec-verify-continue
;;     "td" 'ruby/rspec-verify-directory
;;     "te" 'rspec-toggle-example-pendingness
;;     "tf" 'rspec-verify-method
;;     "tl" 'rspec-run-last-failed
;;     "tm" 'rspec-verify-matching
;;     "tr" 'rspec-rerun
;;     "tt" 'rspec-verify-single
;;     "t~" 'rspec-toggle-spec-and-target-find-example
;;     "t TAB" 'rspec-toggle-spec-and-target))
;; (use-package ruby-tools
;;   :after enh-ruby-mode
;;   :hook (enh-ruby-mode . ruby-tools-mode))
;; (use-package inf-ruby
;;   :after enh-ruby-mode
;;   :config
;;   (inf-ruby-switch-setup))
;; (use-package rake
;;   :after enh-ruby-mode
;;   :general
;;   (local-leader-def 'enh-ruby-mode-map
;;     "k" '(:ignore t :which-ley "rake")
;;     "kk" 'rake
;;     "kr" 'rake-rerun
;;     "kR" 'rake-regenerate-cache
;;     "kf" 'rake-find-task))
;; (use-package haml-mode
;;   :mode "\\.haml\\'")

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

;; neotree
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

;; html
(use-package emmet-mode
  :hook (sgml-mode css-mode))

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
  :mode "\\.tf"
  :config
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode))

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t
        auto-package-update-interval 4))

(use-package fish-mode)

;; snippets
(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets/")
        yas-indent-line 0)
  (yas-global-mode 1))
(use-package yasnippet-snippets
  :after yasnipper)

(use-package git-timemachine
  :general
  (tyrant-def
    "gt" #'git-timemachine))

(use-package racket-mode)

(eval-and-compile
  (add-hook 'emacs-startup-hook '(lambda ()
				   (setq gc-cons-threshold 16777216
					 gc-cons-percentage 0.1
					 file-name-handler-alist temp--file-name-handler-alist))))
(setq initial-scratch-message (concat "Startup time: " (emacs-init-time)))

(provide 'init)
;;; init.el ends here
