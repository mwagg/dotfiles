;; init-org.el --- Initialize org-mode configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; org-mode config.
;;

;;; Code:

;; org mode
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
          '("◉" "◎" "⚫" "○" "►" "◇")))
  :general
  (tyrant-def
    "aoa" 'org-agenda
    "aot" 'open-org-todos
    "aoj" 'org-journal-new-entry)
  (local-leader-def org-mode-map
    "s" 'org-schedule
    "a" 'org-agenda
    "A" 'org-archive-subtree))

(provide 'init-org)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-org.el ends here
