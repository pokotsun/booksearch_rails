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

  // datepicker のイベント

  translateDate_to_Day = function(x) {
    console.log($(x));
    var x = x.split(' ');
    x[1] = x[1].split(',');
    var Day = parseInt(x[0], 10), Month = x[1], Year = parseInt(x[2], 10);
    var res = 0;
    res += (Year - 2000) * 365;
    switch(Month) {
      case 'January' :
      break;
      case 'February' :
      res += 31;
      break;
      case 'March' :
      res += 59;
      break;
      case 'April' :
      res += 90;
      break;
      case 'May' :
      res += 120;
      break;
      case 'June' :
      res += 151;
      break;
      case 'July' :
      res += 181;
      break;
      case 'August' :
      res += 212;
      break;
      case 'September' :
      res += 242;
      break;
      case 'October' :
      res += 273;
      break;
      case 'Nobember' :
      res += 303;
      break;
      case 'December' :
      res += 334;
      break;
      default :
      break;
    }
    res += Day;
    return res;
  };

  compDate = function(begin, end) {
    console.log(begin);
    if(begin != "") {
      var day_begin = translateDate_to_Day(begin),
      day_end = translateDate_to_Day(end);
      if(day_end - day_begin >= 0)
        return true;
    }
    return false;
  };

  var $begin_date = $("input[name='read_status[begin_date]']");
  var $end_date = $("input[name='read_status[end_date]']");
  $begin_date.change(() => {
  });
  $end_date.change(() => {
    if(!compDate($begin_date.val(), $end_date.val())) {
      Materialize.toast('読み始めた日がまだ未登録か、日にちに矛盾があります。', 5000);
    }
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
