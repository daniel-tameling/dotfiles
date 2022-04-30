;; -*- lexical-binding: t -*-
;; garbage collection treshold to 20 MB during initialization
(setq default-gc-cons-threshold gc-cons-threshold)
(setq gc-cons-threshold 20000000)
(setq default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
;; reset garbage collection to 800 kB
(add-hook 'emacs-startup-hook 'my/restore-gc-threshold)
(defun my/restore-gc-threshold ()
  "Reset `gc-cons-threshold' to its default value."
  (setq gc-cons-threshold default-gc-cons-threshold)
  (setq file-name-handler-alist default-file-name-handler-alist))

;; load color theme
; (load-theme 'manoj-dark t)
(load-theme 'tango t)

;; change faces for warnings
(set-face-background 'font-lock-warning-face "blue4")
(set-face-foreground 'font-lock-warning-face "slate gray")

(load "~/.emacs.d/init_files/init_spellcheck")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(sentence-end-double-space nil)
 '(show-paren-mode t)
 )

;; additional repositories for emacs packages
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)
(setq package-initialize-at-startup nil)

;; don't create *~ files when composing messages
(setq make-backup-files nil)

(defun my-text-mode-hook ()
  (auto-fill-mode t)
  (flyspell-mode t))

(add-hook 'text-mode-hook 'my-text-mode-hook)
;; (add-to-list 'auto-mode-alist '("neomutt-.*" . text-mode))
