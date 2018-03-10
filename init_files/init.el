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

;; don't show buffer list when opening more than 2 files
(setq inhibit-startup-buffer-menu t)

;set command key to control
(setq mac-command-modifier 'control) ; use 'meta for meta key

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
