# app.rb
require 'faye/websocket'

App = lambda do |env|
  if Faye::EventSource.eventsource?(env)
    es = Faye::EventSource.new(env)
    p [:open, es.url, es.last_event_id]

    # Periodically send messages
    loop = EM.add_periodic_timer(1) { es.send('Hello') }

    es.on :close do |event|
      EM.cancel_timer(loop)
      es = nil
    end

    # Return async Rack response
    es.rack_response

  else
    # Normal HTTP request
    [200, {'Content-Type' => 'text/plain'}, ['Hello']]
  end
end

run App


# in js
#
# var es = new EventSource("http://localhost:3000")

# es.onmessage = function(e) {
#   var elem = document.createElement("div")

#   elem.innerHTML = "message: " + e.data
#   document.body.appendChild(elem)
# }
