var formUtils = (function() {
  // turn form data created via $.serializeArray() into JSON format

  var jsonify = function(dataArr) {
    var result = {}

    for (var i = 0; i < dataArr.length; i++) {
      result[dataArr[i]['name']] = dataArr[i]['value']
    }

    return result;
  };

  return {
    jsonify: jsonify,
  }
})();
