var express = require("express")
var app = express()
var redis = require("redis")
var client = redis.createClient({ host: "redis" });
var key = "counter"

app.get('/', function (req, res) {
  client.get(key, function(err, reply) {
    if (reply == null) {
      reply = 1;
    } else {
      reply = parseInt(reply, 10);
      reply += 1;
    }
    client.set(key, reply);
    res.send('Hit Counter: ' + reply)
  });
})

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})
