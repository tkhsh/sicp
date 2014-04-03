(load "./ex-2.56.scm")

(define (augend s)
  (if (null? (cdddr s))
      (caddr s)
      (cons '+ (cddr s))))

(define (multiplicand p)
  (if (null? (cdddr p))
      (caddr p)
      (cons '* (cddr p))))
; (print (deriv '(* x y (+ x 3)) 'x))
