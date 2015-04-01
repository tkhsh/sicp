(require "./stream-lib")

; a
(define (integrate-series power-series-stream)
  (mul-streams power-series-stream
               (stream-map (lambda (x) (/ 1 x))
                           integers)))

; b
; exp-seriesは、exp-seriesの積分に定数1をconsすることで作れる
; integrate-seriesは、引数power-series-streamのn番目の要素からn+1番目の要素を作ることができる
; exp-seriesの最初の要素は1なので、(integrate-series exp-series)は2番目の要素、3番目の要素...
; という風にexp-se
(define exp-series
  (cons-stream 1 (integrate-series exp-series)))
; 微分を使う方法はうまくいかない。streamの性質上？
; (define (derivative-series series-stream)
;   (mul-streams series-stream integers))
;
(define cosine-series
  (cons-stream 1 (scale-stream (integrate-series sine-series) -1)))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))

(define (main args)
  (display-stream (stream-take (integrate-series (scale-stream ones 3)) 5))
  (newline)
  (display-stream (stream-take cosine-series 5))
  (newline)
  (display-stream (stream-take sine-series 6)))
