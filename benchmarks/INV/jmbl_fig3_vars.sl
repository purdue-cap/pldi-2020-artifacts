(set-logic LIA)

(synth-inv InvF ((x Int) (y Int) (lock Int) (v1 Int) (v2 Int) (v3 Int)))

(declare-primed-var x Int)
(declare-primed-var y Int)
(declare-primed-var lock Int)
(declare-primed-var v1 Int)
(declare-primed-var v2 Int)
(declare-primed-var v3 Int)
(define-fun PreF ((x Int) (y Int) (lock Int) (v1 Int) (v2 Int) (v3 Int)) Bool
    (or (and (= x y) (= lock 1)) (and (= (+ x 1) y) (= lock 0))))
(define-fun TransF ((x Int) (y Int) (lock Int) (v1 Int) (v2 Int) (v3 Int) (x! Int) (y! Int) (lock! Int) (v1! Int) (v2! Int) (v3! Int)) Bool
    (or (and (and (not (= x y)) (= lock! 1)) (= x! y)) (and (and (and (not (= x y)) (= lock! 0)) (= x! y)) (= y! (+ y 1)))))
(define-fun PostF ((x Int) (y Int) (lock Int) (v1 Int) (v2 Int) (v3 Int)) Bool
    (not (and (= x y) (not (= lock 1)))))

(inv-constraint InvF PreF TransF PostF)

(check-synth)

