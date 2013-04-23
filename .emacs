;; load color theme
(load-theme 'manoj-dark t)
;; change emacs indentation style
(setq c-default-style "linux"
      c-basic-offset 4)
;; change tab to 4 spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
;; set path to spell checking
(setq-default ispell-program-name "/usr/local/macports/bin/aspell")
;; enable spell checking automatically in tex files
(setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports
(add-hook 'LaTeX-mode-hook 'flyspell-mode) ; enable spell checking 
;(add-hook 'LaTeX-mode-hook 'flyspell-buffer) ; check tex file upon opening

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(send-mail-function (quote mailclient-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; set an enviroment variable to the cluster path
(setenv "cluster" "/ssh:dt524872@cluster.rz.rwth-aachen.de:~/")

;; use pdf in tex mode
(setq TeX-PDF-mode t)

;;  use preview as pdf viewer
(setq TeX-view-program-list
      '(("Preview" "/Applications/Preview.app/Contents/MacOS/Preview %o")))
(setq TeX-view-program-selection '((output-pdf "Preview")))


;; set path so that auctex finds tex and ghostscript
(setenv "PATH" (concat "/usr/local/macports/bin:" (getenv "PATH")))
(setq exec-path (append '("/usr/local/macports/bin") exec-path))

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
