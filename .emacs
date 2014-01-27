;; load color theme
(load-theme 'manoj-dark t)
;; change emacs indentation style
(setq c-default-style "linux"
      c-basic-offset 2)
;; change tab to 2 spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)
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
 '(show-paren-mode t))

;; preview black on white
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(preview-reference-face ((t (:background "white" :foreground "black")))))

;; set an enviroment variable to the cluster path
(setenv "cluster" "/ssh:dt524872@cluster.rz.rwth-aachen.de:~/")

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

;; additional repositories for emacs packages
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
;; ido-mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
