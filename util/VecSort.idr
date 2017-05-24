import Data.Vect

insert : Ord elem => (x : elem) -> (xsorted : Vect len elem) -> Vect (S len) elem
insert x [] = [x]
insert x (y :: ys) = case x < y of
                     False => y :: insert x ys
                     True => x :: y :: ys

insSort : Ord elem => Vect n elem -> Vect n elem
-- ctrl+alt+a (add skeleton)
-- ctrl+alt+c (case split)
insSort [] = []
-- ctrl+alt+s (expression search)
insSort (x :: xs) = insert x (insSort xs)
