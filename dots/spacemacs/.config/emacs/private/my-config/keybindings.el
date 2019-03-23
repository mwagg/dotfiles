(define-key evil-normal-state-map (kbd "C-h") #'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") #'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") #'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") #'evil-window-right)

;; global font scaling
(global-set-key (kbd "s-+")
                '(lambda () (interactive) (global-text-scale-adjust 1)))

(global-set-key (kbd "s--")
                '(lambda () (interactive) (global-text-scale-adjust -1)))
