module Main

import Data.Vect -- use Vect to store the data so we can keep
                 -- track of the size of the store in types

-- A data type for representing a data store
data DataStore : Type where -- DataStore is the type constructor.
     MkData : (size : Nat) -> (items : Vect size String) -> DataStore
     -- MkData is the data constructor, which gives the canonical way of
     -- constructing a data store.

size : DataStore -> Nat
size (MkData size' items') = size'

items : (store : DataStore) -> Vect (size store) String
items (MkData size' items') = items'

addToStore : DataStore -> String -> DataStore
addToStore (MkData size items) newitem = MkData _ (addToData items)
  where
    addToData : Vect old String -> Vect (S old) String
    addToData [] = [newitem]
    addToData (item :: items') = item :: addToData items'


data Command = add String | get Integer | quit

parse : (input: String) -> Maybe Command
parse input = let (comm, newstr) = span (/=" ") input in
              case comm of 
                add => Just (comm, newstr)
                get => Just (comm, newstr)
                _ => Nothing

processInput : DataStore -> String -> Maybe (String, DataStore)
processInput mystore newstr
  = if newstr == ""
    then Nothing
    else let newstore = (addToStore mystore newstr) in
             Just("Added " ++ newstr ++ " to DataStore\n", newstore)

-- Process input from command line
main : IO ()
main = replWith (MkData _ []) "Command: " processInput
