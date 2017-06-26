// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  $('#edit-wrapper').hide();
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

  // タグのイベント定義
  // read_status_idの取得
  var read_status_id = $('#tag-wrapper').attr('data-read-status-id');
  // 初期化
  $.getJSON('/tag_api/?read_status_id='+read_status_id, function(data) {
    var names = [];
    $.each(data, function(val) {
      if(this.name != null) {
        names.push({tag: this.name});
      }
    });
    $('.chips-placeholder').material_chip({
      data: names,
      placeholder: 'Enter a tag',
      secondaryPlaceholder: '+Tag',
    });
  })


  // $.ajax({
  //   type: 'GET',
  //   url: '/tag_api/?read_status_id=10',
  //   dataType: 'json',
  // }).success(function(data) {
  //   var names = [];
  //   $.each(data, function() {
  //     if(this.name != null) {
  //       names.push(this.name);
  //     }
  //   })
  //   $('.chips-placeholder').material_chip({
  //     data: names,
  //     placeholder: 'Enter a tag',
  //     secondaryPlaceholder: '+Tag',
  //   });
  //   console.log(names);
  // }).error(function(data) {
  //   alert('error!!');
  // });
  $('.chips').on('chip.add', function(e, chip){
    console.log(chip);
    postData = {"read_status_id": read_status_id, "tag_name": chip.tag}
    console.log(postData);
    $.post('/tag_api/add', postData);
  });

  $('.chips').on('chip.delete', function(e, chip){
    console.log(chip);
    postData = {"read_status_id": read_status_id, "tag_name": chip.tag}
    console.log(postData);
    $.post('/tag_api/remove', postData);
  });

  $('.chips').on('chip.select', function(e, chip){
    console.log(chip);
  });

  $('.update_favorite_form').find('input[type=checkbox]').change(function() {
    $(this).parent().submit();
  });

});
