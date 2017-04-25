import BSTree

{-- 1.
  Write a function, `listToTree : Ord a => List a -> Tree a`
  that inserts every element of a list into a binary search tree.
  You can test this at the REPL as follows:
      *ex_4_1> listToTree [1,4,3,5,2]
      Node (Node Empty 1 Empty)
           2
           (Node (Node Empty 3 (Node Empty 4 Empty))
                 5
                 Empty) : Tree Integer
--}

listToBSTree_aux : Ord a => List a -> BSTree a -> BSTree a
listToBSTree_aux [] acc = acc
listToBSTree_aux (x :: xs) tree = listToBSTree_aux xs (insert x tree)

listToBSTree : Ord a => List a -> BSTree a
listToBSTree [] = Empty
listToBSTree xs = listToBSTree_aux xs Empty

listToTree : Ord a => List a -> BSTree a
listToTree [] = Empty
listToTree (x :: xs) = insert x (listToTree xs)

{-- I get the following output (which seems to fit the spec better than
the output proposed above)

    Node Empty
         1
         (Node (Node (Node Empty 2 Empty) 3 Empty)
               4
               (Node Empty 5 Empty)) : BSTree Integer
--}

{-- 2.
  Write a corresponding function `treeToList : Tree a -> List a` that
  flattens a tree into a list using in-order traversal (that is, all
  the values in the left subtree of a node should be added to the list
  before the value at the node, which should be added before the values
  in the right subtree). If you have the correct answers to exercises 1
  and 2, you should be able to run this:
      *ex_4_1> treeToList (listToTree [4,1,8,7,2,3,9,5,6])
      [1, 2, 3, 4, 5, 6, 7, 8, 9] : List Integer
--}
treeToList : BSTree a -> List a
treeToList Empty = []
treeToList (Node left val right) = treeToList left ++ val :: treeToList right


{-- 3
  An integer arithmetic expression can take one of the following forms:
  - A single integer
  - Addition of an expression to an expression
  - Subtraction of an expression from an expression
  - Multiplication of an expression with an expression
  Define a recursive data type `Expr` that can be used to represent such
  expressions. Hint: Look at the Picture data type and see how the informal
  description mapped to the data declaration.
--}

data Expr = Num Int
          | Add Expr Expr
          | Sub Expr Expr
          | Mul Expr Expr
{-- 4
  Write a function `evaluate : Expr -> Int` that evaluates an integer
  arithmetic expression. If you have correct answers to 3 and 4, you should
  be able to try something like the following at the REPL:
      *ex_4_1> evaluate (Mult (Val 10) (Add (Val 6) (Val 3)))
      90 : Int
--}

evaluate: Expr -> Int
evaluate (Num x) = x
evaluate (Add x y) = (evaluate x) + (evaluate y)
evaluate (Sub x y) = (evaluate x) - (evaluate y)
evaluate (Mul x y) = (evaluate x) * (evaluate y)

{-- 5
  Write a function, maxMaybe : Ord a => Maybe a -> Maybe a -> Maybe a , that
  returns the larger of the two inputs, or Nothing if both inputs are Nothing .
  For example:
      *ex_4_1> maxMaybe (Just 4) (Just 5)
      Just 5 : Maybe Integer
      *ex_4_1> maxMaybe (Just 4) Nothing
      Just 4 : Maybe Integer
--}

{-- 6
  Write a function, biggestTriangle : Picture -> Maybe Double , that returns
  the area of the biggest triangle in a picture, or Nothing if there are no
  triangles. For example, you can define the following pictures:
      testPic1 : Picture
      testPic1 = Combine (Primitive (Triangle 2 3))
                         (Primitive (Triangle 2 4))
      testPic2 : Picture
      testPic2 = Combine (Primitive (Rectangle 1 3))
                         (Primitive (Circle 4))
  Then, test biggestTriangle at the REPL as follows:
      *ex_4_1> biggestTriangle testPic1
      Just 4.0 : Maybe Double
      *ex_4_1> biggestTriangle testPic2
      Nothing : Maybe Double
{-- --}
