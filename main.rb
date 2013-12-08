require_relative 'queue'
require 'haml'

get '/' do
 engine = Haml::Engine.new(PAGE_HAML)
 engine.render
end

post '/add' do
  Queue.add_person request['email']
  redirect back
end

post '/remove' do
  Queue.remove_person request['email']
  redirect back
end

def people
  Queue.people
end

def current
  Queue.current
end

PAGE_HAML = <<-EOS
%html
  !!! 5
  %head
    %title
      Checkout Team Errbit Roster Thingy
  %body
    %h1
      Checkout Team Errbit Roster Thingy
    %div
      Everyone:
      = people
    %div
      Current cycle:
      = current
    %form{name: 'add', action: '/add', method: 'post'}
      %label{for: 'add[email]'} Add someone
      %input{type: 'text', name: 'email'}
      %input{type: 'submit', value: 'Add', class: 'button'}
    %form{name: 'remove', action: '/remove', method: 'post'}
      %label{for: 'remove[email]'} remove someone
      %input{type: 'text', name: 'email'}
      %input{type: 'submit', value: 'remove', class: 'button'}
EOS
