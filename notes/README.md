# notes

While learning Idris, I collected these notes about things that seemed useful,
important, or otherwise worth remembering.

## Brief Contents

# PART 1 INTRODUCTION ................................................... 1
## 1 Overview 3
## 2 Getting started with Idris 25

# PART 2 CORE IDRIS ......................................................53
## 3 Interactive development with types 55
## 4 User-defined data types 87
## 5 Interactive programs: input and output processing 123
## 6 Programming with first-class types 147
## 7 Interfaces: using constrained generic types 182
## 8 Equality: expressing relationships between data 208
## 9 Predicates: expressing assumptions and contracts in types 236
## 10 Views: extending pattern matching 258

# Part 3 IDRIS AND THE REAL WORLD ......................................... 289
## 11 Streams and processes: working with infinite data 291
## 12 Writing programs with state 324
## 13 State machines: verifying protocols in types 352
## 14 Dependent state machines: handling feedback and errors
## 15 Type-safe concurrent programming 403

----------------------------------------------------------------------------------

# 1 Overview 3

# 2 Getting started with Idris 25

## REPL


The Idris read-eval-print loop (REPL) provides several commands.
The most common are listed here.

| Command | Arguments | Description |
| ------- | --------- | ----------- |
| `<expression>` | None | Displays the result of evaluating the expression. The variable `it` contains the result of the most recent evaluation. |
| `:t` | `<expression>` |  Displays the type of the expression. |
| `:total` | `<name>` | Displays whether the function with the given name is total. |
| `:doc` | `<name>` | Displays documentation for name. |
| `:let` | `<definition>` | Adds a new definition. |
| `:exec` | `<expression>` | Compiles and executes the expression. If none is given, compiles and executes main.|
| `:c` | `<output file>` | Compiles to an executable with the entry point main. |
| `:r` | `None ` | Reloads the current module. |
| `:l` | `<filename>` | Loads a new file. |
| `:module` | `<module name>` | Imports an extra module for use at the REPL. |
| `:printdef` | `<name>` | Displays the definition of name. |
| `:apropos` | `<word>` | Searches function names, types, and documentation for the given word.|
| `:search` | `<type>` | Searches for functions with the given type. |
| `:browse` | `<namespace>` | Displays the names and types defined in the given namespace.|
| `:q` | `None ` |Exits the REPL. |


## Atom editor


### Interactive Editing Commands

| Shortcut | Command | Description |
| -------- | ------- | ----------- |
| `Ctrl-Alt-A` | Add definition | Adds a skeleton definition for the name under the cursor |
| `Ctrl-Alt-C` | Case split | Splits a definition into pattern-matching clauses for the name under the cursor |
| `Ctrl-Alt-D` | Documentation | Displays documentation for the name under the cursor |
| `Ctrl-Alt-L` | Lift hole | Lifts a hole to the top level as a new function declaration |
| `Ctrl-Alt-M` | Match | Replaces a hole with a case expression that matches on an intermediate result |
| `Ctrl-Alt-R` | Reload | Reloads and type-checks the current buffer |
| `Ctrl-Alt-S` | Search | Searches for an expression that satisfies the type of the hole name under the cursor |
| `Ctrl-Alt-T` | Type-check name | Displays the type of the name under the cursor |


------------------------------------------------------

# 3 Interactive development with types 55

## Example

Here is an example Atom session showing the typical steps we might take to
enlist Idris' help in constructing a function.

1. *Define.*
   First, give the type signature of the function you want:

   ```idris
   my_length : List a -> Nat
   ```

2. **[A]dd definition skeleton.**
   Next, put the cursor over `my_length` and type `C-Alt-A`
   to **[A]dd definition** code for the function.  The result is:

   ```idris
   my_length : List a -> Nat
   my_length xs = ?my_length_rhs
   ```

   The expression `?my_length_rhs` is called a hole. We have to fill it in
   with an appropriate function definition.

3. **[T]ype check holes.**
   We can check the type of the hole with `C-Alt-T`.
   The result is not all that exciting or surprising.

   ```idris
   a : Type
   xs : List a
   --------------------------------------
   my_length_rhs : Nat
   ```

4. **[C]ase-split inputs.**
   The function `my_length` will be defined based on a case-analysis,
   depeding on the structure of the input list `xs`.
   Each case we must handle corresponds to a particular constructor for
   lists of type `List a`.  We can ask Idris to layout all the cases for us by
   moving the cursor over `xs` and typing `C-Alt-C` (for **[C]ase-split**).
   The result looks like this:

   ```idris
   my_length : List a -> Nat
   my_length [] = ?my_length_rhs_1
   my_length (x :: xs) = ?my_length_rhs_2
   ```

5. **[S]earch for appropriate terms.**
   Next, we can ask Idris to search for an expression of a type that fits into the hole
   at `?my_length_rhs_1`.  In Atom, we do this with the cursor over the hole and the
   keystrokes `C-Alt-S` (for **[S]earch**). The result is

   ```idris
   my_length : List a -> Nat
   my_length [] = 0
   my_length (x :: xs) = ?my_length_rhs_2
   ```

   How did Idris get this right?
   Well, we need a `Nat` in the hole, and `0` is the first `Nat`.
   But this was dumb luck.

   If we try `C-Alt-S` at the second hole `?my_length_rhs_2`, we get the same (wrong) result.

   ```idris
   my_length : List a -> Nat
   my_length [] = 0
   my_length (x :: xs) = 0
   ```

6. *Define.* We fill in the correct defition:

   ```idris
   my_length : List a -> Nat
   my_length [] = 0
   my_length (x :: xs) = 1 + my_length xs
   ```

7. *Type check the program*
   Launch the Idris REPL and pass in the name of the file containing our
   `my_length` function.

   ```shell
   idris ex_3_2.idr
   ```

   If there are problems, fix them and then reload the file at the REPL
   prompt as follows:

   ```idris
   *ex_3_2> :r
   ```


**List of key-bindings used in the example above**

```atom
Ctrl-Alt-A (Add a skeleton def)
Ctrl-Alt-C (Case split, based on constructors)
Ctrl-Alt-T (check Type)
Ctrl-Alt-S (search)
```


Another nice example of these commands appears on **pages 58** and **59** of TDDI.

Two other very common useful commands are `Ctrl-Alt-D`, which displays 
documentation for the name under the cursor, and `Ctrl-Alt-R`, which 
reloads and type-checks the current buffer.  These are described in more detail
on **page 62** of TDDI.

Another useful command is `CTRL-ALT-L`, introduced on **page 72** of TDDI.
This is used in more complex situations filling a hole inline would be
unweildy and we would rather fill it with the result of a helper function.
Brady describes this as "lifting the hole to a top-level definition."
Another example of `CTRL-ALT-L` appears on **page 78**.

## 3.4 Implicit arguments: type-level variables
**page 82** This is an important section. It concludes Chapter 3.

--------------------------------------------------




# 4 User-defined data types 87
# 5 Interactive programs: input and output processing 123
# 6 Programming with first-class types 147
# 7 Interfaces: using constrained generic types 182
# 8 Equality: expressing relationships between data 208
# 9 Predicates: expressing assumptions and contracts in types 236
# 10 Views: extending pattern matching 258

# 11 Streams and processes: working with infinite data 291
# 12 Writing programs with state 324
# 13 State machines: verifying protocols in types 352
# 14 Dependent state machines: handling feedback and errors
# 15 Type-safe concurrent programming 403


# MISCELLANEOUS


## Atom Notes
With Idris came my first exposure to the Atom editor, so
it seems appropriate for me to include here some notes
Atom.

The following are some of the atom packages installed.

1. atom-latex
2. latex-completions
3. latextools
4. atomic-emacs
5. git-plus
6. language-idris
7. language-scala
8. merge-conflicts
9. minimap
10. pdf-view
11. markdown-preview-plus

Note: you should disable the default markdown-preview package, and set the following options in the markdown-preview-plus mode:  github style, enable latex rendering

To install a package, select the atom menus: Edit -> Preferences,
select `+ Install` from the list on the left, search for
the desired package name and hit return, wait for the search to
complete, then press the install button for the desired package.


## 