# app.rb
require 'faye/websocket'

App = lambda do |env|
  if Faye::WebSocket.websocket?(env)
    ws = Faye::WebSocket.new(env)

    ws.on :message do |event|
      puts "sending message: #{event.data}"
      ws.send(event.data)
    end

    ws.on :close do |event|
      p [:close, event.code, event.reason]
      ws = nil
    end

    # Return async Rack response
    ws.rack_response
  else
    body = File.read "index.html"
    [200, {'Content-Type' => 'text/html'}, [body]]
  end
end

run App



# $.getJSON("http://[virtual machine name].cloudapp.net:7379/PUBLISH/mychannel/" + "test", null);

# JSON.stringify(["SUBSCRIBE", "mychannel"])

# socket.onopen = function() {
#     socket.send(JSON.stringify(["SUBSCRIBE", "mychannel"]));
# };
# socket.onmessage = function(evt)
# {
#      alert(evt.data);
#      ...
# };