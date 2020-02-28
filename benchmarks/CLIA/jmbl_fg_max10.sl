(set-logic LIA)


(synth-fun mux_10 ((x1 Int) (x2 Int) (x3 Int) (x4 Int) (x5 Int)
                 (x6 Int) (x7 Int) (x8 Int) (x9 Int) (x10 Int)) Int
)

(declare-var x1 Int)
(declare-var x2 Int)
(declare-var x3 Int)
(declare-var x4 Int)
(declare-var x5 Int)
(declare-var x6 Int)
(declare-var x7 Int)
(declare-var x8 Int)
(declare-var x9 Int)
(declare-var x10 Int)


(constraint (>= (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10) x1))
(constraint (>= (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10) x2))
(constraint (>= (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10) x3))
(constraint (>= (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10) x4))
(constraint (>= (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10) x5))
(constraint (>= (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10) x6))
(constraint (>= (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10) x7))
(constraint (>= (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10) x8))
(constraint (>= (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10) x9))
(constraint (>= (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10) x10))

(constraint (or (= x1 (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10))
            (or (= x2 (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10))
            (or (= x3 (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10))
            (or (= x4 (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10))
            (or (= x5 (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10))
            (or (= x6 (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10))
            (or (= x7 (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10))
            (or (= x8 (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10))
            (or (= x9 (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10))
                (= x10 (mux_10 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10))))))))))))


(check-synth)

