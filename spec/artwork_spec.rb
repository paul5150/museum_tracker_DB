require "spec_helper"

describe(Artwork) do

  describe(".all") do
    it("is empty at first") do
      expect(Artwork.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a task to the array of saved artworks") do
      test_artwork = Artwork.new({:description => "The Thinker", :museum_id => 1})
      test_artwork.save()
      expect(Artwork.all()).to(eq([test_artwork]))
    end
  end
end
