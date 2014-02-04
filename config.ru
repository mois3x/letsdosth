# This file is used by Rack-based servers to start the application.

puts "DEBUG - EXECUTED #{Time.now}"
require ::File.expand_path('../config/environment',  __FILE__)
run Letsdosomething::Application
