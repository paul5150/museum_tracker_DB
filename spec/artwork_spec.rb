require "spec_helper"

describe(Artwork) do

  describe(".all") do
    it("is empty at first") do
      expect(Artwork.all()).to(eq([]))
    end
  end

end
