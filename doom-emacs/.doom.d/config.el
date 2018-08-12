;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; lang/org
(setq org-directory "~/Dropbox/org"
      org-capture-templates '(
                              ("t" "Todo" entry (file+headline "~/Dropbox/org/todos.org" "To be prioritised")
                               "* TODO %?\n%i"))
      org-refile-targets '((nil :level . 2)))

;; relative line numbers
(setq display-line-numbers-type 'relative)
