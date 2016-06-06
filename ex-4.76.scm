(load "./ch4-query.scm")

(define (conjoin conjuncts frame-stream)
  (if (empty-conjunction? conjuncts)
    frame-stream
    (stream-flatmap (lambda (f1)
                      (stream-flatmap (lambda (f2)
                                        (let ((result (merge-frames f1 f2)))
                                          (if (eq? result 'failed)
                                            the-empty-stream
                                            (singleton-stream result))))
                                      (conjoin (rest-conjuncts conjuncts) frame-stream)))
                    (qeval (first-conjunct conjuncts) frame-stream))))

(define (merge-frames f1 f2)
  (define (go f1 f2 result)
    (if (null? f1)
      (append result f2)
      (let* ((binding1 (car f1))
             (var1 (car binding1))
             (val1 (cadr binding1))
             (binding2 (binding-in-frame var1 f2)))
        (if binding2
          (if (eq? val1 (cadr binding2))
            (go (cdr f1) f2 result) ; f2にあるbindingが結果に含まれる
            'failed)
          (go (cdr f1) f2 (cons val1 result))))))
  (if (null? f2)
    f1
    (go f1 f2 '())))

(define queries
  '(
    (and (job ?x ?j) (address ?x (Cambridge (Ames Street) 3)))
  ))

(test-queries queries)
