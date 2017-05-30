{-- Exercises 4.3 --}
{-- ex 1 --}
{-- Add a size command that displays the number of entries in the store. --}

{-- ex 2 --}
{-- Add a search command that displays all the entries in the store containing
    a given substring. Hint: Use `Strings.isInfixOf`. --}

{-- 3 --}
{--  Extend search to print the location of each result, as well as the string.
     You can test your solution at the REPL as follows:
 *ex_4_3> :exec
 Command: add Shearer  -- ans: ID 0
 Command: add Milburn  -- ans: ID 1
 Command: add White    -- ans: ID 2
 Command: size         -- ans: 3
 Command: search Mil   -- ans: 1: Milburn
--}

module Main

import Data.Vect -- use Vect to store the data so we can keep
                  -- track of the size of the store in types

-- A data type for representing a data store
data DataStore : Type where -- DataStore is the type constructor.
    MkData : (size : Nat) -> (items : Vect size String) -> DataStore
    -- MkData is the data constructor, which gives the canonical way of
    -- constructing a data store.

{-- ex 1 --}
{-- Add a size command that displays the number of entries in the store. --}
size : DataStore -> Nat
size (MkData size' items') = size'
{-- ex 1 (done) --}


items : (store : DataStore) -> Vect (size store) String
items (MkData size' items') = items'

addToStore : DataStore -> String -> DataStore
addToStore (MkData size items) newitem = MkData _ (addToData items)
 where
   addToData : Vect old String -> Vect (S old) String
   addToData [] = [newitem]
   addToData (item :: items') = item :: addToData items'


data Command = Add String | Get Integer | Search String | Quit

parseCommand : (comm : String) -> (newstr : String) -> Maybe Command
parseCommand "add" str = Just (Add str)
parseCommand "search" str = Just (Search str)
parseCommand "get" val = case all isDigit (unpack val) of
                         False => Nothing
                         True => Just (Get (cast val))
parseCommand "quit" "" = Just Quit
parseCommand _ _ = Nothing

parse : (input: String) -> Maybe Command
parse input = case span (/= ' ') input of
                  (comm, newstr) => parseCommand comm (ltrim newstr)

getEntry : (pos : Integer) -> (mystore : DataStore) -> Maybe (String, DataStore)
getEntry pos mystore = let store_items = -- recall items is a function that
                      items mystore in  -- takes a DataStore as input and outputs
                      case integerToFin pos (size mystore) of
                           Nothing => Just("Out of range\n", mystore)
                           Just id => Just (index id store_items ++ "\n", mystore)

{-- ex 2 --}
{-- Add a search command that displays all the entries in the store containing
    a given substring. Hint: Use `Strings.isInfixOf`. --}

searchAux : DataStore -> String -> Integer -> String -> Maybe (String, DataStore)
searchAux ds str n acc = case ds of
    MkData _ [] => Just(acc, ds)
    MkData _ (x :: xs) => if (isInfixOf str x)
        then let new_acc = (acc ++ (cast n) ++ ": " ++ x ++ "\n") in
             searchAux (MkData _ xs) str (n+1) new_acc
        else searchAux (MkData _ xs) str (n+1) acc

search : DataStore -> String -> Maybe (String, DataStore)
search ds str = searchAux ds str 0 ""
{-- ex 2 (done) --}

processInput : DataStore -> String -> Maybe (String, DataStore)
processInput mystore newstr
 = case (parse newstr) of
     Nothing => Just ("Invalid command\n", mystore)
     Just (Add item) =>
       Just("ID" ++ show (size mystore) ++ "\n", addToStore mystore item)
     Just (Search item) => case (search mystore item) of
                           Nothing => Just("string not found", mystore)
                           Just(acc, ds) => Just(acc, mystore)
     Just (Get pos) => getEntry pos mystore
     Just Quit => Nothing
     -- (addToStore mystore newstr) in
     --                     Just("Added " ++ newstr ++ " to DataStore\n", newstore)



-- Process input from command line
main : IO ()
main = replWith (MkData _ []) "Command: " processInput
