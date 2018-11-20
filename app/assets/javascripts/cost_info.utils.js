//= require handlebars-v4.0.11

var CostStore = function() {
  this.properties = null;
  this.houses = null;
  this.parkings = [];
  this.total_price = 0;
  this.parkings_price = 0;
  this.houses_price = 0;
  this.reservation_price = 0;
  this.reservation_main_building_final_price = 0;
  this.reservation_sub_building_final_price = 0;
  this.reservation_public_area_final_price = 0;
  this.reservation_parking_final_price = {};
};

CostStore.prototype.makeAjax = function(resource, id, cb) {
  if (this.checkEmptySelection(resource, id)) { return; };
  $.ajax({
    url: '/admin/' + resource + '/' + id + '.json',
    dataType: 'json',
    type: 'GET',
    success: cb,
    error: function(err) {
      console.log('error', err);
    }
  });
};

CostStore.prototype.checkEmptySelection = function(resource, id) {
  if (!!id === false || (id.length === 1 && id[0].length === 0)) {
    this[resource] = resource === 'parkings' ? [] : null;
    return true;
  }
};

CostStore.prototype.setProperty = function(prop_id) {
  var self = this;
  self.makeAjax('properties', prop_id, function(data) {
    self.properties = data.property;
    self.renderView();
    var trustNumber = $('#reservation_property_attributes_trust_number');
    trustNumber.val(costStore.properties.trust_number);
  });
};

CostStore.prototype.setHouse = function(unit_id) {
  var self = this;
  self.makeAjax('houses', unit_id, function(data) {
    self.houses = data.result;
    self.renderView();
  });
};

CostStore.prototype.setParkingSpot = function(unit_id) {
  var self = this;
  self.parkings = [];
  if (unit_id === null || unit_id.length === 0) {
    self.renderView();
  } else {
    self.makeAjax('parkings', unit_id, function(data) {
      data.result.forEach(function(spot) {
        self.parkings.push(spot);
      });
      self.renderView();
    });
  }
};

CostStore.prototype.setFinalPrice = function(prop, val, parking_id) {
  var self = this;
  var cost = new Decimal(val || 0);
  if (prop === 'reservation_parking_final_price') {
    var _parkings_price = new Decimal(0);
    self.reservation_parking_final_price[parking_id] = cost;
    for (var spot in self.reservation_parking_final_price) {
      if (self.reservation_parking_final_price.hasOwnProperty(spot)) {
        var price = new Decimal(self.reservation_parking_final_price[spot]);
        _parkings_price = _parkings_price.plus(price);
        self.parkings_price = _parkings_price.toFixed();
      }
    }
  } else {
    self[prop] = cost.toFixed();
    self.houses_price = new Decimal(self.reservation_main_building_final_price).plus(new Decimal(self.reservation_sub_building_final_price)).plus(new Decimal(self.reservation_public_area_final_price)).toFixed();
    self.reservation_price = self.houses_price;
  }
  self.total_price = new Decimal(self.parkings_price).plus(new Decimal(self.houses_price)).toFixed();
  self.renderView();
};

CostStore.prototype.renderView = function() {
  var self = this;
  var costTemplateScript = $('#cost_info_template').html();
  var costTemplate = Handlebars.compile(costTemplateScript);
  $('.costTemplateTarget').empty();
  $('.costTemplateTarget').append(costTemplate(self));
  $('#payment_period_account_receivable').val($('#grandTotal').text().replace(/\s\D/, ''));
};

// Shared functions for Handlebars usage

CostStore.prototype.tallyTotal = function(prop, attr) {
  if (prop === null) { return 0; };
  var result = new Decimal(0.00);
  prop.forEach(function(unit) {
    result = result.plus((unit[attr]));
  });
  return result === 0 ? '--' : result;
};

CostStore.prototype.getParkingPrice = function(parking_price, unit) {
  return new Decimal(parking_price[unit] || 0);
};

// Handlebars helpers

Handlebars.registerHelper('tallyTotal', CostStore.prototype.tallyTotal);

// Adapted to account for both house AND parking. Need to fetch correct parking price, so must pass in unit

Handlebars.registerHelper('buildingCostRatio', function(price, property, unit) {
  var _price = unit === null ? new Decimal(price) : CostStore.prototype.getParkingPrice(price, unit);
  result = property === null ? 0 : _price.times(property.building_cost_ratio);
  return result;
});

Handlebars.registerHelper('landCostRatio', function(price, property, unit) {
  var _price = unit === null ? new Decimal(price) : CostStore.prototype.getParkingPrice(price, unit);
  result = property === null ? 0 : _price.times(property.land_cost_ratio);
  return result;
});

Handlebars.registerHelper('overUnder', function(reservation_price, prop, attr) {
  return new Decimal(reservation_price).div(CostStore.prototype.tallyTotal(prop, attr));
});

Handlebars.registerHelper('unitPrice', function(reservation_price, prop, attr) {
  return new Decimal(reservation_price).div(CostStore.prototype.tallyTotal(prop, attr));
});

Handlebars.registerHelper('parkingPrice', CostStore.prototype.getParkingPrice);
