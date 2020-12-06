---
author: Arne Soete
date: m4_timestamp
title: IO
---

# IO

By IO we mean working with files...

## Read a file

There are multiple ways to read a file:

* m4_phpfunc(file)
* m4_phpfunc(file_get_contents)

are most important ones.

### File

The m4_phpfunc(file)-function takes a filename as argument and returns an array
where each array item corresponds to a line in the file.

```php
$lines = file('/path/to/file.txt');
```

### File_get_contents

This function takes a filename as argument and returns a string containing the
complete file contents (hence the name).

```php
$complete_contents = file_get_contents('path/to/file.txt');
```

## Create/Write a file

### Touch

m4_phpfunc(touch) can be used to update the modification date of a file. If the
file doesn't exist yet, it will be created.

```php
touch('new-file.txt'); // create new-file.txt
touch('new-file.txt'); // update modifaction timestamp of new-file.txt
```

### Write

m4_phpfunc(fwrite) can be used to write contents to a file handle.

A handle can be created via m4_phpfunc(fopen).

```php
$handle = fopen('file.txt', 'w'); // 'w' indicatets open file for writing
fwrite($handle, 'Hello world'); // Write hello world to opened file
fclose($handle); // close file
```

This sequence of opening, writing and closing a file is quite cumbersome,
therefor a shorthand is also available: m4_phpfunc(file_put_contents).

```php
$nr_bytes_written = file_put_contents('/path/to/file.txt', $file_contents );
```

## Remove a file

A file can be deleted via m4_phpfunc(unlink).

```php
$delete_ok = unlink('/path/to/file.txt');
```

## Rename a file
A file can be renamed via m4_phpfunc(rename).

```php
$rename_ok = rename('/path/to/file.txt', '/path/to-new-filename.txt');
```

## Directories

Similar functions exist for directories:

* m4_phpfunc(mkdir): Create directory

    ```php
    mkdir('/path/to/dir');
    ```
* m4_phpfunc(rmdir): Delete directory

    ```php
    rmdir('/path/to/dir');
    ```
* m4_phpfunc(rename): Rename directory

    ```php
    rename('/path/to/dir', '/path/-to-new-dirname');
    ```

### List all files in a directory:

* m4_phpfunc(readdir): Iterate over the files in a directory-handle

    ```php
    $handle = opendir('/path/to/dir');

    while (false !== ($file = readdir($handle))) {

        echo "$file\n";
    }
    ```
* m4_phpfunc(glob): List all files in a directory (as array) matching a certain
  pattern.

    ```php
    $files = glob('/path/to/dir/*.php');
    ```

## Upload files

File can be uploaded via a form-submission. The tag used to specify files is:

```html
<input type="file" name="uploaded-file">
```

m4_info([[In order to use the `input[type=file]`, the form **must** specify the
`enctype`-attribute:

```html
<form action="#" method="post" enctype="multipart/form-data">

    <input type="file" name="uploaded-file">

    <input type="submit" value="submit" name="submit">
</form>
```
]])

When a form containing files is submitted the `$_FILES` special PHP-variable is
populated with the file(s) currently uploading:

```
$_FILES = Array
(
    [uploaded-file] => Array
        (
            [name] => MyFile.txt             // name of the file
            [type] => text/plain             // filetype
            [tmp_name] => /tmp/php/php1h4j1o // php stores the file in a randomized tmp location
            [error] => 0                     // 0 = UPLOAD_ERR_OK --> no errors
            [size] => 123                    // the size in bytes
        )

    [file2] => Array
        (
            [name] => MyFile.jpg
            [type] => image/jpeg
            [tmp_name] => /tmp/php/php6hst32
            [error] => UPLOAD_ERR_OK
            [size] => 98174
        )
)
```

PHP stores the uploaded file in a temporary location. We must use the files
contents or move the file to a different location. At the next request this
`tmp_name` will be something else. So keep this in mind.

If we opt not to read the file and process it, but move the file instead, the m4_phpfunc(move_uploaded_file) should be used to move a file to a new destination.

This function has some additional checks builtin and is thus the recommended
way to move uploaded files:

```php
move_uploaded_file('/tmp/php/php1h4j10', '/home/me/some-file.txt');
```

## Exercises

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a web-page which allows to upload a file, and print the contents of the file.

m4_page(io/cat)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a web-page which allows to upload a file, and:

* report line-, word-a and character-count in a table
    - nicely spaced cells
    - lines, words, characters as rows but bold (headers)
* list the top 10 most frequent words.
    - use a list but show all items aside each other (one line).

m4_page(io/wc)
]])


m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a web-page which allows to upload or paste multi-fasta data and:

* report number of sequences
* print the sequences:
    - fasta header is bold
    - nucleotides are monospaced, 80 characters wide
* report GC-content per sequence

m4_page(io/format-fasta)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a web-page which allows to upload or paste multi-fasta data and:

* print the sequences:
    - fasta header is header
    - (inter)link to fasta blocks
    - nucleotides are monospaced, 80 characters wide
    - each nucleotide should have its own color:
        - A: red
        - T: yellow
        - G: green
        - C: blue
* Display the nucleotide frequencies in a bar graph. (A: xx%, T: xx%, ...)

m4_page(io/color-fasta)
]])
m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a web-page which allows to upload a file or paste some text, and specify
a list of terms.

- Print the uploaded/pasted text
- Highlight all the specified terms in the uploaded/pasted text. (for example
  each term starts at a new line in a textarea)
- Extra: allow the user to specify the color per term.
  For example:
    ```
    the|red
    a|green
    an
    ```

m4_page(io/highlight-words)
]])


m4_dnl m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a paste-bin web-app. The app allows the user to create a new snippet and
save it (eq. write to file) via a webpage. The user can browse all snippets and
view them by clicking a link...

This app is composed out of three pages:

1. index: list all the uploaded snippets
2. upload: a form:
    - snippet name
    - contents
   Allow the user to specify a new snippet to store. Make sure:
    - no empty snippets or snippets with no name can be uploaded.
    - snippet name doesn't already exists.
3. snippet contents: show the contents of a snippet

m4_page(io/snippets/index,250px)
]])
