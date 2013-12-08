require 'rubygems'
require 'bundler'

Bundler.require

require './mailer'
run Sinatra::Application
