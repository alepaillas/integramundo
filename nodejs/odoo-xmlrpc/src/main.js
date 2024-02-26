var Odoo = require("odoo-xmlrpc");

var odoo = new Odoo({
  url: "http://integramundo.odoo.com",
  port: 80,
  db: "integramundo",
  username: "management@integramundo.cl",
  password: "99b54",
});

odoo.connect(function (err) {
    if (err) { return console.log(err); }
    console.log('Connected to Odoo server.');
    var inParams = [];
    inParams.push([['is_company', '=', true],['customer', '=', true]]);
    inParams.push(0);  //offset
    inParams.push(1);  //Limit
    var params = [];
    params.push(inParams);
    odoo.execute_kw('res.partner', 'search', params, function (err, value) {
        if (err) { return console.log(err); }
        var inParams = [];
        inParams.push(value); //ids
        var params = [];
        params.push(inParams);
        odoo.execute_kw('res.partner', 'read', params, function (err2, value2) {
            if (err2) { return console.log(err2); }
            console.log('Result: ', value2);
        });
    });
});