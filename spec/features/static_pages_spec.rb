require 'rails_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path  }

    it { expect have_content('give2get') }
    it { expect have_selector('h1', text: 'Give2Get') }
    it { expect(page).to have_selector('title',
        :text => full_title(''), :visible => false) }

    it "should list all item" do
      user.feed.each do |item|
        page.should have selector("li##{item.id}", text: item.name)
      end
    end
  end


  describe "Help page" do
    before { visit help_path }

    it { expect have_content('Help') }
    it { expect have_selector('h1', text: 'Help') }
    it { expect(page).to have_selector('title',
        :text => full_title(''), :visible => false) }
  end

  describe "About page" do
    before { visit about_path }

    it { expect have_content('About Us') }
    it { expect have_selector('h1', text: 'About Us') }
    it { expect(page).to have_selector('title',
        :text => full_title(''), :visible => false) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { expect have_content('Contact') }
    it { expect have_selector('h1', text: 'Contact') }
    it { expect(page).to have_selector('title',
        :text => full_title(''), :visible => false) }
  end

end
