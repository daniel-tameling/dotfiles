;; -*- lexical-binding: t -*-
;; add the source shipped with notmuch to load-path
(add-to-list 'load-path (expand-file-name "~/installed/notmuch/share/emacs/site-lisp"))

;; make sure emacs finds applications in /opt/local/bin
(setq exec-path (cons "~/installed/notmuch/bin" exec-path))

;;(require 'notmuch)
(unless
    (fboundp 'notmuch)
    (autoload #'notmuch "notmuch" nil t))

(setq notmuch-hello-hide-tags (quote ("draft" "flagged" "passed" "replied" "signed")))
(setq notmuch-hello-thousands-separator "")
(setq notmuch-show-all-tags-list t)
(setq notmuch-search-oldest-first nil)
