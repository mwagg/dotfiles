;; init-reason.el --- Initialize reason configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; ReasomML config.
;;

;;; Code:
(use-package reason-mode
  :config
  (defun shell-cmd (cmd)
    "Returns the stdout output of a shell command or nil if the command returned
     an error"
    (car (ignore-errors (apply 'process-lines (split-string cmd)))))
  (let* ((refmt-bin (shell-cmd "which refmt")))
    (when refmt-bin
      (setq refmt-command refmt-bin)))
  (add-hook
   'reason-mode-hook
   (lambda ()
     (add-hook 'before-save-hook 'refmt-before-save nil t)
     (setq-local merlin-command (shell-cmd "which ocamlmerlin"))
     (merlin-mode))))

(provide 'init-reason)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-reason.el ends here
