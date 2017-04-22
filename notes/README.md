# notes


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
