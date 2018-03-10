;; -*- lexical-binding: t -*-
(require 'helm-config)
 
;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
     (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
     (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
     
     (setq helm-autoresize-max-height 30)
     (setq helm-autoresize-min-height 20)
     (helm-autoresize-mode 1))) 
 
(run-with-idle-timer 1 nil 'my-activate-helm-mode)
(defun my-activate-helm-mode ()
  ""
  (helm-mode t))

(setq helm-split-window-inside-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)
 
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c h o") 'helm-occur)
