# Documentation

Emerald is a small functional & array-based programming language that is designed to be easy to
learn and use. It's set of functions is growing very fast and it's a
work in progress. But it's also a very good language to learn and use.

## Comments

Just prefix them with a `#` like in Python or Ruby.

## The Hello World program

The first program you should write is the Hello World program. It's a
very simple program that prints the text "Hello World" on the screen. To
first use it, you need to install the Emerald interpreter. Usually, you
just need to run `ruby main.rb` if you have Ruby.

    Emerald REPL
    λ

What you need to do is press Ctrl+C. Now create a file called
`hworld.em` and write the following code:

    print: Hello World

Then, in the command to run, run the command, but append `hworld.em` to
the end of the command. You should see `Hello World`. You can swap
`Hello World` with something else.

## Adding numbers

To add numbers, you use the add function. To do that, run this code to
add 5+2:

    add: 5 2

Notice that it didn't output anything. To output the result, run this:

    add: 5 2
    usevariable: add print {}

Essentially, it's saying to the computer:

> Add 5+2, and store that into a variable called `add`.
>
> Now, get `add`'s contents and print it out.

We will talk more about `usevariable`.

## Subtracting/Multiplying/Dividing

The syntax is exactly the same as `add`, but use the correct operator.
Here is a little chart:

`subtract` for subtracting

`multiply` for multiplying

`divide` for dividing

Also, the variable name to use is the exact same as the operator.

## User input

One thing about interactive CLI programs is that they use input
functions. Be it a Python app, Java app, or even an Emerald app. The
syntax for the input function is actually the same as Python's. Here is
an example of `input`:

    input: What's your name?
    usevariable: input print Howdy, {}

Note that functions that are supposed to return things, actually create
a variable. This is normal.

## If statements

One of the trickiest things in programming, are if statements. In
Emerald, `if` is easy. Here are some examples:

    # Does not output anything
    if: Howdy is: Hello print: Something's wrong...
    # Says it's incorrect
    if: Howdy is: Hello print: Something's wrong... else: print Yup. That's incorrect.
    # Says something's wrong
    if: Howdy not: Hello print: Something's wrong... else: print Yup. That's incorrect.

Here are some templates:

If statement, is, w/o else:

    if: <Candidate 1> is: <Candidate 2> <Code to run>

If statement, not, w/o else:

    if: <Candidate 1> not: <Candidate 2> <Code to run>

If statement, is, with else:

    if: <Candidate 1> is: <Candidate 2> <Code to run> else: <Code to run for else>

If statement, not, with else:

    if: <Candidate 1> not: <Candidate 2> <Code to run> else: <Code to run for else>

### `>, <, <=, =>`

- For greater than, use `greater` instead of `is`.
- For less than, use `less` instead of `is`.
- For less than or equal to, use `lessequal` instead of `is`.
- For greater than or equal to, use `greaterequal` instead of `is`.

## Infinite loops

Some programs might need infinite loops. They use them to say, hang for
a CI to not stop. Again, the syntax is really simple:

    loop: <The code you want to loop>

Here's an example that prints `Emerald` forever:

    loop: print: Emerald

## Variables

### `variable`

The syntax for `variable` is simple. Here's an example of using it:

    variable: x No adult stuff please.

### `usevariable`

Again, the syntax for `usevariable` is simple. Note that you use an `{}`
in place of the variable's contents. Here's how you use it:

    variable: a HTML Anchor Tag?
    usevariable: a print What is a {}

### Lists/Arrays

Create lists by using `list`. It's usage is like `variable` but with a difference, it's value is `SSV`, space seperated values. When built, the core variable is actually a Ruby array.

As a replacement for classes/objects, Emerald uses a much simpler list, and the keys are numbered. Also, with modules, and you want to store functions you will have to do it like this:

```
rubycode: varlist["MyCoolList"] = ["yeah, you can have spaces here", "print: hello", "they're actually functions that are being executed"]
```

Here's how it works:

```
list: animals Pigs Cows Sheep Chickens
```

#### For loop

The for loop is like `usevariable`.

```
for: animals print: {}
```

#### Range

Ranges are simple. A range is created by `range` like so:

```
range 50
# for: range print: {} # 0 1 2 3 4...
```

#### Getting indexes

You can get indexes from a list using `getindex` like so:

```
getindex: <list> <index>
```

`index` is a value 0 or higher, and 0 is the first index.

### Functions

To create functions, you do it like this:

    function: print_hworld_on_sep_lines print: Hello;print: World
    # Run the function
    print_hworld_on_sep_lines:

You don't have to have a semi-colon; it's only for functions with
multiple lines.

## System calls

Running system calls is very straight forward, and has the same syntax
as Ruby. Here's how you use it:

    system: echo I'm outside Emerald...

## Modules

Modules are also straight forward. You see the theme, right? To import a
module, run this snippet:

    require: <The name of the module>

They can also be Ruby extensions, which in-turn can be used to create C extensions. Ruby extensions are used like this:

```
rubyext: some_extension.rb a_function: arg1 arg2 arg3
```

Ruby extensions also use `args`. So, `args[0]` would be `a_function`. Built-in functions use `tok`.

Ruby extensions are much preferred, because they support variable-less arguments, meaning you don't need to create a bunch of variables as arguments.

In Ruby extensions, variables can be referenced like `varlist["variable_name"]`.

The precursor to Ruby extensions is the `rubycode` API, which is like this:

```
rubycode: puts hi
```

### Installing Modules

In the REPL or in a script, you can do this:

```
pkginstall: <the package name>
```

# You did it!
