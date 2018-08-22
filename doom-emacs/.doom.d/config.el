;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; lang/org
(setq org-directory "~/Dropbox/org"
      org-agenda-files (list "~/Dropbox/org/todos.org"
                                 "~/Dropbox/org/projects.org")
      org-capture-templates '(
                              ("t" "Todo" entry (file+headline "~/Dropbox/org/todos.org" "To be prioritised")
                               "* TODO %?\n%i"))
      org-refile-targets '((nil :level . 2)))

;; relative line numbers
(setq display-line-numbers-type 'relative)

;; themes
(after! doom-themes
  (load-theme 'doom-nord t))

(after! markdown-mode
  (setq markdown-command "/usr/bin/marked"))


;; terraform
(defun configure-terraform-mode ()
  (terraform-format-on-save-mode))
(after! terraform-mode
  (add-hook 'terraform-mode-hook 'configure-terraform-mode))

;; autosave when losing focus
(add-hook 'focus-out-hook
            (defun save-current-buffer-if-needed ()
              (interactive)
              (when (and (buffer-file-name) (buffer-modified-p))
                (save-buffer))))
