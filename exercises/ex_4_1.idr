

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

listToTree : Ord a => List a -> Tree a

{-- 2.
  Write a corresponding function,
  `treeToList : Tree a -> List a` that flattens a tree
  into a list using in-order traversal (that is, all the
  values in the left subtree of a node should be added
  to the list before the value at the node, which should
  be added before the values in the right subtree).
  If you have the correct answers to exercises 1 and 2,
  you should be able to run this:
  *ex_4_1> treeToList (listToTree [4,1,8,7,2,3,9,5,6])
--}
