require 'sinatra'
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
  (Queue.people || []).each_slice(3).to_a
end

def current
  Queue.current
end

def up_next
  current[0..1].join(' and ')
end

def the_rest
  (current[2..-1] || []).join(" ← ")
end

PAGE_HAML = <<-EOS
%html
  !!! 5
  %head
    %title
      Montreal office Kitchen Duty Roster

  %body

    %h1
      Montreal office Kitchen Duty Roster

    %div
      Tomorrow:
      = up_next
    %div
      Then:
      = the_rest

    %hr

    %div
      Everyone:
      %table
        %tbody
          - people.each do |row|
            %tr
            - row.each do |column|
              %td= column

    %form{name: 'add', action: '/add', method: 'post'}
      %label{for: 'add[email]'} Add someone
      %input{type: 'text', name: 'email'}
      %input{type: 'submit', value: 'Add', class: 'button'}

    %form{name: 'remove', action: '/remove', method: 'post'}
      %label{for: 'remove[email]'} remove someone
      %input{type: 'text', name: 'email'}
      %input{type: 'submit', value: 'remove', class: 'button'}
EOS
