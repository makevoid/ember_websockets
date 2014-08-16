require 'sinatra'

class App < Sinatra::Base
  get "/" do
    File.read "index.html"
  end
end

run App