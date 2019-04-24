;;; funcs --- funcs used in my Emacs setup
;;; Commentary:
;;; Useful functions for Emacs
;;; Code:

(defun save-current-buffer-if-needed ()
  "Save the current buffer if it has an unsaved change."
  (interactive)
  (when (and (buffer-file-name) (buffer-modified-p)) (save-buffer)))

(defun find-user-init-file ()
  "Edit the `user-init-file', in same window."
  (interactive)
  (find-file user-init-file))

(defun alternate-buffer (&optional window)
  "Switch back and forth between current and last buffer in the current WINDOW."
  (interactive)
  (let ((current-buffer (window-buffer window)))
    ;; if no window is found in the windows history, `switch-to-buffer' will
    ;; default to calling `other-buffer'.
    (switch-to-buffer
     (cl-find-if (lambda (buffer)
                   (not (eq buffer current-buffer)))
                 (mapcar #'car (window-prev-buffers window)))
     nil t)))

(defun ranger-project-root-dir ()
  "Open ranger using the project root, using projectile."
  (interactive)
  (let ((project-dir (ignore-errors (projectile-project-root)))
        (file-name (buffer-file-name)))
    (progn
      (if project-dir
          (ranger project-dir)))))

(defun open-org-todos ()
  "Open the todos.org file."
  (interactive)
  (find-file "~/Sync/org/todos.org"))

(defun insert-space-in-brackets ()
  "Automatically insert a space when inserting braces."
  (interactive)
  (if (and (looking-at "}")
	   (looking-back "{"))
      (progn (insert "  ")
	     (backward-char))
    (insert " ")))

(defun set-eyebrowse-workspace-name-to-project ()
  "Set the eyebrowse workspace name to the current project name."
  (eyebrowse-rename-window-config (eyebrowse--get 'current-slot) (projectile-project-name)))

(defun open-terminal ()
  "Open default terminal emulator in the current directory."
  (interactive)
  (start-process "terminal" nil "termite"))

(defun open-terminal-in-project-root ()
  "Open default terminal in the project root."
  (interactive)
  (let ((default-directory (projectile-project-root)))
    (open-terminal)))

(provide 'funcs)
;;; funcs.el ends here
