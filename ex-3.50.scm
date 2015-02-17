(load "./stream-lib.scm")

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

; improved
(define (new-stream-map proc . argstreams)
  (if (any stream-null? argstreams)
    the-empty-stream
    (cons-stream
      (apply proc (map stream-car argstreams))
      (apply new-stream-map
             (cons proc (map stream-cdr argstreams))))))

(define (any pred list)
  (cond ((null? list)
         #f)
        ((pred (car list))
         (pred (car list)))
        (else (any pred (cdr list)))))
