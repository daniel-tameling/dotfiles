;; -*- lexical-binding: t -*-
;; use zsh for multi-term
(setq multi-term-program "/bin/zsh")
(add-hook 'term-mode-hook 'set-my-multi-term-keybindigs)
(defun set-my-multi-term-keybindigs ()
    "cycle through terminals with M-[ and M-]"
    (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
    (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next)))
