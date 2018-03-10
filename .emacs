;; -*- lexical-binding: t -*-
;; garbage collection treshold to 20 MB during initialization
(setq default-gc-cons-threshold gc-cons-threshold)
(setq gc-cons-threshold 20000000)
(setq default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
;; reset garbage collection to 800 kB
(add-hook 'emacs-startup-hook 'my-restore-default-gc-threshold)
(defun my-restore-default-gc-threshold ()
  "Reset `gc-cons-threshold' to its default value."
  (setq gc-cons-threshold default-gc-cons-threshold)
  (setq file-name-handler-alist default-file-name-handler-alist))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex -synctex=1")
 '(org-agenda-files (quote ("~/dailytodo/todo.org")))
 '(package-selected-packages
   (quote
    (helm go-mode sr-speedbar multi-term lua-mode iedit git-commit auctex 2048-game)))
 '(reftex-ref-style-default-list (quote ("Default" "Hyperref")))
; '(send-mail-function (quote mailclient-send-it))
 '(sentence-end-double-space nil)
 '(show-paren-mode t))

;; additional repositories for emacs packages
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)
(setq package-enable-at-startup nil)

;; general stuff
(load "~/.emacs.d/init_files/init")

;; spell checking
(load "~/.emacs.d/init_files/init_spellcheck")

;; programming
(load "~/.emacs.d/init_files/init_programming")

;; skeletons
(load "~/.emacs.d/init_files/skeleton_defs")

;; latex
(load "~/.emacs.d/init_files/init_latex")

;; multi-term
(load "~/.emacs.d/init_files/init_multiterm")

;; ido-mode
(load "~/.emacs.d/init_files/init_ido")

;; helm-mode
(load "~/.emacs.d/init_files/init_helm")

;; mail, mu4e
(load "~/.emacs.d/init_files/init_mu4e")
