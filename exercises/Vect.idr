data Vect : Nat -> Type -> Type where
     Nil  : Vect Z a
     (::) : a -> Vect n a -> Vect (S n) a
%name Vect xs, ys, zs

append : Vect m a -> Vect n a -> Vect (m+n) a
append [] ys = ys
append (x :: xs) ys = x :: append xs ys
