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
  (if (any-null-stream? argstreams)
    the-empty-stream
    (cons-stream
      (apply proc (map stream-car argstreams))
      (apply new-stream-map
             (cons proc (map stream-cdr argstreams))))))

(define (any-null-stream? streams)
  (cond ((null? streams)
         #f)
        ((stream-null? (car streams))
         #t)
        (else (any-null-stream? (cdr streams)))))
