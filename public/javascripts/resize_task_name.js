$(function() {
  $(window).resize(resizeTaskName).resize();
});

function resizeTaskName() {
  var w = $(window).width();
  w = w < 800 ? 800 : w;
  $(".main table.tasks .task_name").css("width", w * 0.7 - 243);
  $(".side table.tasks .task_name").css("width", w * 0.3 - 155);
}
