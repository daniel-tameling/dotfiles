;; -*- lexical-binding: t -*-
;; function for inserting a for-statement
(define-skeleton my-for-statement
  "Insert a for () {...} skeleton."
  nil
  \n "for () {" \n > _ \n -2 "}" \n)
(define-skeleton c-for
  "Inserts a C for loop template."
  nil
  > "for (;;){" \n
  > _ \n
  "}" > \n
  )
;; function for inserting a printf-statement
(define-skeleton my-printf-statement
  "Insert a for () {...} skeleton."
  nil
  \n "printf(" > _ ");")
