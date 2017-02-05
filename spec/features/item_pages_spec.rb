require 'rails_helper'

describe "Items pages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }
    describe "with invalid information" do
      it "should not create a micropost" do
        expect { click_button "Post" }.should not_change(Item, :count)
      end

    describe "error messages" do
      before { click_button "Post" }
        it { should_have content('error') }
      end
    end

    describe "with valid information" do
      before { fill_in 'item name', with: "Harry Potter" }
      it "should create a item" do
        expect { click_button "Post" }.should change(Item, :count).by(1)
      end
    end
  end
end
