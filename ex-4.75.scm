(load "./ch4-query.scm")

(define (uniquely-query exp) (car exp))
(define (stream-count stream)
  (define (count s c)
    (if (stream-null? s)
      c
      (stream-count (stream-cdr s) (+ c 1))))
  (count stream 0))
(define (singleton-stream? s)
  (cond ((stream-null? s) false)
        ((stream-null? (stream-cdr s)) true)
        (else false)))
(define (uniquely-asserted contents frame-stream)
  (stream-flatmap (lambda (frame)
                    (let ((result (qeval (uniquely-query contents)
                                         (singleton-stream frame))))
                      ; (if (= (stream-count result) 1)
                      (if (singleton-stream? result)
                        result
                        the-empty-stream)))
                  frame-stream))

(put 'unique 'qeval uniquely-asserted)

(define queries
  '(
    ; (unique (job ?x (computer wizard)))
    ; (unique (job ?x (computer programmer)))
    ; (and (job ?x ?j) (unique (job ?anyone ?j)))
    (and (supervisor ?p ?b)
         (unique (supervisor ?anyone ?b)))
  ))

(test-queries queries)
