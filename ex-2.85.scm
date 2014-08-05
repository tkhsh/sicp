(define (project x)
  (let ((proc (get 'project (list (type-tag x)))))
    (if proc
      (proc x)
      #f)))

(put 'project '(complex)
     (lambda (c)
       (make-real (real-part c))))

(put 'project '(real)
     (lambda (r) round))

(put 'project '(rational)
     (lambda (r)
       (round
         (/ (numer r)
            (denom r)))))

; (define (drop x)
;   (if (get 'project (list (type-tag x)))
;     (let ((px (project x)))
;       (if (equ? x (raise px))
;         (drop px)
;         x))
;     x))

(define (drop x)
  (let ((px (project x)))
    (if (and px
             (equ? x (raise px)))
      (drop px)
      x)))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (drop
          (apply proc (map contents args)))
        (apply-generic
          op
          (apply raise-args-one-step args))))))

(define (apply-generic op . args)
  (drop (apply apply-generic-2.84 (cons op args))))

