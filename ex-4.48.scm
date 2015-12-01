(load "./natural_language.scm")

(define exps
  '(
    ; support adjectives
    (define adjectives '(adj explicit cute cool hot))

    (define (parse-adjective-noun-phrase)
      (define (maybe-extend adjective-phase)
        (amb adjective-phase
             (list 'adjectives
                   adjective-phase
                   (parse-word adjectives))))
      (list 'adj-noun-phrase
            (parse-word articles)
            (maybe-extend (parse-word adjectives))
            (parse-word nouns)))

    (define (parse-subj-noun-phrase)
      (amb (parse-simple-noun-phrase)
           (parse-adjective-noun-phrase)))

    (define (parse-noun-phrase)
      (define (maybe-extend noun-phrase)
        (amb noun-phrase
             (maybe-extend
               (list 'noun-phrase
                     noun-phrase
                     (parse-prepositional-phrase)))))
      (maybe-extend (parse-subj-noun-phrase)))

    ; support compound sentences with conjunctions
    (define conjunctions '(conj and or but although))

    (define (parse-simple-sentence)
      (list 'simple-sentence
            (parse-noun-phrase)
            (parse-verb-phrase)))

    (define (parse-sentence)
      (define (maybe-extend sentence)
        (amb sentence
             (maybe-extend
               (list 'compound-sentences
                     sentence
                     (parse-word conjunctions)
                     (parse-sentence)))))
      (maybe-extend (parse-simple-sentence)))

    (parse '(the cute hot cat eats))
    ; (parse '(the student with the cute cat sleeps in the hot class))

    ; support compound sentences with coordinating conjunctions
    ; (parse '(the cute cat eats and the hot cat eats))
    )
  )
(pre-eval-driver-loop exps)
