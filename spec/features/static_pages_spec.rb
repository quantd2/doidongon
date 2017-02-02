require 'rails_helper'

describe "Static pages" do

  describe "Home page" do
    it "expect have the content 'give2get'" do
      visit '/static_pages/home'
      expect(page).to have_content('give2get')
    end

    it "should have the h1 'Give2Get'" do
      visit '/static_pages/home'
      expect(page).to have_selector('h1', :text => 'Give2Get')
    end

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_selector('title',
        :text => "Give2Get | Home", :visible => false)
    end
  end


  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end

    it "should have the h1 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_selector('h1', :text => 'Help')
    end

    it "should have the title 'Give2Get - Help'" do
      visit '/static_pages/help'
      expect(page).to have_selector('title',
        :text => "Give2Get | Help", :visible => false)
    end
  end

  describe "About page" do
    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end

    it "should have the h1 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_selector('h1', :text => 'About Us')
    end

    it "should have the title 'Give2Get - About Us'" do
      visit '/static_pages/about'
      expect(page).to have_selector('title',
        :text => "Give2Get | About Us", :visible => false)
    end
  end

end
