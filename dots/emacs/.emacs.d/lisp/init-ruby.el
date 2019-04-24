;; init-ruby.el --- Initialize ruby configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; Ruby config.
;;

;;; Code:

(use-package ruby-mode
  :mode "\\.\\(rb\\|rake\\|\\gemspec\\|ru\\|\\(Rake\\|Gem\\|Guard\\|Vagrant\\)file\\)$"
  :interpreter "ruby"
  :config
  ;; Ruby refactoring helpers
  (use-package ruby-refactor
    :diminish ruby-refactor-mode
    :hook (ruby-mode . ruby-refactor-mode-launch))

  ;; bundler
  (use-package bundler
    :general
    (local-leader-def 'enh-ruby-mode-map
      "b" '(:ignore t :which-key "bundler")
      "bc" 'bundle-check
      "bi" 'bundle-install
      "bs" 'bundle-console
      "bu" 'bundle-update
      "bx" 'bundle-exec
      "bo" 'bundle-open ))

  ;; Run a Ruby process in a buffer
  (use-package inf-ruby
    :hook ((ruby-mode . inf-ruby-minor-mode)
           (compilation-filter . inf-ruby-auto-enter)))

  ;; Rubocop
  (use-package rubocop
    :hook (ruby-mode . rubocop-mode)
    :config
    (setq rubocop-prefer-system-executable t
          rubocop-autocorrect-on-save t)
    :general
    (local-leader-def 'ruby-mode-map
      "r" '(:ignore t :with-key "rubocop")
      "rd" 'rubocop-check-directory
      "rD" 'rubocop-autocorrect-directory
      "rf" 'rubocop-check-current-file
      "rF" 'rubocop-autocorrect-current-file
      "rp" 'rubocop-check-project
      "rP" 'rubocop-autocorrect-project))

  ;; RSpec
  (use-package rspec-mode
    :commands rspec-install-snippets
    :hook (dired-mode . rspec-dired-mode)
    :config
    (setq rspec-use-opts-file-when-available nil
          rspec-command-options "--format progress")
    (with-eval-after-load 'yasnippet
      (rspec-install-snippets))
    :general
    (local-leader-def 'ruby-mode-map
      "t" '(:ignore t :which-key "rspec")
      "ta" 'rspec-verify-all
      "tb" 'rspec-verify
      "tc" 'rspec-verify-continue
      "td" 'ruby/rspec-verify-directory
      "te" 'rspec-toggle-example-pendingness
      "tf" 'rspec-verify-method
      "tl" 'rspec-run-last-failed
      "tm" 'rspec-verify-matching
      "tr" 'rspec-rerun
      "tt" 'rspec-verify-single
      "t~" 'rspec-toggle-spec-and-target-find-example
      "t TAB" 'rspec-toggle-spec-and-target))

  ;; ruby-tools
  (use-package ruby-tools
    :hook (ruby-mode . ruby-tools-mode))

  ;; haml
  (use-package haml-mode
    :mode "\\.haml\\'")

  ;; projectile rails
  (use-package projectile-rails
    :hook (ruby-mode . projectile-rails-mode)
    :config
    (projectile-rails-global-mode 1)
    :general
    (local-leader-def 'ruby-mode-map
      "f" '(:ignore tr :which-key "find")
      "fm" #'projectile-rails-find-model
      "fc" #'projectile-rails-find-controller
      "fv" #'projectile-rails-find-view
      "fs" #'projectile-rails-find-spec
      "fi" #'projectile-rails-find-initializer
      "fr" #'projectile-rails-goto-routes
      "g" #'projectile-rails-generate)))

;; YAML mode
(use-package yaml-mode)

(provide 'init-ruby)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-ruby.el ends here
