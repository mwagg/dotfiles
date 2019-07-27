;; init-magit.el --- Initialize magit configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; Magit config
;;

;;; Code:
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

(provide 'init-magit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-magit.el ends here
