$(function() {
  $.datepicker.setDefaults($.datepicker.regional["zh-CN"]);
  $("#task_due_at").datepicker({dateFormat: "yy/mm/dd"});
});
