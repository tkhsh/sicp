(define (make-monitored f)
  (let ((c 0))
    (define (dispatch m)
      (cond ((eq? m 'how-many-call?) c)
            ((eq? m 'reset-count) (set! c 0))
            (else (set! c (+ c 1))
                  (f m))))
    dispatch))

(define s (make-monitored sqrt))
(print (s 100))
(print (s 'how-many-call?))

