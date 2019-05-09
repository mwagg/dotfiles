;; init-evil.el --- Initialize ruby configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; Evil config.
;;

;;; Code:
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

(provide 'init-evil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-evil.el ends here
