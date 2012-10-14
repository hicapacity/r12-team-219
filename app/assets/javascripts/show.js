$(function() {
 // Handler for .ready() called.
 $('#source').val('#HELLO');

  // Forcing Hallo to update HTML after loading the markdown
  var e = $.Event('keyup');
  $('#source').trigger(e);

  $('#source').hide();
  $('#content').hallo({editable: false});
  $('#save').hide();
  $('#cancel').hide();

 $('#edit').click(function() {
  $('#source').show();
  $('#content').hallo({editable: true});
  $('#edit').hide();
  $('#save').show();
  $('#cancel').show();
 });
});