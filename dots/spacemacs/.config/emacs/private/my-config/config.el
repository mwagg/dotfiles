;; elm layer
(setq elm-sort-imports-on-save t
      elm-format-on-save t
      elm-interactive-command '("elm" "repl")
      elm-reactor-command '("elm" "reactor")
      elm-reactor-arguments '("--port" "8000")
      elm-compile-command '("elm" "make")
      elm-compile-arguments '("--output=elm.js" "--debug")
      elm-package-command '("elm" "package")
      elm-package-json "elm.json")

;; shell layer
(setq shell-default-shell 'eshell
      shell-default-height 40)

;; ruby layer
(setq ruby-test-runner 'rspec
      ruby-insert-encoding-magic-comment nil)

;; org layer
(setq org-enable-github-support t
      org-projectile-file "Sync"
      org-default-notes-file "~/Sync/org/todos.org"
      org-agenda-files (list "~/Sync/org/todos.org")
      org-capture-templates '(
                              ("t" "Todo" entry (file+headline "~/Sync/org/todos.org" "To be prioritised")
                               "* TODO %?\n%i"))
      org-refile-targets '((nil :level . 2)))

;; spacemacs settings
(setq dotspacemacs-line-numbers 'relative
      dotspacemacs-loading-progress-bar nil
      dotspacemacs-whitespace-cleanup 'trailing
      vc-follow-symlinks t
      create-lockfiles nil)

;; lisp/clojure
(add-hook 'clojure-mode-hook #'smartparens-strict-mode)
(add-hook 'emacs-lisp-mode-hook #'smartparens-strict-mode)
(add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)

;; web-mode
(setq web-mode-markup-indent-offset 2)

;; javascript
(setq js2-basic-offset 2
      js-indent-level 2)

;; css
(setq css-indent-offset 2)

;; save on losing focus
(add-hook 'focus-out-hook #'my-config/save-current-buffer-if-needed)

;; magit
(setq git-magit-status-fullscreen t)

;; store auth info in a GPG encrypted file
(setq auth-sources '("~/.authinfo.gpg"))

;; make sure GPG works with pinentry
(setf epa-pinentry-mode 'loopback)

;; global font size scaling
(define-globalized-minor-mode
  global-text-scale-mode
  text-scale-mode
  (lambda () (text-scale-mode 1)))

;; pretty code ligatures
(add-hook 'elm-mode-hook 'my-config/setup-ligatures)
(add-hook 'clojure-mode-hook 'my-config/setup-ligatures)

;; clojure
(setq clojure-enable-clj-refactor t)

;; smarter curly brace insert space
(define-key global-map (kbd "SPC") 'my-config/insert-space)

(setq projectile-enable-caching t)
