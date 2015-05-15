; pull request test

(define (make-table)
  (let ((local-table (list #f)))
    (define (lookup keys table)
      (if (null? keys)
        (car table)
        (let ((record (assoc (car keys) (cdr table))))
          (if record
            (lookup (cdr keys) (cdr record))
            #f))))

    (define (insert! keys value table)
      (if (null? keys)
        (set-car! table value)
        (let ((record (assoc (car keys) (cdr table))))
          (if record
            (insert! (cdr keys) value (cdr record))
            (let* ((t (make-table))
                   (r (cons (car keys) t)))
              (set-cdr! table (cons r (cdr table)))
              (insert! (cdr keys) value t)))))
      (define (dispatch m)
        (cond ((eq? m 'lookup-proc) lookup)
              ((eq? m 'insert-proc!) insert!)
              (else (error "Unknown operation -- TABLE" m))))
      dispatch))

