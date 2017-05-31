printLength : IO ()
printLength = getLine >>= \gotten => putStrLn (show (length gotten))

printLength' : IO ()
printLength' = do putStr "Input string: "
                  input <- getLine
                  let len = length input
                  putStrLn (show len)
