# Ember, Websockets, Faye, SSE and more

remember to use

thin start -R file

or

RACK_ENV=production rackup

or you're screwed, rack lint will misbehave with thin

(or use puma)