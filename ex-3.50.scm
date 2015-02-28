(provide "./ex-3.50.scm")
(require "./stream-lib.scm")

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
  (if (null? list)
    #f
    (or (pred (car list))
        (any pred (cdr list)))))
