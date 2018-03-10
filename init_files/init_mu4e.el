;; -*- lexical-binding: t -*-
;; add the source shipped with mu to load-path
(add-to-list 'load-path (expand-file-name "/opt/local/share/emacs/site-lisp/mu4e"))

;; make sure emacs finds applications in /opt/local/bin
(setq exec-path (cons "/opt/local/bin" exec-path))

;; require mu4e
(require 'mu4e)

;; set path to maildir
(setq mu4e-maildir "~/myMail/gmail")

(setq mu4e-drafts-folder "/[Gmail]/Drafts")
(setq mu4e-sent-folder   "/[Gmail]/Sent Mail")
(setq mu4e-trash-folder  "/[Gmail]/Trash")

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''

(setq mu4e-maildir-shortcuts
      '( ("/INBOX"               . ?i)
         ("/[Gmail]/Sent Mail"   . ?s)
         ("/[Gmail]/Trash"       . ?t)
         ("/[Gmail]/Drafts"      . ?d)))

;; taken from mu4e page to define bookmarks
(add-to-list 'mu4e-bookmarks
             '("size:5M..500M"       "Big messages"     ?b))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "mbsync gmail")

;; tell mu4e to use w3m for html rendering
(setq mu4e-html2text-command "w3m -T text/html")

;; required for mbsync to get UIDs right
(setq mu4e-change-filenames-when-moving t)

;; adjust lines of header shown
(setq mu4e-headers-visible-lines 12)

;; something about ourselves
(setq
 user-mail-address "johndoe@gmail.com"
 user-full-name  "John Doe"
 mu4e-compose-signature
 (concat
  "My signature text\n"
  "\n"))

;; dir to save attachments to
(setq mu4e-attachment-dir  "~/Downloads")

;; ;; sending mail -- replace USERNAME with your gmail username
;; ;; also, make sure the gnutls command line utils are installed
;; ;; package 'gnutls-bin' in Debian/Ubuntu

;; (require 'smtpmail)
;; (setq message-send-mail-function 'smtpmail-send-it
;;       starttls-use-gnutls t
;;       smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials
;;       '(("smtp.gmail.com" 587 "johndoe@gmail.com" nil))
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587)

;; ;; alternatively, for emacs-24 you can use:
;; ;;(setq message-send-mail-function 'smtpmail-send-it
;; ;;     smtpmail-stream-type 'starttls
;; ;;     smtpmail-default-smtp-server "smtp.gmail.com"
;; ;;     smtpmail-smtp-server "smtp.gmail.com"
;; ;;     smtpmail-smtp-service 587)

;; sending mail with msmtp
;; use msmtp
(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "/opt/local/bin/msmtp")
;; for multiple accounts
;; tell msmtp to choose the SMTP server according to the from field in the outgoing email
(setq message-sendmail-extra-arguments '("--read-envelope-from"))
(setq message-sendmail-f-is-evil 't)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

;; show images
(setq mu4e-view-show-images t)

;; get mail every 10 min
(setq mu4e-update-interval 600
      mu4e-headers-auto-update t)

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; spell check
(add-hook 'mu4e-compose-mode-hook
          (defun my-do-compose-stuff ()
            "My settings for message composition."
            (set-fill-column 72)
            (flyspell-mode)))

;; change header
(setq mu4e-headers-fields '((:human-date . 20)
                            (:size . 9)
                            (:flags . 6)
                            (:from . 22)
                            (:mailing-list . 10)
                            (:subject)))
;; date format header
(setq mu4e-headers-date-format "%a %d.%m.%y %R")
;; date format message view
(setq mu4e-view-date-format "%T %a %B %d, %Y")
