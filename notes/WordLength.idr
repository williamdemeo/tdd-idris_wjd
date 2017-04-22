-- calculate the length of every word in the given list
allLengths : List String -> List Nat
allLengths [] = []
allLengths (word :: words) = (length word) :: allLengths words
-- Ctrl-Alt-A (Add a skeleton def)
-- Ctrl-Alt-C (Case split, based on constructors)
-- Ctrl-Alt-T (check Type)
-- Ctrl-Alt-D (documentation)
