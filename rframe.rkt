#lang racket

(require "engine.rkt")
(require graphics/graphics)

(provide
 rFrame%
 rDraw
 rBrush
 rColor
 rWrite
 pos)

(open-graphics)

(define pos(λ (v1 v2)
             (make-posn v1 v2)
             )
  )

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

    (define title "Window")

    (define yBoundry 0)
    (define xBoundry 0)

    (define rFrame (open-viewport title 500 500))
    (define pBrush "black")

    (define/public (title! v1)
      (set! title v1)
      )

    (define/public (brush v1)
      (set! pBrush v1))

    (define/public (clearFrame)
      (clear-viewport rFrame)
      )

    (define/public (get-x v1)
      (posn-x v1)
      )

    (define/public (get-y v1)
      (posn-y v1)
      )

    (define/public (load-preset v1)
      (clearFrame)
      (cond
        ((equal? v1 "WAITING")
         ((draw-string rFrame)
          (pos 350 15)
          "State: WAITING"
          "black")
         ) ((equal? v1 "TEST")
            ((draw-string rFrame)
             (pos 350 15)
             "State: TEST_ROUND"
             "red")
            )
           )
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

    (define/public (frame-instance! v1)
      (set! rFrame v1)
      )

    (define/public (close)
      (close-viewport rFrame)
      (set! rFrame null)
      (display (string-append "\nClosed graphic\n "))
      )

    (define/public (yBoundry! v1)
      (set! yBoundry v1)
      )

    (define/public (beginDraw v1)
      (ready-mouse-release rFrame)
      (cond
        ((> (get-y (mouse-click-posn (get-mouse-click rFrame))) yBoundry)
         ((draw-solid-ellipse rFrame)
          (mouse-click-posn (get-mouse-click rFrame))
          10
          10
          pBrush)))
      (cond
        ((equal? v1 #t) (beginDraw #t))
        )
      )
    )
  )
