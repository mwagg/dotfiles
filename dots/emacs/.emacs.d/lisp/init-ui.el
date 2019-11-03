;; init-ui.el --- Initialisation file for Emacs  -*- lexical-binding: t; -*-

;;; Commentary:
;;; Setup interface config.

;;; Code:

;; setup fonts
(let ((font-name (if (string-equal system-type "darwin")
                    "Source Code Pro 12"
                  "SourceCodePro-12")))
  (set-face-attribute 'default nil :font font-name )
  (set-frame-font font-name nil t))
(set-face-attribute 'fixed-pitch nil :family "Iosevka")
(set-face-attribute 'variable-pitch nil :family "Libre Baskerville")

(use-package all-the-icons
  :config
  (unless (member "all-the-icons" (font-family-list))
    (all-the-icons-install-fonts t)))

;; mode line
(setq auto-revert-check-vc-info t)
(setq-default mode-line-format (list
                                ;; Check the buffer status and display its status
                                '((:eval
                                   (cond
                                    (buffer-read-only
                                     (propertize " ⚿ " 'face '(:foreground "orange" :weight 'bold)))

                                    ((buffer-modified-p)
                                     (propertize " * " 'face '(:foreground "red")))
                                    ((not (buffer-modified-p))
                                     (propertize " * " 'face '(:foreground "gray85"))))))
                                ;; Use all-the-icons to display the icon of current major mode
                                '(:eval (propertize (all-the-icons-icon-for-mode major-mode
                                                                                 :height (/ all-the-icons-scale-factor 1.8)
                                                                                 :v-adjust -0.02)))
                                ;; Show the file name with full path
                                " %f "
                                ;; Show the current position of the cursor in buffer
                                'mode-line-position
                                ;; Show the current major mode name
                                "[" 'mode-name "] "
                                ;; Check if the buffer is in any version control system, if yes, show the branch
                                '(:eval
                                  (if vc-mode
                                      (let* ((noback (replace-regexp-in-string
                                                      (format "^ %s" (vc-backend buffer-file-name)) " " vc-mode))
                                             (face (cond ((string-match "^ -" noback) 'mode-line-vc)
                                                         ((string-match "^ [:@]" noback) 'mode-line-vc-edit)
                                                         ((string-match "^ [!\\?]" noback) 'mode-line-vc-modified))))
                                        (format "[git:%s]" (substring noback 2)))))))

;; global text scaling
(define-globalized-minor-mode
  global-text-scale-mode
  text-scale-mode
  (lambda () (text-scale-mode 1)))

(defun global-text-scale-adjust (inc)
  "Add (INC) to the gloabl text scale."
  (interactive)
  (text-scale-set 1)
  (kill-local-variable 'text-scale-mode-amount)
  (setq-default text-scale-mode-amount (+ text-scale-mode-amount inc))
  (global-text-scale-mode 1))

(add-hook 'which-key-mode-hook (lambda ()
                                 (general-def
                                   "s-+" '(lambda ()
                                            (interactive)
                                            (global-text-scale-adjust 1))
                                   "s--" '(lambda ()
                                            (interactive)
                                            (global-text-scale-adjust -1)))))

;; themes
(use-package doom-themes
  :config
  (load-theme 'doom-nord t))
(add-hook 'general-override-mode-hook (lambda ()
                                        (tyrant-def
                                          ;; theme settings
                                          "t" '(:ignore t :which-key "themes")
                                          "tt" 'counsel-load-theme)))

(provide 'init-ui)

;;; init-ui.el ends here
