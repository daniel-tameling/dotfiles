;; -*- lexical-binding: t -*-
(setq ido-enable-flex-matching t)
(setq ido-auto-merge-work-directories-length -1)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-max-dir-file-cache      10)
(setq ido-max-work-directory-list 20)
(setq ido-max-work-file-list      10) 

;; ido order and extension excluded from completion in emacs
(setq ido-file-extensions-order '(".tex" ".bib" ".cpp" ".h" ".py" ".emacs"))
(setq completion-ignored-extensions '("synctex.gz" "_.tex" "_.log" "_.prv/" "auto/" ".DS_Store"))
(setq ido-ignore-extensions t)
(setq ido-ignore-buffers '("\\` " "^\*"))
(setq confirm-nonexistent-file-or-buffer nil)
