// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  $('#edit-wrapper').hide();

  $('.chips-placeholder').material_chip({
    data: [{
      tag: '一気読み',
    }, {
      tag: '泣ける',
    }, {
      tag: '犬が出てくる',
    }, {
      tag: 'てか普通に怖い'
    }],
    placeholder: 'Enter a tag',
    secondaryPlaceholder: '+Tag',
  });
  $('.datepicker').pickadate({
    selectMonths: true, // Creates a dropdown to control month
    selectYears: 17 // Creates a dropdown of 15 years to control year
  });

  $( '.evaluation-range' ).on( 'input', function () {
    var val = $(this).val();
  } );
  /* 変更後 */
  $( '.evaluation-range' ).change( function () {
    var val = $(this).val();
    $('#evaluation-score').text(val + '点');
  } );

  $('.input-genre-field').ready(function() {
    $('select').material_select();
  })

  $('.edit-button').click(function(){
    $('#impression-wrapper').hide();
    $('#edit-wrapper').show();
  });

  $('.save-button').click(function(){
    $('#edit-wrapper').hide();
    $('#impression-wrapper').show();
  });

  $('.cancel-button').click(function(){
    $('#edit-wrapper').hide();
    $('#impression-wrapper').show();
  });

  $("#submit").click(function() {
    $(".book_search input[type=submit]").click();
  });

  $("form.book_search").change(function() {
    $(".book_search input[type=submit]").click();
  });

  var number;
  $(function(){
    $('input[name="ever-read"]').click(function(){
      if($(this).val() == number) {
        $(this).prop('checked', false);
        $(".book_search input[type=submit]").click();
        number = 0;
      } else {
        number = $(this).val();
      }
    });
  });

  $('#favorite-check').on('check', function() {
    if($(this).val()) {
      $(this).prop('checked', false);
    }
    else {
      $(this).prop('checked', true);
    }
  });

  // ページネーションのajax化
  $("pagenator-wrapper").html("<%= j(render partial: 'partial/pagination', locals: {book_pages: @books}) %>");
  $("pagenator-wrapper").append("<%= j(render partial: 'partial/pagination', locals: {book_pages: @books}) %>");

});
