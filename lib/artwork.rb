class Artwork
  attr_reader(:description, :museum_id)

  define_method(:initialize) do |attributes|
    @description = attributes.fetch(:description)
    @museum_id = attributes.fetch(:museum_id)
  end
end
