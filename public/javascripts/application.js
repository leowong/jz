$(document).ready(function() {
  var timer = undefined;

  $("#contacts_search input").keyup(function() {
    if (timer != undefined) {
      clearTimeout(timer);
    }
    timer = setTimeout(search, 250);
    return false;
  });

  var search = function () {
    $.get($("#contacts_search").attr("action"), $("#contacts_search").serialize(), null, "script"); 
  };
});
