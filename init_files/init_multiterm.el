;; -*- lexical-binding: t -*-
;; use zsh for multi-term
(setq multi-term-program "/bin/zsh")
;; cycle through terminals with M-[ and M-]
(add-hook 'term-mode-hook
          (lambda ()
            (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
            (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))))
