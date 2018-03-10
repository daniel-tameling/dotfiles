;; -*- lexical-binding: t -*-
;; garbage collection treshold to 20 MB during initialization
(setq default-gc-cons-threshold gc-cons-threshold)
(setq gc-cons-threshold 20000000)
;; reset garbage collection to 800 kB
(add-hook 'emacs-startup-hook 'my/restore-gc-threshold)
(defun my/restore-gc-threshold ()
  "Reset `gc-cons-threshold' to its default value."
  (setq gc-cons-threshold default-gc-cons-threshold))

;; load color theme
; (load-theme 'manoj-dark t)
(load-theme 'tango t)

;; change faces for warnings
(set-face-background 'font-lock-warning-face "blue4")
(set-face-foreground 'font-lock-warning-face "slate gray")

;; set path to spell checking
(setq-default ispell-program-name "/opt/local/bin/aspell")
;; enable spell checking automatically in tex files
(setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports

;set command key to control
(setq mac-command-modifier 'control) ; use 'meta for meta key

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(send-mail-function (quote mailclient-send-it))
 '(sentence-end-double-space nil)
 '(show-paren-mode t))

;; additional repositories for emacs packages
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)
(setq package-initialize-at-startup nil)

;; git commit package
;; (require 'git-commit)
;; (autoload 'global-git-commit-mode "git-commit" "Minor mode for git commit messages" t)
(global-git-commit-mode)
(add-hook 'git-commit-mode-hook 'turn-on-flyspell)

;; multi-term
;; use zsh for multi-term
(setq multi-term-program "/bin/zsh")
;; cycle through terminals with M-[ and M-]
(add-hook 'term-mode-hook
          (lambda ()
            (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
            (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))))

;; ido-mode
(setq ido-enable-flex-matching t)
(setq ido-auto-merge-work-directories-length -1)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-max-dir-file-cache      10)
(setq ido-max-work-directory-list 20)
(setq ido-max-work-file-list      10) 

;; ido order and extension excluded from completion in emacs
(setq ido-file-extensions-order '(".tex" ".bib" ".cpp" ".h" ".py" ".emacs"))
(setq ido-ignore-extensions t)
(setq completion-ignored-extensions '("synctex.gz" "_.tex" "_.log" "_.prv/" "auto/" ".DS_Store"))

;; increase font size for graphic displays
(if (display-graphic-p)
    (progn
      ;; if graphic
      (set-face-attribute 'default (selected-frame) :height 140)))

