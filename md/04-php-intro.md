---
author: Arne Soete
date: m4_timestamp
title: PHP basics
---

# PHP Basics

> PHP is a widely-used general-purpose scripting language that is especially
> suited for Web development and can be embedded into HTML.
>
> [source: php.net](http://php.net){style="font-size:smaller;"}

This means PHP can be used to generate HTML. This allows us to adhere to the
[DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) <small> (<q>Don't
Repeat Yourself</q>) </small> principle.

## What makes a PHP-script

A PHP-script is identified by its `.php` extension and the PHP-tags in the file.

### PHP tags

PHP interprets only the code enclosed within the special PHP-tags.

* Opening tag: `<?php`
* Closing tag: `?>`

m4_embed_php(php-basics/php-tags)

Notice that the code outside of the PHP-tags is not interpreted and is printed out unchanged.

A valid PHP instruction generally has the form:

```php
{{ instruction }};
```

Each statement must be terminated by a semicolon (`;`)!

<small>
An exception to this rule are [loops](#loops) and [conditionals](#conditionals).
These can encapsulate a block of code in curly brackets `{}` and
thus end in a `}`...
</small>

### Comments

#### Single line comments

PHP will ignore everything behind a `#` or `//`.

```php

echo 'hello world';

// ignore this

# and ignore this

echo 'by world';

```

#### Multi-line comments

PHP will ignore everything enclosed by `/*` and `*/`.

```php

echo 'hello world';

/* ignore this

and ignore this */

echo 'by world';

```

### Execute a PHP-script

To get acquainted with php we will start of on the command line and work our
way up to PHP as a web server.


PHP at its core is a program which reads a source file, interprets the
directives and prints out the result.

Basic invocation:

```bash
php <script-to-execute>.php
```

The above command will print the output to the `STDOUT`.

### Hello World

The obligatory [hello world](https://en.wikipedia.org/wiki/%22Hello,_World!%22_program).

Create a file: `hello-world.php` with content:

m4_embed_php(php-basics/hello-world)

<small>
m4_info([[The echo statement prints a string. See [echo](#echo) for more info]])
</small>

<small>
m4_note([[If you get a _command not found_ error, you probably have to install
php. Run: `sudo dnf install php`]])
</small>

Run it via:

```bash
php hello-world.php
```
on the command line.

## Types and variables

Variables are a way to store some information and give the storage space a
name. Via this name, the content that was stored can be retrieved.

```php
$name = 'value to store';
```

A variable is identified by the leading dollar `$`-symbol followed by a alpha-numeric sequence.
m4_warning([[It is not allowed to start variable name with a number:

<div style="width: auto">
|                     |
|:---                 | :---
| `$abc`{.php}        | <span class="text-success">OK</span>
| `$abc123`{.php}     | <span class="text-success">OK</span>
| ~~`$123abc`{.php}~~ | <span class="text-danger">Not allowed</span>
</div>
]])

PHP knows two main types of variables:

* scalars
* arrays

### Scalars

A scalar variable can hold an atomic quantity. For example: one string, or one
number, ...

#### Types

PHP knows four scalar types:

+----------+-------------------------------+----------------------------------------------------------------------+
| Type     | Example                       | Description                                                          |
+==========+===============================+======================================================================+
| Integers | `42`{.php}                    | Whole numbers                                                        |
+----------+-------------------------------+----------------------------------------------------------------------+
| Floats   | `3.1415`{.php}                | Real numbers                                                         |
+----------+-------------------------------+----------------------------------------------------------------------+
| Strings  | `'Hello world'`{.php}         | Strings can be any number or letter in a                             |
|          |                               | sequence (enclosed by single `'` or                                  |
|          |                               | double `"` quotes, otherwise php may interpret it as a directive...) |
+----------+-------------------------------+----------------------------------------------------------------------+
| Boolean  | `true`{.php} or `false`{.php} | binary true or false                                                 |
+----------+-------------------------------+----------------------------------------------------------------------+

#### Declare

Assign a value to a variable:

_Generic syntax:_

```php
$varname = 'value to store';
```

Examples:

```php
$int    = 123;
$float  = 4.56;
$string = 'Hello World';
$true   = true;
$false  = false;
```

#### Printing/Displaying scalars

A scalar can be printed via two methods:

* m4_phpfunc(echo)
* m4_phpfunc(print)

##### Echo

_Generic syntax:_

```php
echo <scalar>;
echo <scalar1>, <scalar2>, ...;
```

Echo outputs the provided scalars.

Multiple scalars can be printed at once, just separate them by a comma `,`.

Example:

```php
echo 123;
echo 4.56;
echo 'Hello World';
echo true;
echo false;
```

##### Print

_Generic syntax:_

```php
print( <scalar> );
```

Print can only output one scalar at the time.
<small>(This can be circumvented via concatenation...)</small>

Example:

```php
print( 123 );
print( 4.56 );
print( 'Hello World' );
print( true );
print( false );
```

#### String concatenation and interpolation <small>Or single vs. double quotes</small>

Scalars can be combined, concatenated into larger strings.

The concatenation symbol is a dot: `.`.

m4_embed_php(php-basics/concatenate)

You may have already noticed that printing variables enclosed by single quotes `'` doesn't work. The literal variable name is printed instead.

m4_embed_php(php-basics/variables-in-single-quotes)

To instruct PHP to interpret the variables, and other [special
sequences](#special-character-sequences), the string must be enclosed by double
quotes: `"`.

m4_embed_php(php-basics/variables-in-double-quotes)

##### Special character sequences

The following special character sequences are interpreted by PHP and formatted accordingly...

+----------+--------------------------------------------------------+
| Sequence | Result                                                 |
+==========+========================================================+
| `\n`     | New line                                               |
+----------+--------------------------------------------------------+
| `\r`     | New line (Windows)                                     |
+----------+--------------------------------------------------------+
| `\t`     | The literal <TAB>-character                            |
+----------+--------------------------------------------------------+
| `\$`     | Literal `$` (escaping prevents variable interpreation) |
+----------+--------------------------------------------------------+
| `\"`     | Literal `"` (escaping prevents string termination).    |
+----------+--------------------------------------------------------+

Example:

m4_embed_php(php-basics/escape-sequences)

#### Basic arithmetic

Floats an Integers can be used in arithmetic.

+------------------+----------------+-------------------------------------------+
| Example          | Name           | Result                                    |
+==================+================+===========================================+
| `-$a`{.php}      | Negation       | Opposite of $a.                           |
+-----+------------+----------------+-------------------------------------------+
| `$a + $b`{.php}  | Addition       | Sum of $a and $b.                         |
+------------------+----------------+-------------------------------------------+
| `$a - $b`{.php}  | Subtraction    | Difference of $a and $b.                  |
+------------------+----------------+-------------------------------------------+
| `$a * $b`{.php}  | Multiplication | Product of $a and $b.                     |
+------------------+----------------+-------------------------------------------+
| `$a / $b`{.php}  | Division       | Quotient of $a and $b.                    |
+------------------+----------------+-------------------------------------------+
| `$a % $b`{.php}  | Modulus        | Remainder of $a divided by $b.            |
+------------------+----------------+-------------------------------------------+
| `$a ** $b`{.php} | Exponentiation | Result of raising $a to the $b 'th power.
|                  |                | <small>Introduced in PHP 5.6.</small>     |
+------------------+----------------+-------------------------------------------+

Example:

m4_embed_php(php-basics/arithmetic)

### Arrays

Arrays are able to hold more than one item.

An item is stored in the array at a named location. If no name/key/index is
explicitly specified, an numeric index from `0` to `n`
<small>(where n is the number of items in the array minus one)</small>
is used as the keys.

#### Declare

An array can be declared in two ways:

```php
$array = array( /* list of array items */ );

$array = [ /* list of array items */ ];
```

The `[]`-method can only be used from PHP version 5.4 and higher.

A normal typical array is a **list of values**.
The keys of those values are automatically assigned, starting with zero `0` and auto incrementing for each element added.

<small>See below for how to print and add values to arrays</small>

m4_embed_php(php-basics/array-auto-increment)

The keys can however be specified manually:

m4_embed_php(php-basics/array-custom-keys)

#### Print/Display arrays

The function m4_phpfunc(print_r) can be used to print an array.

_Generic syntax:_

```php
print_r( $array );
```

m4_embed_php(php-basics/print_r)

#### Get a value from an array

A value can be retrieved by specifying the array variable name followed by the index you wish to retrieve enclosed in square brackets:

```php
$array[<key>];
```

If the key is a string, the appropriate quoting must be used.

```php
$array['<key>'];
```

Example:

m4_embed_php(php-basics/array-get-key)

#### Update a value in an array

An array value can be targeted by its key. This key can also be used to update the value:

```php
$array[<key>] = <new value>;
```

Example:

m4_embed_php(php-basics/array-update-value)

#### Manipulating arrays

##### Add an item to the end of an array:

Adding an element at the end of an array can be accomplished by the function
m4_phpfunc(array_push) or by the square brackets notation (`$array[] = $value;`).

m4_embed_php(php-basics/array-append)

##### Add an item in front of an array:

Adding an element in front of an array can be accomplished by the function
m4_phpfunc(array_unshift).

m4_embed_php(php-basics/array-prepend)

##### Extract the first element from an array

Extracting the first element from an array can be accomplished by the function
m4_phpfunc(array_shift).

m4_embed_php(php-basics/array-shift)

##### Extract the last element from an array

Extracting the last element from an array can be accomplished by the function
m4_phpfunc(array_pop).

m4_embed_php(php-basics/array-pop)

##### Count the elements in an array

Counting the elements in an array can be accomplished by the function
m4_phpfunc(count).

m4_embed_php(php-basics/array-count)

### Special arrays

PHP has some special, reserved, arrays. These arrays are created and filled by PHP.

#### $argv

This array holds all the arguments passed to a PHP-script from the command line.

m4_run(php-basics,print_r-argv.php,[['arg1' 'arg2' 123 --options]])

<small>
m4_info([[Notice that the first argument in this array is always the name of
the script!]])
</small>

#### $_GET

The `$_GET`-array holds data sent to a webpage via a HTTP-get method.

This corresponds with URL parameters.

```bash
http://example.com/page.php?arg1=hello&arg2=world&end=!
```

```{.embed--output}
Array
(
    [arg1] => hello
    [arg2] => world
    [end] => !
)
```

#### $_POST

The `$_POST`-array holds data sent to a webpage via a HTTP-post method.

This is typically done via a from submission...

#### $_SESSION

You can store inter-page data in the `$_SESSION` reserved array.

This inter-page data is typically:

* user info
* preferences

#### $_FILES

When files are uploaded, PHP stores information about these files in this array.

Example:

```embed--output
Array
(
    [file] => Array
        (
            [name] => MyFile.jpg
            [type] => image/jpeg
            [tmp_name] => /tmp/php/php6hst32
            [error] => UPLOAD_ERR_OK
            [size] => 98174
        )
)
```

## Conditionals

It can be very handy to execute a piece of code only when certain requirements
are met. This kind of behaviour can be accomplished via conditionals

The `if` language structure defines the conditions to fulfil and the accompanying block
of code to run if the conditions evaluate to `true` (enclosed in curly brackets `{}`).

```php
if( /* <condition> */ ) {

    /* execute this code here */
}
```

Additionally an `else`-block can be defined. The code in this block will be
executed when the _`if`-condition_ evaluated to false.

```php
if( /* condition */ ) {

    /* execute when condition is true */
}
else {

    /* execute when condition is false */
}
```

On top of this, multiple conditions can be chained into an `if-elseif-else` construct.

```php
if( /* condition 1 */ ) {

    /* execute when condition 1 is true */
}
elseif( /* condition 2 */ ) {

    /* execute when condition 2 is true */
}
elseif( /* condition 3 */ ) {

    /* execute when condition 3 is true */
}
else {

    /* execute when conditions 1, 2 and 3 are false */
}
```

Conditionals can also be nested:

```php
if( /* condition 1 */ ) {

    if( /* condition 2 */ ) {

        /* execute when condition 1 and 2 evaluate to true */
    }
    else {

        /* execute when conditions 1 evalutes to true and condition 2 to false */
    }
}
else {

    /* execute when condition 1 evaluates to false*/
}
```

### Comparison operators

+-------------------+--------------------------+------------------------------------------------------------------------------+
| Example           | Name                     | Result                                                                       |
+===================+==========================+==============================================================================+
| `$a == $b`{.php}  | Equal                    | `true`{.php} if `$a` is equal to `$b` after type juggling.                   |
+-------------------+--------------------------+------------------------------------------------------------------------------+
| `$a === $b`{.php} | Identical                | `true`{.php} if `$a` is equal to `$b`, and they are of the same type.        |
+-------------------+--------------------------+------------------------------------------------------------------------------+
| `$a != $b`{.php}  | Not equal                | `true`{.php} if `$a` is not equal to `$b` after type juggling.               |
+-------------------+--------------------------+------------------------------------------------------------------------------+
| `$a <> $b`{.php}  | Not equal                | `true`{.php} if `$a` is not equal to `$b` after type juggling.               |
+-------------------+--------------------------+------------------------------------------------------------------------------+
| `$a !== $b`{.php} | Not identical            | `true`{.php} if `$a` is not equal to `$b`, or they are not of the same type. |
+-------------------+--------------------------+------------------------------------------------------------------------------+
| `$a < $b`{.php}   | Less than                | `true`{.php} if `$a` is strictly less than `$b`.                             |
+-------------------+--------------------------+------------------------------------------------------------------------------+
| `$a > $b`{.php}   | Greater than             | `true`{.php} if `$a` is strictly greater than `$b`.                          |
+-------------------+--------------------------+------------------------------------------------------------------------------+
| `$a <= $b`{.php}  | Less than or equal to    | `true`{.php} if `$a` is less than or equal to `$b`.                          |
+-------------------+--------------------------+------------------------------------------------------------------------------+
| `$a >= $b`{.php}  | Greater than or equal to | `true`{.php} if `$a` is greater than or equal to `$b`.                       |
+-------------------+--------------------------+------------------------------------------------------------------------------+

PHP is a dynamically type language. This means the type of a variable is not
set in stone but PHP will try its best to guess the types of variables and
convert them (juggle them from one type to the other) where its deemed
necessary.

For example:

m4_embed_php(php-basics/type-juggling)

<small>
m4_info([[m4_phpfunc(var_dump) prints a variable with type information]])
</small>

### Logical operators

Multiple comparisons can be bundled together into one condition. They are
combined via the logical operators:

+-------------------+------+--------------------------------------------------------------------+
| Example           | Name | Result                                                             |
+===================+======+====================================================================+
| `$a and $b`{.php} | And  | `true`{.php} if both `$a` and `$b` are `true`{.php}.               |
+-------------------+------+--------------------------------------------------------------------+
| `$a or $b`{.php}  | Or   | `true`{.php} if either `$a` or `$b` is `true`{.php}.               |
+-------------------+------+--------------------------------------------------------------------+
| `$a xor $b`{.php} | Xor  | `true`{.php} if either `$a` or `$b` is `true`{.php}, but not both. |
+-------------------+------+--------------------------------------------------------------------+
| `! $a`{.php}      | Not  | `true`{.php} if `$a` is not `true`{.php}.                          |
+-------------------+------+--------------------------------------------------------------------+
| `$a && $b`{.php}  | And  | `true`{.php} if both `$a` and `$b` are `true`{.php}.               |
+-------------------+------+--------------------------------------------------------------------+
| `$a || $b`{.php}  | Or   | `true`{.php} if either `$a` or `$b` is `true`{.php}.               |
+-------------------+------+--------------------------------------------------------------------+

Example:

m4_embed_php(php-basics/logical-operators)

These logical operators can be combined at will. Brackets `()` can be used to
enforce precedence.

m4_embed_php(php-basics/logical-precedence)


## Loops

Loops enable you to repeat a block of code until a condition is met.

### While

This construct will repeat until the defined condition evaluates to false:

```php
while( /* <condition> */ ) {

    /* execute this block */
}
```

m4_warning([[Incorrectly formatted code can result in an endlessly running
script. If this happens, use `Ctrl`+`c` on the command line to abort the
running script.]])

m4_danger([[The never ending loop:
```php
# This will run until interrupted by the user.

while(1) {

    echo "Use `Ctrl`+`c` to abort this loop\n";
}
```
]])

m4_embed_php(php-basics/loops-while)

m4_info([[
The pattern `$variable = $variable + 1` is used a lot in programming. Therefore
shorthand versions of this, and similar operations, are available:

```php
$var = 1;

# Add or substract by 1:
$var++; // increment by 1
$var--  // decrement by 1

# Add or substract by n:
# $var += n;
# $var -= n;

$var += 3;
$var += 100;
$var -= 42;
$var -= 4;
```
]])

m4_exercise([[
* Make a script that counts from 0 to 10
* Modify the script to count from 50 to 60
* Modify the script to count from 0 to 10 and back to 0
* Modify the script to count from 0 to 30 in steps of 3.

Only while loops are allowed.
]])

### For

For is similar to while in functionality. It also loops until a certain
condition evaluates to `false`. The main difference is the boilerplate required
to construct the loop.

The `for`-construct forces you to define the counter variable and the
increments right in the construct.

```php
for( <init counter>; <condition>; <increment counter> ) {

    /* execute this block */
}
```

Notice the semi-colons `;` between each of the `for`-parts!

m4_embed_php(php-basics/loops-for)

m4_exercise([[
* Make a script that counts from 1 to 10
* Modify the script to count from 0 to 10 and back to 0
* Modify the script to count from 0 to 30 in steps of 3.

Only for loops are allowed.
]])

The for construct can also be used to loop over all elements in an array:

m4_embed_php(php-basics/loops-for-array)

m4_exercise([[
* Fill an array with: [ one, two, three, four, five ];
* Print each word on a single line.
* Modify the script to also print the index before the word: `$index: $value`
]])

### Foreach

The for and the while construct have their limitations regarding arrays.
What if we have an array with custom keys (not a sequential list of integers...)?

We can solve this problem with the `foreach` construct. This construct is
specifically designed to iterate over array items.

```php
foreach( <array> as [<key-placeholder> =>] <value-placeholder>) {

    /* use key and value here*/
}
```

m4_info([[
The `key-placeholder =>` part is placed into square brackets to indicate that
this part of the construct is optional.
The part can be omitted when we have no need of the key in the accompanying
block but are only interested in the values...
]])

m4_embed_php(php-basics/loops-foreach)

## Commonly used (builtin) functions

[[###]] m4_phpfunc(isset)

The m4_phpfunc(isset) function checks whether a PHP variable was created / assigned.

This function returns false if the tested variable isn't declared before or is equal to `null`

m4_embed_php(php-basics/isset)

[[###]] m4_phpfunc(empty)

The m4_phpfunc(empty) function checks whether a PHP variable has an empty value.

Examples of empty values: `null`, `""`, `0`, ...

m4_embed_php(php-basics/empty)

[[###]] m4_phpfunc(strlen)

The m4_phpfunc(strlen) function returns the length (number of characters) in a string.

m4_embed_php(php-basics/strlen)

[[###]] m4_phpfunc(str_split)

The m4_phpfunc(str_split) function parses a string into individual characters and returns an array where each item in the array corresponds to one character in the original string.

m4_embed_php(php-basics/str_split)

[[###]] m4_phpfunc(explode)

The m4_phpfunc(explode) function parses a string into individual pieces based on a delimiter and returns an array where each item in the array corresponds to a section in the original string separated by the delimiter.

m4_embed_php(php-basics/explode)

This function can be used to convert the lines in a file (retrieved via m4_phpfunc(file_get_contents)) into an array of lines.

m4_embed_php(php-basics/explode-newline)

[[###]] m4_phpfunc(implode)

The m4_phpfunc(implode) function takes an array and _glue_ as input. The items in the array will be _glued_ together into a new string. Each of the sections in the new output string will be separated by the _glue_

m4_embed_php(php-basics/implode)

[[###]] m4_phpfunc(preg_match)

_Regular expressions_ are a very powerful way of detecting patterns in a string.

The complete depth and power of _regular expressions_ are out of the scope of this course but we will use them to detect header lines in multifasta sequences.

m4_embed_php(php-basics/preg_match)

## Exercises

m4_exercise([[
Create a script that:

* receives a number from the command line
* counts from zero to this number
* counts back from this number to zero
* counts from zero to the number in steps of three

m4_run(php-basics,count-to-number.php,9)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a script that prints a line of a asterisks `*` defined by a command line
parameter.

m4_run(php-basics,print-asterisks.php,9)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a script that

* prints a square of a asterisks `*` if one parameter is defined
* Prints a block with width and height if both parameters are defined.

m4_run(php-basics,print-square-of-asterisks.php,9)
m4_run(php-basics,print-square-of-asterisks.php,[[15 5]])
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a script that prints a left + bottom balanced triangle of asterisks with
base defined by parameter.

m4_run(php-basics,print-left-bottom-balanced-triangle.php,9)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a script that prints a right + bottom balanced triangle of asterisks with
base defined by parameter.

m4_run(php-basics,print-right-bottom-balanced-triangle.php,9)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a script that prints a center + bottom balanced triangle of asterisks with
base defined by parameter.

m4_run(php-basics,print-center-bottom-balanced-triangle.php,9)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create al the triangles again but the base (maximum number of asterisks) should
be on top instead of at the bottom...

m4_run(php-basics,print-left-top-balanced-triangle.php,9)
m4_run(php-basics,print-right-top-balanced-triangle.php,9)
m4_run(php-basics,print-center-top-balanced-triangle.php,9)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a script that counts the number of parameters provided

m4_run(php-basics,count-argv.php,[[9 12 3 5 4 1 8 5]])
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a script that:

* reads a list of numbers from the command line
* prints the list
* prints the number of numbers (count)
* calculates/prints the min, max and average of the numbers
* Print how many times a number occurs in the list
* (prints the list backwards (bonus))
* (prints the list sorted (bonus))

m4_run(php-basics,number-statistics.php,[[9 12 3 5 4 1 8 5]])
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a script which stores the keys of an array as values of another array.
(Extract the keys from an array)

```php
$array = array(
    'position 1' => 'hello',
    'position 2' => 'world',
    3            => 'three',
    'four'       => 4
);
```
m4_run(php-basics,array-keys.php)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
* Create a script which reverses an array.
* Create a script which reverses an array and preserves the keys

```php
$array = array(
    'position 1' => 'hello',
    'position 2' => 'world',
    3            => 'three',
    'four'       => 4
);
```

m4_run(php-basics,array-reverse.php)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a script that generates the reverse complement of DNA string:

m4_run(php-basics,dna-reverse-complement.php,'ATGCCGATAGGACTATGGACTATCTAGAGATCTATCAGAGAATATATCCGGGATAATCGGATATCGGCGATAC')

Bonus:

Print bonds:

m4_run(php-basics,dna-reverse-complement-with-bonds.php,'ATGCCGATAGGACTATGGACTATCTAGAGATCTATCAGAGAATATATCCGGGATAATCGGATATCGGCGATAC')

<small>
m4_info([[The PHP functions: m4_phpfunc(str_split) amd m4_phpfunc(strlen) can be of use.]])
</small>
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a script that generates the reverse complement of DNA string and can cope with:

* with Caps and non caps letters
* white space
* unvalid nucleotides (and report these)

m4_run(php-basics,dna-reverse-complement-robust.php,[['ATgCXCgAtAgg  ACTAtgGaCtA X  TCtA g aGaTc TatCAgAgaatAtiXXATCcgggATAATcggAtATCggCGaTaC']])
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a script that prints the nucleotide frequency of a DNA strand.

Additional: Create a simple bar plot to visualise the percentages.

m4_run(php-basics,dna-frequency.php,'ATGCCGATAGGACTATGGACTATCTAGAGATCTATCAGAGAATATATCCGGGATAATCGGATATCGGCGATAC')
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a script that prints the frequency of the characters in a string.

* sort by frequency: low to hight + high to low
* sort by character (and reverse)
* case-insensitive (bonus)

m4_run(php-basics,character-frequency.php,[['Hello world, this is a random 123#$ string.']])

<small>
m4_info([[See: m4_phpfunc(sort), m4_phpfunc(asort), m4_phpfunc(ksort),... for
different sort functions]])
</small>
]])
