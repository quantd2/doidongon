require 'rails_helper'

describe "Items pages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before do
    sign_in user
    Category.create(name: "cat1")
    Location.create(city: "loc1")
  end

  describe "item creation" do
    before do
      visit root_path
      click_on "Post Item"
    end
    describe "with invalid information" do
      it "should not create a item" do
        expect { click_button "Create Item" }.not_to change(Item, :count)
      end

    describe "error messages" do
      before { click_on "Create Item" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in 'item_name', with: "Harry Potter"
        select "1", from: "item_location_id"
        select "1", from: "item_category_id"
      end
      it "should create a item" do
        expect { click_button "Create Item" }.to change(Item, :count).by(1)
      end
    end
  end

  describe "item destruction" do
    let!(:item) { FactoryGirl.create(:item, user: user) }
    describe "as correct user" do
      before { visit items_path }
      it "should delete a item" do
        expect { click_on "Delete" }.to change(Item, :count).by(-1)
      end
    end
  end
end
