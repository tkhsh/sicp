(require "./stream-lib")

(define (sign-change-detector current-value last-value)
  (define (sign v)
    (if (>= v 0)
      '+
      '-))
  (let ((cs (sign current-value))
        (ls (sign last-value)))
    (cond ((and (eq? ls '-) (eq? cs '+)) 1)
          ((and (eq? ls '+) (eq? cs '-)) -1)
          (else 0))))

(define (make-zero-crossings input-stream last-value)
  (cons-stream
   (sign-change-detector (stream-car input-stream) last-value)
   (make-zero-crossings (stream-cdr input-stream)
                        (stream-car input-stream))))

(define (list->stream list)
  (if (null? list)
    the-empty-stream
    (cons-stream (car list)
                 (list->stream (cdr list)))))

(define sense-data
  (list->stream '(1  2  1.5  1  0.5  -0.1  -2  -3  -2  -0.5  0.2  3  4)))

(define zero-crossings-alyssa (make-zero-crossings sense-data 0))

(define zero-crossings
  (stream-map sign-change-detector sense-data (cons-stream 0 sense-data)))

(define (main args)
  (display-stream (stream-take zero-crossings 12)))
