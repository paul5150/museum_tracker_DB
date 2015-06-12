require "sinatra"
require "sinatra/reloader"
also_reload("lib/**/*.rb")
require "./lib/museum"
require "./lib/artwork"
require "pg"

DB = PG.connect({:dbname => "museum_tracker"})

get("/") do
  @museums = Museum.all
  erb(:index)
end

get("/museums/new") do
  erb(:list_form)
end

post("/museums") do
  name = params.fetch("name")
  museum = Museum.new({:name => name, :id => nil})
  museum.save()
  erb(:success)
end
