(load "./ex-2.68.scm")
(load "./ex-2.69.scm")

(print
 (encode
  '(GET A JOB
    SHA NA NA NA NA NA NA NA NA
    GET A JOB
    SHA NA NA NA NA NA NA NA NA
    WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
    SHA BOOM)
  (generate-huffman-tree (list (list 'A 2) (list 'BOOM 1) (list 'GET 2) (list 'JOB 2)
                               (list 'NA 16) (list 'SHA 3) (list 'YIP 9) (list 'WAH 1)))))

