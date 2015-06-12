require("spec_helper")
require('capybara/rspec')
require('./app')
DB = PG.connect({:dbname => "museum_tracker_test"})
include Capybara::DSL # Added to solve problem where capybara couldn't find visit method


Capybara.app = Sinatra::Application
set(:show_expections, false)

describe('adding a new museum', {:type => feature}) do
  it('allows a user to click a museum ') do
    visit('/')
    fill_in('name', :with => 'Portland Museum')
    click_button('Add museum')
    expect(page).to have_content('Success!')
  end
end

describe('viewing all of the Museums', {:type => :feature}) do
  it('allows a user to see all of the museums that have been added') do
    museum = Museum.new({:name => 'Portland Art', :id => nil})
    museum.save()
    visit('/')
    expect(page).to have_content(museum.name)
  end
end

describe('seeing art for a single museum', {:type => :feature}) do
  it('allows a user to click a museum to see the art') do
    test_museum = Museum.new({:name => 'Maine Art', :id => nil})
    test_museum.save()
    test_artwork = Artwork.new({:description => "rocks", :museum_id => test_museum.id()})
    test_artwork.save()
    visit('/')
    click_button("Add art")
    visit('/museums/id')
    expect(page).to have_content(test_artwork.description())
  end
end

describe('adding museums', {:type => :feature}) do
  it('allows a user to add a museum list') do
    test_museum = Museum.new({:name => 'Boat Museum', :id => nil})
    test_museum.save()
    visit("/")
    fill_in("name", {:with => "Boat Museum"})
    click_button("Add museum")
    expect(page).to have_content("Success!")
  end
end
