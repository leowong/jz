$(document).ready(function() {
  var get_cities = function() {
    var province = $('#address_province_id').val();
    return city_mapper[province];
  }

  var update_city = function() {
    var cities = get_cities();
    var city_select = $('#address_city_id');

    if (cities) {
      var selected = city_select.val();
      city_select.html('');
      var cities_with_blank = [["", ""]].concat(cities);
      $.each(cities_with_blank, function(pos, id_nm) {
        var opt = $(document.createElement('option')).attr('value', id_nm[0]).html(id_nm[1]);
        if (selected == id_nm[0]) {
          opt.attr('selected', 'selected');
        }
        city_select.append(opt);
      });
      city_select.removeAttr('disabled').parent().show();
    } else {
      city_select.html('');
      var opt = $(document.createElement('option')).attr('value', '').html('');
      city_select.append(opt);
      city_select.parent().hide();
    }
  };

  if ($('#address_city_id').val() == "" ) {
    $('#address_city_id').parent().hide();
  }

  $('#address_province_id').change(function() {
    update_city();
  });
});
