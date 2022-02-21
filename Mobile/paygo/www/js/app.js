var app = angular.module('paygo', ['onsen', 'ngAnimate', 'ngtimeago']);
//Filters
//geting unique ids
app.filter('unique', function() {
    return function(collection, keyname) {
        var output = [],
            keys = [];

        angular.forEach(collection, function(item) {
            var key = item[keyname];
            if (keys.indexOf(key) === -1) {
                keys.push(key);
                output.push(item);
            }
        });
        return output;
    };
});

//get object length
app.filter('numkeys', function() {
    return function(object) {
        return Object.keys(object).length;
    }
});