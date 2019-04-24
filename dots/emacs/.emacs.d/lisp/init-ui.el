;; init-ui.el --- Initialisation file for Emacs  -*- lexical-binding: t; -*-

;;; Commentary:
;;; Setup interface config.

;;; Code:

;; setup fonts
(set-face-attribute 'default nil :font "mononoki-12" )
(set-frame-font "mononoki-12" nil t)
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

(provide 'init-ui)

;;; init-ui.el ends here
