// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the rails generate channel command.
//
//= require action_cable
//= require_self
//= require_tree ./channels

(function() {
  this.App || (this.App = {});
  //connect to the server using this by putting "ws://" + domain + "/cable" in createConsumer(), instead of connecting in the router 
  App.cable = ActionCable.createConsumer("ws://learning-real-time-olliehm.c9users.io:8080/cable");

}).call(this);
