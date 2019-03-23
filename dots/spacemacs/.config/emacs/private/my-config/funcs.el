(defun my-config/save-current-buffer-if-needed ()
  "Save the current buffer if it has unsaved changes"
  (interactive)
  (when (and (buffer-file-name) (buffer-modified-p)) (save-buffer)))

(defun global-text-scale-adjust (inc) (interactive)
       (text-scale-set 1)
       (kill-local-variable 'text-scale-mode-amount)
       (setq-default text-scale-mode-amount (+ text-scale-mode-amount inc))
       (global-text-scale-mode 1))

(defconst my-config/ligature-codepoints '(("/=" . "	")
                                          ("->" . "	")
                                          ("->>" . "	")
                                          ("|>" . "	")
                                          ("<|" . "	")))

(defun my-config/setup-ligatures ()
  (let* ((fira-code-ligatures my-config/ligature-codepoints))
    (setq prettify-symbols-alist
          (append fira-code-ligatures prettify-symbols-alist))
    (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")
    (prettify-symbols-mode)))

(defun my-config/insert-space ()
  (interactive)
  (if (and (looking-at "}")
           (looking-back "{"))
      (progn (insert "  ")
             (backward-char))
    (insert " ")))
