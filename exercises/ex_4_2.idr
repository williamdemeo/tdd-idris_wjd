import Vehicle
-- import Vect
import Data.Vect
{-- Exercises --}
{-- 1 --}
{-- Extend the Vehicle data type so that it supports unicycles and motorcycles,
    and update wheels and refuel accordingly.
    (done)
    Solution: In the Vehicle.idr file,
    + added to `data Vehicle`
         Motorcycle : (fuel : Nat) -> Vehicle Petrol
         Unicycle : Vehicle Pedal
    + added to `wheels : Vehicle power -> Nat`
         wheels (Motorcycle fuel) = 2
         wheels Unicycle = 1
    + added to `refuel : Vehicle Petrol -> Vehicle Petrol`
         refuel (Motorcycle fuel) = Motorcycle 20
         refuel Unicycle impossible
    --}

{-- 2 --}
{-- Extend the PowerSource and Vehicle data types to support electric
    vehicles (such as trams or electric cars).
    (done)  (added Electric and Ecar and Tram)
    --}

{-- 3 --}
{-- The `take` function on `List` has type `Nat -> List a -> List a`.
    What's an appropriate type for the corresponding `vectTake` function
    on `Vect`? Hint: How do the lengths of the input and output relate?
    It shouldn't be valid to take more elements than there are in the
    `Vect`. Also, remember that you can have any expression in a type. --}

{-- SOLUTION --}
{-- First try (doesn't work) --}
--  vectTake : (m : Nat) -> Vect n elem -> Maybe (Vect m elem)
{-- 4 --}
{-- Implement `vectTake`. If you've implemented it correctly, with the
    correct type, you can test your answer at the REPL as follows:
        *ex_4_2> vectTake 3 [1,2,3,4,5,6,7]
        [1, 2, 3] : Vect 3 Integer
    You should also get a type error if you try to take too many elements:
        *ex_4_2> vectTake 8 [1,2,3,4,5,6,7]
        (input):1:14:When checking argument xs to constructor Main.:::
                Type mismatch between
                        Vect 0 a1 (Type of [])
                and
                        Vect (S m) a (Expected type)
--}
{-- SOLUTION --}
{-- First try (doesn't work) --}
--        vectTake m [] = case m of
--                        Z => Just []
--                        (S k) => Nothing
--        vectTake (S k) (x :: xs) = case (vectTake k xs) of
--                                   Just v => Just (x :: v)
--                                   Nothing => Nothing
{-- Second try (works) --}
vectTake : (n : Nat) -> Vect (n + m) a -> Vect n a
vectTake Z xs = []
vectTake (S k) (x :: xs) = x :: vectTake k xs

vectDrop : (n : Nat) -> Vect (n + m) a -> Vect m a
vectDrop Z xs = xs
vectDrop (S k) (x :: xs) = vectDrop k xs

{-- 5 --}
{-- Write a sumEntries function with the following type:
        sumEntries : Num a => (pos : Integer) -> Vect n a -> Vect n a -> Maybe a
    It should return the sum of the entries at position pos in each of
    the inputs if pos is within bounds, or Nothing otherwise.
    For example:
        *ex_4_2> sumEntries 2 [1,2,3,4] [5,6,7,8]
        Just 10 : Maybe Integer
        *ex_4_2> sumEntries 4 [1,2,3,4] [5,6,7,8]
        Nothing : Maybe Integer
    Hint: You'll need to call `integerToFin`, but only need to do it once.
--}
{-- SOLUTION --}
plusMaybe : Num a => Maybe a -> Maybe a -> Maybe a
plusMaybe x y = case x of
                Just vx => case y of
                           Just vy => Just (vx + vy)
                           Nothing => Nothing
                Nothing => Nothing

getHead : Vect n a -> Maybe a
getHead [] = Nothing
getHead (x :: xs) = Just x

getEntry : (pos : Nat) -> Vect n a -> Maybe a
getEntry _ [] = Nothing
getEntry Z xs = getHead xs
getEntry (S k) (x :: xs) = getEntry k xs

sumEntries : Num a => (pos : Nat) -> Vect n a -> Vect m a -> Maybe a
sumEntries Z xs ys = plusMaybe (getHead xs) (getHead ys)
sumEntries pos xs ys = plusMaybe (getEntry pos xs) (getEntry pos ys)
