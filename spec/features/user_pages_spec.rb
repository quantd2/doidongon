require 'rails_helper'

describe "user page" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  before { visit user_path(user) }

  it { expect have_selector('strong', text: user.email) }

  describe "profile page" do
    # let(:user) { FactoryGirl.create(:user) }
    let!(:i1) { FactoryGirl.create(:item, user: user) }
    let!(:i2) { FactoryGirl.create(:item, user: user) }

    before { visit user_path(user) }
    it { should have_selector('h1', text: "My Item") }
    it { should have_selector('title', text: user.email, visible: false) }

    describe "item" do
      it { should have_content(i1.name) }
      it { should have_content(i2.name) }
      it { should have_content(user.items.count) }
    end
  end
end
