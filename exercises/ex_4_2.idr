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
    `Vect`. Also, remember that you can have any expression in a type.
    Solution:
--}
vectTake : (m : Nat) -> Vect n elem -> Maybe (Vect m elem)
vectTake m [] = case m of
                     Z => Just []
                     (S k) => Nothing
vectTake (S k) (x :: xs) = case (vectTake k xs) of
                                Just v => Just (x :: v)
                                Nothing => Nothing

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
-- vectTake : Vect n elem -> (m: Int) -> Maybe (Vect m elem)
