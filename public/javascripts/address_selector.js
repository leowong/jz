$(document).ready(function() {
  var province_select = $('#province_select select');
  var city_select = $('#city_select select');

  var get_cities = function() {
    var province = province_select.val();
    return city_mapper[province];
  }

  var update_city = function() {
    var cities = get_cities();

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
      city_select.parent().show();
    } else {
      city_select.html('');
      var opt = $(document.createElement('option')).attr('value', '').html('');
      city_select.append(opt);
      city_select.parent().hide();
    }
  };

  if (city_select.val() == "" || city_select[0].options[1] == undefined) {
    city_select.parent().hide();
  }

  province_select.change(function() {
    update_city();
  });
});
