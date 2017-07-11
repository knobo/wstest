
$(function () {
  var ws = new WebSocket('ws://localhost:5000/echo');
  ws.onmessage = function(event) {
    var f = $('.msg');
    var msg = JSON.parse(event.data);
    f.append(msg);
  };
});
