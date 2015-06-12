class Artwork
  attr_reader(:description, :museum_id)

  define_method(:initialize) do |attributes|
    @description = attributes.fetch(:description)
    @museum_id = attributes.fetch(:museum_id)
  end

  define_singleton_method(:all) do
    returned_artworks = DB.exec("SELECT * FROM artworks;")
    artworks = []
    returned_artworks.each() do |artwork|
      description = artwork.fetch("description")
      list_id = artwork.fetch("museum_id").to_i()
      artworks.push(Artwork.new({:description => description, :museum_id => museum_id}))
    end
    artworks
  end
end
