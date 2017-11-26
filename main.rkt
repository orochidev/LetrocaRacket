#lang racket/base
(require dyoo-while-loop)
(require racket/mpair)
(require racket/string)
(require racket/list)
(require racket/file)
(require racket/block)
(require racket/format)

(define fase 1)
(define pontos 0)
(define entrada (file->lines "palavra1.txt"))
(define palavra (last entrada))
(define embaralhada (string-replace (string-trim (string-normalize-spaces (string-join ( shuffle (map string (string->list palavra)))))) " " ""))
(define opcoes entrada)
(define acertadas (list))

(display  "Bem-vindo ao Letroca do Negrão e do Chris!\n")

(define (append-last lst x)
  (append lst (list x)))


(while #t
       (display "\n================================================\n")
       (display  "A palavra embaralhada está abaixo! Tente adivinhar quais palavras podem ser geradas com ela!\n")
       (display embaralhada)
       (display "\nPontos: ")
       (display pontos)
       (display "\n================================================\n")
       (display  "Palavras que faltam acertar: \n")
       (for ([i opcoes ])
         (if (member i acertadas)
             (display i)
             (display (make-string (string-length i) #\z))

             )
             (display "\n")
             )
(display  "Digite a palavra que você acha que é: \n")

(define tentativa (read-line (current-input-port) 'any))
(if (member tentativa opcoes)
    (block(display "Parabéns, você acertou!\n")
          (set! pontos (+ pontos 1))
          (set! acertadas (append-last acertadas tentativa)))
    (block (display "Que pena, você errou!\n")))
(when (= (length acertadas) (length opcoes)) (block
(set! fase (+ fase 1))
(if (> fase 5) (block (display "Parabéns, você venceu!") (exit)) (block
(set! entrada (file->lines (string-append "palavra" (~v fase) ".txt")))
(set! palavra (last entrada))
(set! embaralhada (string-replace (string-trim (string-normalize-spaces (string-join ( shuffle (map string (string->list palavra)))))) " " ""))
(set! opcoes entrada)
(set! acertadas (list))))))

)