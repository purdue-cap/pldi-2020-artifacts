(set-logic LIA)

;; f1 is x plus 2 ;; f2 is 2x plus 5

(synth-fun f1 ((x Int)) Int
	(
		(Start Int (
			(+ Plusw CInt)
			)
		)
		(Plusw Int ((+ Plusz CInt)))
		(Plusz Int ((+ Plusy CInt)))
		(Plusy Int ((+ CInt Var)))
		(Var Int (x))
		(CInt Int (0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15))

		)
	)


(synth-fun f2 ((x Int)) Int
	(
		(Start Int (
			(+ Plusw CInt)
			x
			)
		)
		(Plusw Int ((+ Plusz CInt)))
		(Plusz Int ((+ Plusy CInt)))
		(Plusy Int ((+ Start Var)))
		(Var Int (x))
		(CInt Int (0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15))

		)
	)
(declare-var x Int)

(constraint (= (+ (f1 x)(f2 x)) (+ (+ x x) (+ x 8))))
(constraint (= (- (f2 x)(f1 x)) (+ x 2)))

(check-synth)