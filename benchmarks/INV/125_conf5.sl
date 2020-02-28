(set-logic LIA)

(declare-primed-var i Int)
(declare-primed-var j Int)
(declare-primed-var conf_0 Int)
(declare-primed-var conf_1 Int)
(declare-primed-var conf_2 Int)
(declare-primed-var conf_3 Int)
(declare-primed-var conf_4 Int)
(declare-primed-var x Int)
(declare-primed-var y Int)
(declare-primed-var i_0 Int)
(declare-primed-var i_1 Int)
(declare-primed-var j_0 Int)
(declare-primed-var j_1 Int)
(declare-primed-var conf_0_0 Int)
(declare-primed-var conf_0_1 Int)
(declare-primed-var conf_0_2 Int)
(declare-primed-var conf_1_0 Int)
(declare-primed-var conf_2_0 Int)
(declare-primed-var conf_3_0 Int)
(declare-primed-var conf_4_0 Int)
(declare-primed-var conf_4_1 Int)
(declare-primed-var conf_4_2 Int)
(declare-primed-var x_0 Int)
(declare-primed-var x_1 Int)
(declare-primed-var x_2 Int)
(declare-primed-var y_0 Int)
(declare-primed-var y_1 Int)
(declare-primed-var y_2 Int)
(synth-inv inv-f ((i Int) (j Int) (conf_0 Int) (conf_1 Int) (conf_2 Int) (conf_3 Int) (conf_4 Int) (x Int) (y Int) (i_0 Int) (i_1 Int) (j_0 Int) (j_1 Int) (conf_0_0 Int) (conf_0_1 Int) (conf_0_2 Int) (conf_1_0 Int) (conf_2_0 Int) (conf_3_0 Int) (conf_4_0 Int) (conf_4_1 Int) (conf_4_2 Int) (x_0 Int) (x_1 Int) (x_2 Int) (y_0 Int) (y_1 Int) (y_2 Int)))

(define-fun pre-f ((i Int) (j Int) (conf_0 Int) (conf_1 Int) (conf_2 Int) (conf_3 Int) (conf_4 Int) (x Int) (y Int) (i_0 Int) (i_1 Int) (j_0 Int) (j_1 Int) (conf_0_0 Int) (conf_0_1 Int) (conf_0_2 Int) (conf_1_0 Int) (conf_2_0 Int) (conf_3_0 Int) (conf_4_0 Int) (conf_4_1 Int) (conf_4_2 Int) (x_0 Int) (x_1 Int) (x_2 Int) (y_0 Int) (y_1 Int) (y_2 Int)) Bool
    (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (= i i_1) (= j j_1)) (= conf_0 conf_0_0)) (= conf_1 conf_1_0)) (= conf_2 conf_2_0)) (= conf_3 conf_3_0)) (= conf_4 conf_4_0)) (= x x_0)) (= y y_0)) (= conf_0_0 4)) (= conf_1_0 1)) (= conf_2_0 3)) (= conf_3_0 7)) (= conf_4_0 1)) (= i_1 x_0)) (= j_1 y_0)))
(define-fun trans-f ((i Int) (j Int) (conf_0 Int) (conf_1 Int) (conf_2 Int) (conf_3 Int) (conf_4 Int) (x Int) (y Int) (i_0 Int) (i_1 Int) (j_0 Int) (j_1 Int) (conf_0_0 Int) (conf_0_1 Int) (conf_0_2 Int) (conf_1_0 Int) (conf_2_0 Int) (conf_3_0 Int) (conf_4_0 Int) (conf_4_1 Int) (conf_4_2 Int) (x_0 Int) (x_1 Int) (x_2 Int) (y_0 Int) (y_1 Int) (y_2 Int) (i! Int) (j! Int) (conf_0! Int) (conf_1! Int) (conf_2! Int) (conf_3! Int) (conf_4! Int) (x! Int) (y! Int) (i_0! Int) (i_1! Int) (j_0! Int) (j_1! Int) (conf_0_0! Int) (conf_0_1! Int) (conf_0_2! Int) (conf_1_0! Int) (conf_2_0! Int) (conf_3_0! Int) (conf_4_0! Int) (conf_4_1! Int) (conf_4_2! Int) (x_0! Int) (x_1! Int) (x_2! Int) (y_0! Int) (y_1! Int) (y_2! Int)) Bool
    (or (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (= conf_0_1 conf_0) (= conf_4_1 conf_4)) (= x_1 x)) (= y_1 y)) (= conf_0_1 conf_0!)) (= conf_4_1 conf_4!)) (= x_1 x!)) (= y_1 y!)) (= i i!)) (= j j!)) (= conf_0 conf_0!)) (= conf_1 conf_1!)) (= conf_2 conf_2!)) (= conf_3 conf_3!)) (= conf_4 conf_4!)) (= y y!)) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (= conf_0_1 conf_0) (= conf_4_1 conf_4)) (= x_1 x)) (= y_1 y)) (not (= x_1 0))) (= x_2 (- x_1 1))) (= conf_0_2 conf_0_1)) (= y_2 (- y_1 1))) (= conf_4_2 (+ conf_3_0 671))) (= conf_0_2 conf_0!)) (= conf_4_2 conf_4!)) (= x_2 x!)) (= y_2 y!)) (= i i_1)) (= i! i_1)) (= j j_1)) (= j! j_1)) (= conf_1 conf_1_0)) (= conf_1! conf_1_0)) (= conf_2 conf_2_0)) (= conf_2! conf_2_0)) (= conf_3 conf_3_0)) (= conf_3! conf_3_0))))
(define-fun post-f ((i Int) (j Int) (conf_0 Int) (conf_1 Int) (conf_2 Int) (conf_3 Int) (conf_4 Int) (x Int) (y Int) (i_0 Int) (i_1 Int) (j_0 Int) (j_1 Int) (conf_0_0 Int) (conf_0_1 Int) (conf_0_2 Int) (conf_1_0 Int) (conf_2_0 Int) (conf_3_0 Int) (conf_4_0 Int) (conf_4_1 Int) (conf_4_2 Int) (x_0 Int) (x_1 Int) (x_2 Int) (y_0 Int) (y_1 Int) (y_2 Int)) Bool
    (or (not (and (and (and (and (and (and (and (and (= i i_1) (= j j_1)) (= conf_0 conf_0_1)) (= conf_1 conf_1_0)) (= conf_2 conf_2_0)) (= conf_3 conf_3_0)) (= conf_4 conf_4_1)) (= x x_1)) (= y y_1))) (not (and (and (not (not (= x_1 0))) (not (= y_1 0))) (not (not (= i_1 j_1)))))))

(inv-constraint inv-f pre-f trans-f post-f)

(check-synth)

