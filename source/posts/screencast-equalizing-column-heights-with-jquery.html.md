---
title: "Screencast: Equalizing Column Heights with jQuery"
date: "2009-09-16 04:38 PDT"
tags: "javascript, jquery, screencast"
youtube_id: "Sxfmroc7p50"
---
In this first screencast, I present the common problem of making the background of a floated sidebar stretch to the height of the neighboring content element and provide a simple solution using JavaScript and jQuery.

The solution uses jQuery to loop through each column on the page, find the tallest column, and set the heights of all columns to that value. Here is the script:

~~~ javascript
$(function() {
  var tallest = 0;
  var $columnsToEqualize = $(".column");
  $columnsToEqualize.each(function() {
    var thisHeight = $(this).height();
    if (thisHeight > tallest) {
      tallest = thisHeight;
    }
  });
  $columnsToEqualize.height(tallest);
});
~~~

Remember to load the jQuery library first.
