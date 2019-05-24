;; init-python.el --- Initialize python. configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; Python config.
;;

;;; Code:

(use-package elpy
  :config
  (use-package highlight-indentation)
  (use-package company-jedi
    :config
    (add-hook 'python-mode-hook (lambda () (add-to-list 'company-backends 'company-jedi)))))

(provide 'init-python)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-python.el ends here
