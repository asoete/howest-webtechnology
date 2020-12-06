---
author: Arne Soete
date: m4_timestamp
title: PHP and HTML
---
# PHP and HTML

## PHP Webserver

PHP has a built in web-server. This means that no external server like Apache or Nginx is required to start a web-site and interlink the pages on this site.

### Starting a server

The server is started with one command on the command line:

```bash
php -S localhost:<port> [-t /path/to/folder]
```

Example:

```bash
php -S localhost:8080
```

This previous command will start a web-server in the current working directory
and will be accessible at the URL: `http://localhost:8080`.

You can pick any port, as long as it is between 1024 and 65535. By convention
`8000` or `8080` are picked because of the resemblance with the official
HTTP-port: `80`.

As mentioned before, by default the server will start in the current working
directory. If you wish the root of the site to be another directory, specify it
via the `-t` option.

m4_info([[More info about this command can be found by executing the `man php`
command on the command line.]])

By default the web-server will search and execute serve the `index.html` or
`index.php` file in the servers root directory. (root directory = the directory
where the server was started)

### Making a simple page

```bash
mkdir my-website
cd my-website
echo "Hello world" > index.html
php -S localhost:8080
firefox localhost:8080
```

You should be greeted with `Hello world`...

Because the web-pages are served via a PHP server, all PHP files (ending in
`.php`) will be interpreted by the webserver.
This allows us to generate the HTML content dynamically.

### Exercises

m4_exercise([[
Create a PHP page that prints `hello world` when served by a web-server

m4_embed(php-and-html/hello-world,70px)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a PHP page that resembles your CV.

m4_embed(php-and-html/cv,250px)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a web-page that prints

* an ordered list of three your three favourite dishes (dynamically)
* a list of (three) hobbies

m4_embed(php-and-html/list-hobbys-and-dishes,180px)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create three web-pages that interlink to one another.

* Home
    * Title
    * Name
    * Age
* hobbies
    * Title
    * list
* Favourite dishes
    * Title
    * list

m4_embed(php-and-html/inter-link-pages/home,250px)
]])


## Include / Require

PHP allows us to include one file into another. This is done via the m4_phpfunc(include) or m4_phpfunc(require);

The difference between the two is that `require` will fail if the specified file
can't be included where `include` will merely warn about the failed inclusion.

```php
include('path/to/file.php');

require('path/to/another-file.php');
```

m4_exercise([[
Create a web-page who includes another file.
]])

## Forms

Forms can be used to send data from the web-page to the server. This data can
be read and processed via PHP.

A form is composed out of a form-tag and data tags.

### Form tag

```html
<form action="<action>" method="<method>">
    <!-- content -->
</form>
```

The form tag has two required attributes:

* action
* method

#### Action

This attribute specifies the page the data should be sent to.

To send the data back to the same page, specify: `#` or the URL of the current
page.

```html
<form action="#"></form>
<form action="http://server.com/script-handle-data,php"></form>
```

#### Method

The method defines how the data should be send to the server.

There are two main methods:

* GET
* POST

##### GET

`GET` mains appending the data as URL parameters.

Say we want to send the username and the age of a user back to the server, the URL could look like this:

```
http://server.com/script-to-handle-data.php?username=johnd&age=21
```

This method has two gotchas:

1. The data is sent visible to the server. **Never use this method to send
   sensitive data** back to the server.
2. The number of characters allowed in an URL is limited. So large amounts of data can not be sent this way...


An advantage of this method is that the URL with the data attached can be
bookmarked or shared.

##### POST

`POST` The post method comes in where `GET` falls short.

The data is sent in the body of the HTTP request and is this invisible and not
limited by size.

This method is most often used to send data from forms back to the server

```html
<form action="#" method="get"></form>
<form action="#" method="post"></form>
```

### Data tags

Other special tags are used to present or request data from the user.

In order to send the data, contained in the elements, back to the server, the
name attribute must be set on the elements. This name can than be used on the
backend to retrieve the values entered by the user.

#### Input

```html
<input type="text" value="" name="">
```

The input tag encompasses a lot of _"data types"_. The `type`-attribute can be used to modify the behaviour of this tag.

Types:

* checkbox
* email
* file
* number
* password
* radio
* text

The value attribute holds the default value of the element. If not defined,
the element will be empty.

The `radio` and `checkbox` type don't take a value (only) but a state, the
`checked` replaces the value attribute.

m4_embed_php_as_html(php-and-html/input,330px,.html)

m4_note([[In order to send files to the server, the form attribute: `enctype`
must be set to `multipart/form-data`
```html
<form action="#" method="post" enctype="multipart/form-data"></form>
```

See later for more details on how to upload files...
]])

#### Select

The select tag allows the user to choose options out of a predefined set:

```html
<select name="name-sent-backend">
    <option value="1">Option 1</option>
    <option value="2">Option 2</option>
    <option value="3">Option 3</option>
</select>
```

As can be seen in the example, a select is composed out of multiple options.

The default behaviour is that only one option can be selected at once.

This can be altered via the `multiple`-attribute.

m4_embed_php_as_html(php-and-html/select,200px,.html)

Sub-group can be created via `optgroup`

m4_embed_php_as_html(php-and-html/select-groups,200px,.html)


#### Textarea

To send a block of text back to the server, use a `textarea`.

m4_embed_php_as_html(php-and-html/textarea,100px,.html)


#### Label

The label is not an input/data tag, but a meta-data tag.

This tag is used to add information about a data-tag. For example: label a
password field as a password field.

A side benefit of using lables is that clicking a label, will automatically
focus it's corresponding data element.

m4_embed_php_as_html(php-and-html/label,150px,.html)

## PHP special data arrays

When data is sent to a PHP server, PHP will automatically populate the
corresponding special array according/

Special arrays:

* `$_GET`: Holds al the data sent via the GET method.
* `$_POST`: Holds al the data sent via the POST method.
* `$_REQUEST`: Holds al the data sent via GET and POST combined.
* `$_FILES`: Holds all the info about the uploaded files.

Example:

```html
<form action="#" method="post">
    <input type="text" value="Hello World" name="name">
    <input type="number" value="21 World" name="age">
    <input type="submit" value="Submit" name="submit">
</form>
```

```php
print_r( $_POST );

/*
Array(
    [name] => "Hello World",
    [age] => 21
)
*/
```

This data can now be processed via PHP.

To test if data was submitted, the value of the _submit button_ can be used.

In the previous example was the value: `submit`.

```php
if( isset( $_POST['submit'] ) ) {

    /* Do stuff with data */
}
```

## Exercises

m4_exercise([[
Create a webpage with a login form:

* first name field
* last name field
* gender radio button
* age field
* email address
* password field
* _"I want to receive updates"_ checkbox

m4_page(php-and-html/form,250px)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[Print a rainbow pyramid, each column should have it's own color

* red
* orange
* yellow
* green
* blue
* indigo
* violet

m4_embed(css/rainbow-pyramid)
]])

m4_dnl ------------------------------------------------------------------------

m4_exercise([[
Create a login form with a

* name field
* age field

Please validate if a user is older than 21.

Print an _access granted_ or _denied_ accordingly.

(Extra: Show error when a field is not filled...)

(Extra II: print how many years the user should wait before resubmitting the form...)

m4_page(php-and-html/access-control, 200px)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a parrot. Everything you submit must be echo-ed back to the screen.

Extra: append words to previous input...

m4_page(php-and-html/parrot)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a webpage that generates a triangle.

* The base of the triangle should be dynamically defined via a from submission or specified in the URL
* The character the triangle is composed of should be dynamically defined via a
  from submission or specified in the URL
* Extra: re-fill fields with previously entered values

m4_page(php-and-html/dynamic-triangles,300px)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a tool that validates passwords.

* Password should be entered twice and be the same.
* Password should be more than 8 characters
* (extra) Password should have at least one number and letter.

m4_page(php-and-html/validate-passwords,250px)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a tool that generates passwords.

* The number of characters should be defined by a form submission or in the URL.
* There should be the possibility (option) to include numbers in the generated password (via form or URL).
* You should be able to specify the number of passwords generated (via form or URL).
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Make a web-page where you can paste and upload text and the tool should should:

* calculate and report the number of lines uploaded
* calculate and report the number of words uploaded
* calculate and report the number of characters uploaded
* Report the results in an table.

m4_page(php-and-html/wc,250px)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Make a webpage where you can upload comma separated data and convert it into a
table.

* Extra: add option: make the first row headers
* Extra: throw error if number of fields is incorrect

```
first name, last name, gender, age
john, doe, male, 21
jane, doe, female, 18
jake, smith, male, 20
joan, d'arc, female, 33
```

m4_page(php-and-html/csv,250px)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a webtool which generates random sequences. The specifics of the sequence should be configurable:

Allow the user to specify:

* Sequence header (if not defined use: `Random sequence #1`)
* The alfabet the sequence should be composed of (if not defined use `ATGC`)
* The total number of nucleotides (default: `250`)
* The number of nucleotides per line (default: `50`)
* (Extra: Add the option (specify the number of sequences to generate) to
  generate multi-fasta e.g. generate multiple sequences: `Random sequence #1`,
  `Random sequence #2`, ...)

m4_page(php-and-html/fasta-generator,300px)
]])

m4_dnl -----------------------------------------------------------------------

m4_exercise([[
Create a _post comment_ form with fields:

* name
* email
* title options: (Dr, Mr, Ms, Ir)
* comment box
* post anonymous checkbox.

Validate:

* Name and/or email are not empty (unless _post anonymous_ was checked)
* Comment has max 500 characters

* Print a red error messages if a validation failed + indicate which field failed
  validation, in red.
* If an error occurred pre-fill the elements with the valid data
* If no errors occurred,
    * ( Mr. or Ms. ) (name or _anonymous_) posted:
    * print _message posted_ in gray.

m4_page(css/post-comment,400px)
]])
