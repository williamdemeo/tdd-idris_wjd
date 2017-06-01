{-- 1 --}
{-- Write a function that implements a simple "guess the number" game.
    It should have the following type:
         guess : (target : Nat) -> IO ()
    Here, target is the number to be guessed, and guess should behave
    as follows:
    + Repeatedly ask the user to guess a number, and display whether
      the guess is too high, too low, or correct.
    + When the guess is correct, exit.
    Ideally, guess will also report an error message if the input is
    invalid (for example, if it contains characters that are not digits
    or are out of range). --}

{-- 2 --}
{-- Implement a main function that chooses a random number between 1
    and 100 and then calls guess. Hint: As a source of random numbers,
    you could use time : IO Integer , defined in the System module. --}

{-- 3 --}
{-- Extend guess so that it counts the number of guesses the user has
    taken and displays that number before the input is read.
    Hint: Refine the type of guess to the following:
        guess : (target : Nat) -> (guesses : Nat) -> IO ()
    --}

{-- 4 --}
{-- Implement your own versions of repl and replWith.
    Remember that you'll need to use different names to avoid clashing
    with the names defined in the Prelude. --}
