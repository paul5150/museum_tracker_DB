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
  erb(:museum_form)
end

post("/museums") do
  name = params.fetch("name")
  museum = Museum.new({:name => name, :id => nil})
  museum.save()
  erb(:success)
end

get('/museums') do
  @museums = Museum.all
  erb(:museums)
end

get('/museums/:id') do
  @museum = Museum.find(params.fetch("id").to_i())
  @artworks = Artwork.all
  erb(:museum)
end

get("/museums/:id/edit") do
  @museum = Museum.find(params.fetch("id").to_i())
  erb(:museum_edit)
end

patch("/museums/:id") do
  name = params.fetch("name")
  @museum = Museum.find(params.fetch("id").to_i())
  @museum.update({:name => name})
  erb(:museum)
end

post('/museums') do
  name = params.fetch("name")
  new_museums = Museum.new({:name => name, :id => nil})
  new_museums.save()
  erb(:success)
end

get('/museums/:id/artworks/new') do
  @museum = Museum.find(params.fetch("id").to_i())
  erb(:artwork_form)
end

post('/museums/:id/artworks/new') do
  description = params.fetch("description")
  museum_id = params.fetch("museum_id").to_i()
  @museum = Museum.find(museum_id)
  @artwork = Artwork.new({:description => description, :museum_id => museum_id})
  @artwork.save()
  erb(:success)
end

delete("/museums/:id") do
  @museum = Museum.find(params.fetch("id").to_i())
  @museum.delete()
  @museums = Museum.all()
  @artwork = Artwork.find(params.fetch("id").to_i())
  @artwork.delete()
  @artworks = Artwork.all()
  erb(:index)
end




post("/artworks") do
  description = params.fetch("description")
  museum_id = params.fetch("museum_id").to_i()
  artwork = Artwork.new({:description => description, :museum_id => museum_id})
  artwork.save()
  @museum = Museum.find(museum_id)
  erb(:museum)
end
