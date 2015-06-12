require "spec_helper"

describe(Museum) do
  describe(".all") do
    it("starts off with no Museums") do
      expect(Museum.all()).to(eq([]))
    end
  end

  describe("#name") do
  it("tells you its name") do
    museum = Museum.new({:name => "Portland Art Museum", :id => nil})
    expect(museum.name()).to(eq("Portland Art Museum"))
  end
end

  describe("#id") do
    it("sets its ID when you save it") do
      museum = Museum.new({:name => "Portland Art Museum", :id => nil})
      museum.save()
      expect(museum.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save mesuems to the database") do
      museum = Museum.new({:name => "Portland Art Museum", :id => nil})
      museum.save()
      expect(Museum.all()).to(eq([museum]))
    end
   end

   describe("#==") do
    it("is the same museum if it has the same name") do
      museum1 = Museum.new({:name => "Portland Art Museum", :id => nil})
      museum2 = Museum.new({:name => "Portland Art Museum", :id => nil})
      expect(museum1).to(eq(museum2))
    end
   end

   describe(".find") do
     it("returns a museum by its ID") do
       test_museum = Museum.new({:name => "Portland Art Museum", :id => nil})
       test_museum.save()
       test_museum2 = Museum.new({:name => "Boise Museum", :id => nil})
       test_museum2.save()
       expect(Museum.find(test_museum2.id())).to(eq(test_museum2))
     end
   end

   describe("#artworks") do
      it("returns an array of art for that museum") do
        test_museum = Museum.new({:name => "Portland Art Museum", :id => nil})
        test_museum.save()
        test_artwork = Artwork.new({:description => "the painting", :museum_id => test_museum.id()})
        test_artwork.save()
        test_artwork2 = Artwork.new({:description => "the statue", :museum_id => test_museum.id()})
        test_artwork2.save()
        expect(test_museum.artworks()).to(eq([test_artwork, test_artwork2]))
      end
    end

    describe("#update") do
      it("lets you update museums in the database") do
        museum = Museum.new({:name => "Maine Museum", :id => nil})
        museum.save()
        museum.update({:name => "Bangor Museum"})
        expect(museum.name()).to(eq("Bangor Museum"))
      end
    end

    describe("#delete") do
      it("lets you delete a museum from the database") do
        museum = Museum.new({:name => "Maine Museum", :id => nil})
        museum.save()
        museum2 = Museum.new({:name => "Bangor Museum", :id => nil})
        museum2.save()
        museum.delete()
        expect(Museum.all()).to(eq([museum2]))
      end

      it("deletes a museum's artworks from the database") do
        museum = Museum.new({:name => "Portland Museum", :id => nil})
        museum.save()
        artwork = Artwork.new({:description => "painting", :museum_id => museum.id()})
        artwork.save()
        artwork2 = Artwork.new({:description => "statue", :museum_id => museum.id()})
        artwork2.save()
        museum.delete()
        expect(Artwork.all()).to(eq([]))
      end
    end
 end
