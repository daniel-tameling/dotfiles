;; -*- lexical-binding: t -*-
;; change emacs indentation style
(setq c-default-style "linux"
      c-basic-offset 2)
;; change tab to 2 spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
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

;; semantic
(add-hook 'c-mode-common-hook 'my-activate-semantic)
(add-hook 'python-mode-hook 'my-activate-semantic)
(defun my-activate-semantic ()
  "activate semantic for completion"
  (semantic-mode 1)
  (global-semantic-idle-scheduler-mode 1)
  (global-semantic-idle-completions-mode 1))
