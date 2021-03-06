// Generated by CoffeeScript 1.9.3
(function() {
  var app, express, months, path, port;

  express = require("express");

  app = express();

  path = require('path');

  months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

  port = process.argv[2] || 8000;

  app.set('views', path.join(__dirname, '/views'));

  app.set('view engine', 'pug');

  app.use('/static', express["static"]('public'));

  app.get("/", function(req, res) {
    return res.render("index.pug");
  });

  app.get("/:date", function(req, res) {
    var date, natural, param, unix;
    param = req.params.date;
    if (param.match(/^\d+$/)) {
      date = new Date(parseInt(param) * 1000);
    } else {
      date = new Date(Date.parse(param));
    }
    if (isNaN(date.getTime())) {
      unix = null;
      natural = null;
    } else {
      unix = Math.round(date.getTime() / 1000);
      natural = months[date.getMonth()] + " " + (date.getDate()) + ", " + (date.getFullYear());
    }
    if (req.query.response === "html") {
      return res.render("index.pug", {
        output: "<h2>Response</h2>Unix timestamp: " + unix + "<br>Date: " + natural
      });
    } else {
      return res.json({
        unix: unix,
        natural: natural
      });
    }
  });

  app.listen(port, function() {
    return console.log("Timestamp app listening on port " + port + "!");
  });

}).call(this);
