# require 'faye'
# app = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)
# run app

#
# config.ru

require 'faye'
Faye::WebSocket.load_adapter('thin')

app = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)

run app


