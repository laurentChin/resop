const $ = require('jquery');
require('bootstrap');

$(document).ready(function () {
  $('.trigger-delete').on('click', function (e) {
    e.preventDefault();

    $('#to-delete-name').html($(this).data('display-name'));
    $('#confirm-update').data('url', $(this).data('href'));

    $('#delete-item-modal').modal('show');
  });

  $('#confirm-update').on('click', function () {
    window.location = $(this).data('url');
    $(this).closest('.modal').modal('hide');
  });
});
