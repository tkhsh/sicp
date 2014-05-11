(load "./sec-2.3.4.scm")
(load "./ex-2.67.scm")

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (cond ((leaf? tree) '())
        ((memq symbol (symbols (left-branch tree)))
         (cons 0 (encode-symbol symbol (left-branch tree))))
        ((memq symbol (symbols (right-branch tree)))
         (cons 1(encode-symbol symbol (right-branch tree))))
        (else (error "symbol is not found" symbol))))

(print (encode '(A D A B B C A) sample-tree))

