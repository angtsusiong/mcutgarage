(function() {
    dragula([document.querySelector("#area")], {
        invalid: function (el, handle) {
            return el.id === 'add-item';
        }
    })
        .on('drop', function (el){
            var pri = document.querySelectorAll('div.drag-item-priority');
            var i = 5;
            Array.from(pri).forEach(function(el){
                var order = el.querySelector('.integer');
                order.value = i;
                i += 2;
            });

        });
})();
