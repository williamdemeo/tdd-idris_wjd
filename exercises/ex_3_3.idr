import Data.Vect

{-- 1.
  Reimplement transposeMat using zipWith instead of transposeHelper.
  You can test your answer at the REPL as follows:
  *ex_3_3_3> transposeMat [[1,2], [3,4], [5,6]]
  [[1, 3, 5], [2, 4, 6]] : Vect 2 (Vect 3 Integer)
--}
createEmpties : Vect n (Vect 0 elem)
createEmpties = replicate _ []

my_transposeMat : Vect m (Vect n elem) -> Vect n (Vect m elem)
my_transposeMat [] = createEmpties
my_transposeMat (x :: xs) = let xsTrans = my_transposeMat xs in
                                zipWith (::) x xsTrans

{-- 2.
  Implement
  addMatrix : Num a => Vect n (Vect m a) ->
                       Vect n (Vect m a) -> Vect n (Vect m a).
  You can test your answer at the REPL as follows:
  *ex_3_3_3> addMatrix [[1,2], [3,4]] [[5,6], [7,8]]
  [[6, 8], [10, 12]] : Vect 2 (Vect 2 Integer)
--}
addMatrix : Num a => Vect n (Vect m a) -> Vect n (Vect m a) -> Vect n (Vect m a)
addMatrix [] [] = []
addMatrix (x :: xs) (y :: ys) = (zipWith (+) x y) :: addMatrix xs ys



{-- 3.
  Implement a function for multiplying matrices,
  following the description given in section 3.3.1.
  Hint: This definition is quite tricky and involves multiple steps.
  Consider the following:
  - You have a left matrix of dimensions n × m ,
    and a right matrix of dimensions m × p .
    A good start is to use transposeMat on the right matrix.
  - Remember that you can use Ctrl-Alt-L to lift holes to top-level functions.
  - Remember to pay close attention to the types of the local variables and
    the types of the holes.
  - Remember to use Ctrl-Alt-S to search for expressions, and pay close
    attention to the types of any resulting holes.
  You can test your answer at the REPL as follows:
  *ex_3_3_3> multMatrix [[1,2], [3,4], [5,6]] [[7,8,9,10], [11,12,13,14]]
--}

multMatrix_helper : Num numType => Vect n (Vect m numType) ->
                                   Vect p (Vect m numType) ->
                                   Vect n (Vect p numType)

multMatrix : Num numType =>
             Vect n (Vect m numType) -> Vect m (Vect p numType) ->
             Vect n (Vect p numType)
multMatrix xs ys = multMatrix_helper xs (my_transposeMat ys)
