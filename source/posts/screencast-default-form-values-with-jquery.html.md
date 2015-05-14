---
title: "Screencast: Default Form Values with jQuery"
date: "2010-01-04 03:46 PST"
tags: "javascript, jquery, screencast"
youtube_id: "Vah7N-HF6Vw"
---
A common effect for web forms is to show a default value in each input in gray text that disappears when the user clicks in it and returns when they click away without entering text. Learn how to do it using jQuery in this beginner level tutorial.


Note that in the blur handler, I accidentally used `$(this)` instead of `$this` (line 31 in the screencast and line 33 in the code below). This actually makes the point that either can be used and things will still work. However, it is more efficient to use `$this`.

~~~ html
<!-- index.html -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
  <title>Jimmy Cuadra Screencasts</title>
  <link href="reset.css" media="screen" rel="stylesheet" type="text/css" />
  <link href="screen.css" media="screen" rel="stylesheet" type="text/css" />
  <script src="jquery.min.js" type="text/javascript"></script>
  <script src="application.js" type="text/javascript"></script>
</head>
<body>
  <div id="bucket">
    <h1>Default Form Values with jQuery</h1>

    <form>
      <fieldset>
        <p><input type="text" value="First name" /></p>

        <p><input type="text" value="Last name" /></p>

        <p><input type="text" value="E-mail" /></p>

        <p><input type="text" value="Website" /></p>

        <p><textarea cols="50" rows="5">Enter your comments</textarea></p>
      </fieldset>
    </form>
  </div>
</body>
</html>
~~~

~~~ javascript
// application.js

$(function() {
  // 1. select all form inputs and the textarea
  $('form input').add('form textarea')
  
  // 2. add focus handler
  .focus(function() {
    // a. cache current element
    var $this = $(this);
    
    // b. set the default value if it hasn't been set
    if (!$this.data('default')) {
      $this.data('default', $this.val());
    }
    
    // c. blank out the field and change color to black
    //    if the user hasn't entered text in it
    if ($this.val() == $this.data('default')) {
      $this.val('')
      .css('color', '#000');
    }
  })
  
  // 3. add blur handler
  .blur(function() {
    // a. cache current element
    var $this = $(this);
    
    // b. return field to default value and change color to gray
    //    if the field is empty
    if ($this.val() == '') {
      $(this).val($this.data('default'))
      .css('color', '#666');
    }
  })
  
  // 4. change text color to gray
  .css('color', '#666')
});
~~~
