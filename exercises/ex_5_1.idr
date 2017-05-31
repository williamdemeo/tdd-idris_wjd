{-- 1 --}
{-- Using do notation, write a printLonger program that reads two strings
    and then displays the length of the longer string. --}

maxlen : (firststr : String) -> (secondstr : String) -> Nat
maxlen x y = if ((length x) > (length y)) then (length x)
             else (length y)

printLonger : IO ()

printLonger = do putStr "Input first string: "
                 firststr <- getLine
                 putStr "Input second string: "
                 secondstr <- getLine
                 putStrLn ("The longer string has length " ++ show (maxlen firststr secondstr) ++ "\n")

{-- 2 --}
{-- Write the same program using >>= instead of do notation.
    You can test your answers at the REPL as follows:
        *ex_5_1> :exec printLonger
        First string: short
        Second string: longer    --}
