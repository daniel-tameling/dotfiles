;; -*- lexical-binding: t -*-
;; change emacs indentation style
(setq c-default-style "linux")
;;(setq c-basic-offset 2)
;; change tab to 2 spaces
(setq-default indent-tabs-mode nil)
;;(setq-default tab-width 2)
;(setq indent-line-function 'insert-tab)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;; highlight FIXME, TODO ... in C like programs
(add-hook 'c-mode-common-hook 'set-my-highlighted-keywords)
(defun set-my-highlighted-keywords ()
  "highlight FIXME, TODO etc."
  (font-lock-add-keywords nil 
  '(("\\<\\(FIXME\\|TODO\\|XXX+\\|BUG\\)" 
     1 font-lock-warning-face prepend))))
;(set-face-underline 'font-lock-warning-face t)
(set-face-background 'font-lock-warning-face "blue4")
(set-face-foreground 'font-lock-warning-face "slate gray")

;; Fix iedit bug in Mac
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;; circumvent bug in python-mode
(setq python-shell-completion-native-enable nil)

;; ;; semantic
;; (add-hook 'c-mode-common-hook 'my-activate-semantic)
;; (add-hook 'python-mode-hook 'my-activate-semantic)
;; (defun my-activate-semantic ()
;;   "activate semantic for completion"
;;   (semantic-mode 1)
;;   (global-semantic-idle-scheduler-mode 1)
;;   (global-semantic-idle-completions-mode 1))

(setq lsp-keymap-prefix "C-c l")
(require 'lsp-mode)
(add-hook 'c-mode-common-hook #'lsp)
(with-eval-after-load 'lsp-mode
    (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))
;; (custom-set-faces
;;   '(flymake-errline ((((class color)) (:underline "red"))))
;;    '(flymake-warnline ((((class color)) (:underline "yellow")))))
;; flymake-show-diagnostics-buffer
;; lsp-find-references

(require 'company)
(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0.0)

;;;;(set-face-attribute 'company-tooltip nil :background "#d3d7cf" :foreground "#204a87")
;;(set-face-attribute 'company-tooltip nil :background "#d3d7cf" :foreground "#2e3436")
(set-face-attribute 'company-tooltip nil :background "#d3d7cf" :foreground "#242433")
;;(set-face-attribute 'company-tooltip-selection nil :background "#a1a39d" :foreground "#263236")
(set-face-attribute 'company-tooltip-selection nil :background "#bcbfb8" :foreground "#242433")
;;(set-face-attribute 'company-tooltip-common nil :foreground "#242433")
(set-face-attribute 'company-tooltip-common nil :foreground "#2e3446")
(set-face-attribute 'company-tooltip-annotation nil :foreground "#d96100")
(set-face-attribute 'company-tooltip-annotation-selection nil :foreground "#d96100")
(set-face-attribute 'company-scrollbar-fg nil :background "#666666" :foreground "#000000")
(set-face-attribute 'company-scrollbar-bg nil :background "#bbbbbb" :foreground "#000000")
