//= require jquery3

// セレクトボックスの選択時、form の action を data-action に動的に変更
$(function() {
  $('select[id=interview_status]').change(function() {
    var val = $('select[id=interview_status] option:selected').data('action');
    $(this).parents('form').attr('action', val);
  });
});
