;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Source Code Pro" :size 12))

;; Font size adjustment
(defun adjust-font-size (frame)
  (let* ((attrs (frame-monitor-attributes))
       (dimensions (cdr (nth 2 attrs)))
       (width (nth 3 dimensions))
       (size (cond
              ((> width 1900) 20)
              (t 12))))
  (set-frame-font (format "Source Code Pro %s" size))))
(add-hook 'window-size-change-functions #'adjust-font-size)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `us e-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; terraform
(add-hook! terraform-mode
  (terraform-format-on-save-mode t))

;; make the right alt key useful for #, ¢ etc.
(setq ns-right-alternate-modifier (quote none))

;; easier window movement
(map! :n "C-h" #'evil-window-left
      :n "C-j" #'evil-window-down
      :n "C-k" #'evil-window-up
      :n "C-l" #'evil-window-right)

(use-package! sqlformat
  :commands sqlformat-on-save-mode sqlformatbuffer
  :init
  (add-hook 'sql-mode-hook #'sqlformat-on-save-mode)
  :config
  (setq sqlformat-command 'pgformatter
        sqlformat-args '("-s2" "-g")))

(after! elm-mode
  (add-hook 'elm-mode-hook #'elm-format-on-save-mode))

(after! projectile
  (setq projectile-project-root-files
        (append projectile-project-root-files-bottom-up
                projectile-project-root-files)
        projectile-project-root-files-bottom-up nil))

(use-package! jest
  :after (:any js2-mode typescript-mode)
  :config
  (setq jest-executable "yarn test")
  :hook ((js2-mode . jest-minor-mode) (typescript-mode . jest-minor-mode)))
