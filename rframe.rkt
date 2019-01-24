#lang racket/gui

;; Author: Patrick Falcon M00668092
;; Easier method for writing simple graphical user interfaces

(require "engine.rkt")
(require graphics/graphics)

(provide
 rFrame%
 rDraw
 rBrush
 rColor
 rWrite)

(open-graphics)

(define rWrite (λ (v1 v2 v3 v4 v5)
                (send v1 text v2 v3 v4 v5)
                )
  )

(define rDraw (λ (v1 v2)
                (send v1 beginDraw v2)
                )
  )

(define rColor (λ(v1 v2)
                 (send v1 bg-color v2))
  )

(define rBrush (λ (v1 v2)
                 (send v1 brush v2))
  )

(define rFrame%
  (class object%
    (super-new)

    (define rFrame (open-viewport "Pictionary" 500 500))
    (define pBrush "black")

    (define/public (brush v1)
      (set! pBrush v1))

    (define/public (clearFrame)
      (clear-viewport rFrame)
      )

    (define/public (bg-color v1)
      ((draw-viewport rFrame) v1))

    (define/public (text v1 v2 v3 v4)
      ((draw-string rFrame)
       (make-posn v1 v2)
       v3
       v4)
      )
       

    (define/public (frame-instance)
      rFrame)

    (define/public (beginDraw v1)
      (ready-mouse-release rFrame)
      ((draw-solid-ellipse rFrame)
       (mouse-click-posn (get-mouse-click rFrame))
       10
       10
       pBrush)
      (cond
        ((equal? v1 #t) (beginDraw #t))
        )
      )
    )
  )
