;; spell-check
(add-hook 'LaTeX-mode-hook 'flyspell-mode) ; enable spell checking 
;(add-hook 'LaTeX-mode-hook 'flyspell-buffer) ; check tex file upon opening

;; auto-fill-mode for latex mode
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)

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
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(setq exec-path (append '("/usr/local/bin") exec-path))
(setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))
(setq exec-path (append '("/usr/texbin") exec-path))

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
"/Users/tameling/.emacs.d/elpa/")
LaTeX-section-hook
'(LaTeX-section-heading
LaTeX-section-title
LaTeX-section-toc
LaTeX-section-section
LaTeX-section-label))
;; reftex equation reference without parenthesis
(setq reftex-label-alist
      '(("equation" 101 "eq:" "~\\ref{%s}" t (regexp "equations?" "eqs?\\." "eqn\\." "Gleichung\\(en\\)?" "Gl\\."))
        ))

;; add latex syntax highlighting for autoref reference
(setq font-latex-match-reference-keywords
  '(
    ("autoref" "[{")
    ("autorefs" "[{")))

;; bibtex formatting
(setq bibtex-align-at-equal-sign nil bibtex-text-indentation 0 bibtex-field-indentation 0 bibtex-style-indent-basic 0)
