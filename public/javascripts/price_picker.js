var get_price = function(product_id) {
  return price_mapper[product_id];
};

var update_price = function(select_object) {
  $(select_object).next('.product_price').val(get_price($(select_object).val()));
};
