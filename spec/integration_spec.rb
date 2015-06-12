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
