require "spec_helper"

describe(Artwork) do

  describe(".all") do
    it("is empty at first") do
      expect(Artwork.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds an artwork to the array of saved artworks") do
      test_artwork = Artwork.new({:description => "The Thinker", :museum_id => 1})
      test_artwork.save()
      expect(Artwork.all()).to(eq([test_artwork]))
    end
  end

  describe("#description") do
    it("lets you read the description out") do
      test_artwork = Artwork.new({:description => "the painting", :museum_id => 1})
      expect(test_artwork.description()).to(eq("the painting"))
    end
  end

  describe("#museum_id") do
    it("lets you read the museum ID out") do
      test_artwork = Artwork.new({:description => "the painting", :museum_id => 1})
      expect(test_artwork.museum_id()).to(eq(1))
    end
  end

  describe("#==") do
    it("is the same artwork if it has the same description and museum ID") do
      artwork1 = Artwork.new({:description => "the painting", :museum_id => 1})
      artwork2 = Artwork.new({:description => "the painting", :museum_id => 1})
      expect(artwork1).to(eq(artwork2))
    end
  end

  describe("#delete") do
    it("deletes a museums's art from the database") do
      museum = Museum.new({:name => "Portland Museum", :id => nil})
      museum.save()
      artwork = Artwork.new({:description => "the rock", :museum_id => museum.id()})
      artwork.save()
      artwork2 = Artwork.new({:description => "the sky", :museum_id => museum.id()})
      artwork2.save()
      museum.delete()
      expect(Artwork.all()).to(eq([]))
    end
  end

end
