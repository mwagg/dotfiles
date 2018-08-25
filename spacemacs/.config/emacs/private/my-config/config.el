;; elm layer
(setq elm-sort-imports-on-save t
      elm-format-on-save t)

;; shell layer
(setq shell-default-shell 'eshell
      shell-default-height 40)

;; ruby layer
(setq ruby-test-runner 'rspec
      ruby-insert-encoding-magic-comment nil)

;; org layer
(setq org-enable-github-support t
      org-projectile-file "~/Dropbox/org/projects.org"
      org-default-notes-file "~/Dropbox/org/todos.org"
      org-agenda-files (list "~/Dropbox/org/todos.org"
                             "~/Dropbox/org/projects.org")
      org-capture-templates '(
                              ("t" "Todo" entry (file+headline "~/Dropbox/org/todos.org" "To be prioritised")
                               "* TODO %?\n%i"))
      org-refile-targets '((nil :level . 2)))

;; spacemacs settings
(setq dotspacemacs-line-numbers 'relative
      dotspacemacs-smartparens-strict-mode t
      dotspacemacs-loading-progress-bar nil
      dotspacemacs-whitespace-cleanup 'trailing
      vc-follow-symlinks t
      create-lockfiles nil)

;; javascript
(setq js2-basic-offset 2
      js-indent-level 2)

;; css
(setq css-indent-offset 2)

;; save on losing focus
(add-hook 'focus-out-hook #'my-config/save-current-buffer-if-needed)
