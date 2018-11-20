//= require handlebars-v4.0.11

var PeriodBro = function() {
};

PeriodBro.prototype.renderView = function(data) {
  var periodTemplateScript = $('#period_info_template').html();
  var periodTemplate = Handlebars.compile(periodTemplateScript);
  $('.periodTemplateTarget').empty();
  $('.periodTemplateTarget').append(periodTemplate(data));
  $('.datetime_format').datetimepicker({inline:false, format: 'Y-m-d H:i'})
};

PeriodBro.prototype.renderPeriodRow = function(rowId) {
  var periodRowTemplateScript = $('#periodRow').html();
  var periodRowTemplate = Handlebars.compile(periodRowTemplateScript);
  $('#payment_template_sessions').append(periodRowTemplate(rowId));
  $('.datetime_format').datetimepicker({inline:false, format: 'Y-m-d H:i'})
};

// Handlebars helpers

Handlebars.registerHelper('optionSelect', function(option, value) {
  if (option === value) { return 'selected'; }
});

Handlebars.registerHelper('tallySubTotal', function(building_price, land_price) {
  return new Decimal(building_price).plus(new Decimal(land_price));
});

Handlebars.registerHelper('setId', function(index, period) {
  var result = period || index;
  return result;
});
