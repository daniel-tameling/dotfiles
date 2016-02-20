;; load color theme
(load-theme 'tango t)
;; change emacs indentation style
(setq c-default-style "linux"
      c-basic-offset 2)
;; change tab to 2 spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;; highlight FIXME, TODO ... in C like programs
(add-hook 'c-mode-common-hook
(lambda()
(font-lock-add-keywords nil 
'(("\\<\\(FIXME\\|TODO\\|XXX+\\|BUG\\)" 
1 font-lock-warning-face prepend))))) 
;(set-face-underline 'font-lock-warning-face t)
(set-face-background 'font-lock-warning-face "blue4")
(set-face-foreground 'font-lock-warning-face "slate gray")

;; set path to spell checking
;; iMac
(setq-default ispell-program-name "/usr/local/macports/bin/aspell")
;; Macbook Air
;;(setq-default ispell-program-name "/opt/local/bin/aspell")
;; enable spell checking automatically in tex files
(setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports
(add-hook 'LaTeX-mode-hook 'flyspell-mode) ; enable spell checking 
;(add-hook 'LaTeX-mode-hook 'flyspell-buffer) ; check tex file upon opening

;; auto-fill-mode for latex mode
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)

;set command key to control
(setq mac-command-modifier 'control) ; use 'meta for meta key

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex -synctex=1")
 '(preview-gs-options (quote ("-q" "-dNOSAFER" "-dNOPAUSE" "-DNOPLATFONTS" "-dPrinted" "-dTextAlphaBits=4" "-dGraphicsAlphaBits=4")))
 '(preview-preserve-indentation nil)
 '(reftex-ref-style-default-list (quote ("Default" "Hyperref")))
 '(send-mail-function (quote mailclient-send-it))
 '(sentence-end-double-space nil)
 '(show-paren-mode t))

;; preview black on white
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(preview-reference-face ((t (:background "white" :foreground "black")))))

;; set an enviroment variable to the cluster path
(setenv "cluster" "/sshx:dt524872@cluster.rz.rwth-aachen.de:~/")

;; use pdf in tex mode
(setq TeX-PDF-mode t)

;;  use Skim as pdf viewer
(setq TeX-view-program-list '(("Preview" "open %o")))
(setq TeX-view-program-list '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b")))
(setq TeX-view-program-selection '((output-pdf "Skim")))

(setq TeX-source-correlate-method 'synctex)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
;(server-start)

;; set path so that auctex finds tex and ghostscript
;; iMac
(setenv "PATH" (concat "/usr/local/macports/bin:" (getenv "PATH")))
(setq exec-path (append '("/usr/local/macports/bin") exec-path))
;; Macbook Air
;; (setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
;; (setq exec-path (append '("/usr/local/bin") exec-path))
;; (setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))
;; (setq exec-path (append '("/usr/texbin") exec-path))

;; RefTex Stuff
(setq reftex-plug-into-AUCTeX t) ;;reftex with list of refs
(autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase Mode" t)
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
;; (add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq LaTeX-eqnarray-label "eq"
LaTeX-equation-label "eq"
LaTeX-figure-label "fig"
LaTeX-table-label "tab"
LaTeX-myChapter-label "chap"
TeX-auto-save t
TeX-newline-function 'reindent-then-newline-and-indent
TeX-parse-self t
TeX-style-path
'("style/" "auto/"
"/usr/share/emacs21/site-lisp/auctex/style/"
"/var/lib/auctex/emacs21/"
"/usr/local/share/emacs/site-lisp/auctex/style/")
LaTeX-section-hook
'(LaTeX-section-heading
LaTeX-section-title
LaTeX-section-toc
LaTeX-section-section
LaTeX-section-label))
;; reftex equation reference without parenthesis
(setq reftex-label-alist
      '(("equation" 101 "eq:" "~\\ref{%s}" t (regexp "equations?" "eqs?\\." "eqn\\." "Gleichung\\(\
en\\)?" "Gl\\."))
        ))

;; add latex syntax highlighting for autoref reference
(setq font-latex-match-reference-keywords
  '(
    ("autoref" "[{")
    ("autorefs" "[{")))

;; bibtex formatting
(setq bibtex-align-at-equal-sign nil bibtex-text-indentation 0 bibtex-field-indentation 0 bibtex-style-indent-basic 0)

;; additional repositories for emacs packages
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

;; multi-term
(require 'multi-term)
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

;; git commit package
(require 'git-commit)

;; org mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '((dot . t))) ; this line activates dot

;; auto-complete
(require 'auto-complete)
; default config of auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; yasnippet
(require 'yasnippet)
;(yas-global-mode 1)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

;; Fix iedit bug in Mac
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;; semantic
(semantic-mode 1)
;; let's define a function which adds semantic as a suggestion backend to auto complete
;; and hook this function to c-mode-common-hook
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
  )
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
;; turn on automatic reparsing of open buffers in semantic
(global-semantic-idle-scheduler-mode 1)

;; increase font size for graphic displays
(if (display-graphic-p)
    (progn
      ;; if graphic
      (set-face-attribute 'default (selected-frame) :height 140)))

;; mail, mu4e
;; add the source shipped with mu to load-path
(add-to-list 'load-path (expand-file-name "/opt/local/share/emacs/site-lisp/mu4e"))

;; make sure emacs finds applications in /opt/local/bin
(setq exec-path (cons "/opt/local/bin" exec-path))

;; require mu4e
(require 'mu4e)

;; set path to maildir
(setq mu4e-maildir "~/gmail")

(setq mu4e-drafts-folder "/[Gmail]/.Drafts")
(setq mu4e-sent-folder   "/[Gmail]/.Sent Mail")
(setq mu4e-trash-folder  "/[Gmail]/.Trash")

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts
      '( ("/INBOX"               . ?i)
         ("/[Gmail]/.Sent Mail"   . ?s)
         ("/[Gmail]/.Trash"       . ?t)
         ("/[Gmail]/.Drafts"      . ?d)
         ("/[Gmail]/.All Mail"    . ?a)))

;; taken from mu4e page to define bookmarks
(add-to-list 'mu4e-bookmarks
             '("size:5M..500M"       "Big messages"     ?b))
;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "mbsync gmail")
;; tell mu4e to use w3m for html rendering
(setq mu4e-html2text-command "w3m -T text/html")

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
(setq mu4e-show-images t)

;; get mail every 5 min
(setq mu4e-update-interval 300
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
