(require "./stream-lib")

(define (generate-random-numbers request-stream)
  (define (go r-stream random-seed)
    (if (stream-null? r-stream)
      the-empty-stream
      (let ((r (stream-car r-stream))
            (rand-next (rand-update random-seed)))
        (cond ((eq? r 'generate)
               (cons-stream random-seed
                            (go (stream-cdr r-stream) rand-next)))
              ((eq? r 'reset)
               (cons-stream random-init
                            (go (stream-cdr r-stream) (rand-update random-init))))
              (else (print "error - rand: invalid request"))))))
  (go request-stream random-init))

(define (main args)
  (define rs (list->stream '(generate
                             generate
                             generate
                             generate
                             reset
                             generate
                             generate
                             generate
                             generate)))
  (display-stream (generate-random-numbers rs)))
