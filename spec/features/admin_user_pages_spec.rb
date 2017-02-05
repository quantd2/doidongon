require 'rails_helper'

describe "admin users pages" do
  subject { page }
  before(:all) { 30.times { FactoryGirl.create(:user) } }
  after(:all) { User.delete_all }

  describe "index" do
    let(:admin) { FactoryGirl.create(:admin) }
    before(:each) do
      sign_in admin
      visit users_path
    end

  it { should have_selector('title', text: 'All users', visible: false) }
  it { should have_selector('h1', text: 'All users') }

    describe "pagination" do
      it { should have_selector('div.pagination') }
      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('td', text: user.email)
        end
      end
    end
  end
end
