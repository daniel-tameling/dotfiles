;; -*- lexical-binding: t -*-
;; load color theme
; (load-theme 'manoj-dark t)
(load-theme 'tango t)

;; insert matching closing parenthesis automatically
(electric-pair-mode t)

;; highlight matching parenthesis
(show-paren-mode t)

;; recognize one space after . as sentence end
(setq sentence-end-double-space nil)

;; activate mouse in terminal
(xterm-mouse-mode t)

;; don't indent previous line
(setq-default electric-indent-inhibit t)

;; don't show buffer list when opening more than 2 files
(setq inhibit-startup-buffer-menu t)

;set command key to control
(setq mac-command-modifier 'control) ; use 'meta for meta key

;; kill whole line
(global-set-key (kbd "M-k") 'kill-whole-line)

(menu-bar-mode -1)

(setq neo-theme 'arrow)

(which-key-mode)

;; to avoid ?? as line number in mode-line for long lines
;; (see https://emacs.stackexchange.com/questions/3824/what-piece-of-code-in-emacs-makes-line-number-mode-print-as-line-number-i/3827)
(setq line-number-display-limit-width 2000000)


;; increase font size for graphic displays
(if (display-graphic-p)
    (progn
      ;; if graphic
      (set-face-attribute 'default (selected-frame) :height 140)))

;; https://www.emacswiki.org/emacs/ToggleWindowSplit
(defun toggle-frame-split ()
  "If the frame is split vertically, split it horizontally or vice versa.
   Assumes that the frame is only split into two."
  (interactive)
  (unless (= (length (window-list)) 2) (error "Can only toggle a frame split in two"))
  (let ((split-vertically-p (window-combined-p)))
    (delete-window) ; closes current window
    (if split-vertically-p
        (split-window-horizontally)
      (split-window-vertically)) ; gives us a split with the other window twice
    (switch-to-buffer nil))) ; restore the original window in this part of the frame
(global-set-key (kbd "C-c s") 'toggle-frame-split)

;; https://www.emacswiki.org/emacs/TransposeWindows
(defun rotate-windows (arg)
  "Rotate your windows; use the prefix argument to rotate the other direction"
  (interactive "P")
  (if (not (> (count-windows) 1))
      (message "You can't rotate a single window!")
    (let* ((rotate-times (prefix-numeric-value arg))
           (direction (if (or (< rotate-times 0) (equal arg '(4)))
                          'reverse 'identity)))
      (dotimes (_ (abs rotate-times))
        (dotimes (i (- (count-windows) 1))
          (let* ((w1 (elt (funcall direction (window-list)) i))
                 (w2 (elt (funcall direction (window-list)) (+ i 1)))
                 (b1 (window-buffer w1))
                 (b2 (window-buffer w2))
                 (s1 (window-start w1))
                 (s2 (window-start w2))
                 (p1 (window-point w1))
                 (p2 (window-point w2)))
            (set-window-buffer-start-and-point w1 b2 s2 p2)
            (set-window-buffer-start-and-point w2 b1 s1 p1)))))))
(global-set-key (kbd "C-c r") 'rotate-windows)
(global-set-key (kbd "C-c e") (kbd "C-u -1 C-c r")) 

;; ibuffer
(require 'ibuf-ext)
(add-to-list 'ibuffer-never-show-predicates "^\\*")

;; Use human readable Size column instead of original one
(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0))=
)
   ((> (buffer-size) 100000) (format "%7.0fk" (/ (buffer-size) 1000.0)))
   ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
   (t (format "%8d" (buffer-size)))))

;; Modify the default ibuffer-formats
(setq ibuffer-formats
      '((mark modified read-only " "
              (name 18 18 :left :elide)
              " "
              (size-h 9 -1 :right)
              " "
              (mode 16 16 :left :elide)
              " "
              filename-and-process)))

;; https://emacs.stackexchange.com/questions/69670/forcing-buffers-whose-names-start-with-to-be-skipped-in-many-commands
(defun my-buffer-predicate (buffer)
  (let ((buffname (buffer-name buffer)))
    (not (or (string-prefix-p "*" buffname) 
             (string-prefix-p " *" buffname)))
  ))

(defun my-set-buffer-predicate ()
  (modify-all-frames-parameters
     (list
      (cons 'buffer-predicate #'my-buffer-predicate))))

(add-hook 'after-make-frame-functions 'my-set-buffer-predicate)
(my-set-buffer-predicate)
