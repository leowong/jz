$(function() {
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

$(function() {
  $("#hide_notice").click(function() {
    $(".flash_messages").hide();
  });
});

$(function() {
  $("input[type=checkbox].task").live("click", function() {
    $(this).parent().next(".content").children(".task_name").addClass("busy");
    $.ajax({
      url: "/tasks/" + this.getAttribute("data-id"),
      type: 'PUT',
      dataType: 'script'
    });
    return false;
  });
});

$(function() {
  $('table.hoverable tr, #messages.hoverable .message').hover(
    function() {
      $(this).addClass('hover');
    },
    function() {
      $(this).removeClass('hover');
    }
  );
});
