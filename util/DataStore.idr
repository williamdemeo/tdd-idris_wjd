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


data Command = Add String | Get Integer | Quit

parseCommand : (comm : String) -> (newstr : String) -> Maybe Command
parseCommand "add" str = Just (Add str)
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

processInput : DataStore -> String -> Maybe (String, DataStore)
processInput mystore newstr
  = case (parse newstr) of
      Nothing => Just ("Invalid command\n", mystore)
      Just (Add item) =>
        Just("ID" ++ show (size mystore) ++ "\n", addToStore mystore item)
      Just (Get pos) => getEntry pos mystore
      Just Quit => Nothing
      -- (addToStore mystore newstr) in
      --                     Just("Added " ++ newstr ++ " to DataStore\n", newstore)

-- Process input from command line
main : IO ()
main = replWith (MkData _ []) "Command: " processInput
