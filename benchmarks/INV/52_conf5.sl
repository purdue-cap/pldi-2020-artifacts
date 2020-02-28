(set-logic LIA)

(declare-primed-var c Int)
(declare-primed-var conf_0 Int)
(declare-primed-var conf_1 Int)
(declare-primed-var conf_2 Int)
(declare-primed-var conf_3 Int)
(declare-primed-var conf_4 Int)
(declare-primed-var tmp Int)
(declare-primed-var c_0 Int)
(declare-primed-var c_1 Int)
(declare-primed-var c_2 Int)
(declare-primed-var c_3 Int)
(declare-primed-var c_4 Int)
(declare-primed-var c_5 Int)
(declare-primed-var conf_0_0 Int)
(declare-primed-var conf_1_0 Int)
(declare-primed-var conf_1_1 Int)
(declare-primed-var conf_1_2 Int)
(declare-primed-var conf_1_3 Int)
(declare-primed-var conf_2_0 Int)
(declare-primed-var conf_3_0 Int)
(declare-primed-var conf_4_0 Int)
(declare-primed-var conf_4_1 Int)
(declare-primed-var conf_4_2 Int)
(declare-primed-var conf_4_3 Int)
(synth-inv inv-f ((c Int) (conf_0 Int) (conf_1 Int) (conf_2 Int) (conf_3 Int) (conf_4 Int) (tmp Int) (c_0 Int) (c_1 Int) (c_2 Int) (c_3 Int) (c_4 Int) (c_5 Int) (conf_0_0 Int) (conf_1_0 Int) (conf_1_1 Int) (conf_1_2 Int) (conf_1_3 Int) (conf_2_0 Int) (conf_3_0 Int) (conf_4_0 Int) (conf_4_1 Int) (conf_4_2 Int) (conf_4_3 Int)))

(define-fun pre-f ((c Int) (conf_0 Int) (conf_1 Int) (conf_2 Int) (conf_3 Int) (conf_4 Int) (tmp Int) (c_0 Int) (c_1 Int) (c_2 Int) (c_3 Int) (c_4 Int) (c_5 Int) (conf_0_0 Int) (conf_1_0 Int) (conf_1_1 Int) (conf_1_2 Int) (conf_1_3 Int) (conf_2_0 Int) (conf_3_0 Int) (conf_4_0 Int) (conf_4_1 Int) (conf_4_2 Int) (conf_4_3 Int)) Bool
    (and (and (and (and (and (and (and (and (and (and (and (= c c_1) (= conf_0 conf_0_0)) (= conf_1 conf_1_0)) (= conf_2 conf_2_0)) (= conf_3 conf_3_0)) (= conf_4 conf_4_0)) (= conf_0_0 5)) (= conf_1_0 1)) (= conf_2_0 4)) (= conf_3_0 9)) (= conf_4_0 6)) (= c_1 0)))
(define-fun trans-f ((c Int) (conf_0 Int) (conf_1 Int) (conf_2 Int) (conf_3 Int) (conf_4 Int) (tmp Int) (c_0 Int) (c_1 Int) (c_2 Int) (c_3 Int) (c_4 Int) (c_5 Int) (conf_0_0 Int) (conf_1_0 Int) (conf_1_1 Int) (conf_1_2 Int) (conf_1_3 Int) (conf_2_0 Int) (conf_3_0 Int) (conf_4_0 Int) (conf_4_1 Int) (conf_4_2 Int) (conf_4_3 Int) (c! Int) (conf_0! Int) (conf_1! Int) (conf_2! Int) (conf_3! Int) (conf_4! Int) (tmp! Int) (c_0! Int) (c_1! Int) (c_2! Int) (c_3! Int) (c_4! Int) (c_5! Int) (conf_0_0! Int) (conf_1_0! Int) (conf_1_1! Int) (conf_1_2! Int) (conf_1_3! Int) (conf_2_0! Int) (conf_3_0! Int) (conf_4_0! Int) (conf_4_1! Int) (conf_4_2! Int) (conf_4_3! Int)) Bool
    (or (or (or (or (and (and (and (and (and (and (and (and (and (and (and (and (= c_2 c) (= conf_1_1 conf_1)) (= conf_4_1 conf_4)) (= c_2 c!)) (= conf_1_1 conf_1!)) (= conf_4_1 conf_4!)) (= c c!)) (= conf_0 conf_0!)) (= conf_1 conf_1!)) (= conf_2 conf_2!)) (= conf_3 conf_3!)) (= conf_4 conf_4!)) (= tmp tmp!)) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (= c_2 c) (= conf_1_1 conf_1)) (= conf_4_1 conf_4)) (not (= c_2 4))) (= c_3 (+ c_2 1))) (= conf_1_2 (- conf_1_1 421))) (= c_4 c_3)) (= conf_1_3 conf_1_2)) (= conf_4_2 conf_4_1)) (= c_4 c!)) (= conf_1_3 conf_1!)) (= conf_4_2 conf_4!)) (= conf_0 conf_0_0)) (= conf_0! conf_0_0)) (= conf_2 conf_2_0)) (= conf_2! conf_2_0)) (= conf_3 conf_3_0)) (= conf_3! conf_3_0)) (= tmp tmp!))) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (= c_2 c) (= conf_1_1 conf_1)) (= conf_4_1 conf_4)) (not (not (= c_2 4)))) (= c_4 c_2)) (= conf_1_3 conf_1_1)) (= conf_4_2 conf_4_1)) (= c_4 c!)) (= conf_1_3 conf_1!)) (= conf_4_2 conf_4!)) (= conf_0 conf_0_0)) (= conf_0! conf_0_0)) (= conf_2 conf_2_0)) (= conf_2! conf_2_0)) (= conf_3 conf_3_0)) (= conf_3! conf_3_0)) (= tmp tmp!))) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (= c_2 c) (= conf_1_1 conf_1)) (= conf_4_1 conf_4)) (= c_2 4)) (= c_5 1)) (= conf_4_3 (+ conf_2_0 143))) (= c_4 c_5)) (= conf_1_3 conf_1_1)) (= conf_4_2 conf_4_3)) (= c_4 c!)) (= conf_1_3 conf_1!)) (= conf_4_2 conf_4!)) (= conf_0 conf_0_0)) (= conf_0! conf_0_0)) (= conf_2 conf_2_0)) (= conf_2! conf_2_0)) (= conf_3 conf_3_0)) (= conf_3! conf_3_0)) (= tmp tmp!))) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (= c_2 c) (= conf_1_1 conf_1)) (= conf_4_1 conf_4)) (not (= c_2 4))) (= c_4 c_2)) (= conf_1_3 conf_1_1)) (= conf_4_2 conf_4_1)) (= c_4 c!)) (= conf_1_3 conf_1!)) (= conf_4_2 conf_4!)) (= conf_0 conf_0_0)) (= conf_0! conf_0_0)) (= conf_2 conf_2_0)) (= conf_2! conf_2_0)) (= conf_3 conf_3_0)) (= conf_3! conf_3_0)) (= tmp tmp!))))
(define-fun post-f ((c Int) (conf_0 Int) (conf_1 Int) (conf_2 Int) (conf_3 Int) (conf_4 Int) (tmp Int) (c_0 Int) (c_1 Int) (c_2 Int) (c_3 Int) (c_4 Int) (c_5 Int) (conf_0_0 Int) (conf_1_0 Int) (conf_1_1 Int) (conf_1_2 Int) (conf_1_3 Int) (conf_2_0 Int) (conf_3_0 Int) (conf_4_0 Int) (conf_4_1 Int) (conf_4_2 Int) (conf_4_3 Int)) Bool
    (or (not (and (and (and (and (and (= c c_2) (= conf_0 conf_0_0)) (= conf_1 conf_1_1)) (= conf_2 conf_2_0)) (= conf_3 conf_3_0)) (= conf_4 conf_4_1))) (not (and (and (< c_2 0) (> c_2 4)) (not (= c_2 4))))))

(inv-constraint inv-f pre-f trans-f post-f)

(check-synth)

