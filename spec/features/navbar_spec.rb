require 'rails_helper'


describe "navigation bar default" do
  subject { page }
  before { visit root_path }
  it { should have_selector('li'), text: "Home" }
  it { should have_selector('li'), text: "Help" }
  it { should have_selector('li', text: "Post Item") }
end


describe "navigation bar when user logs in" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before do
    sign_in user
    visit user_path(user)
  end
  it { should have_selector('li', text: "Log Out") }
  it { should have_selector('li', text: "My Items") }
  it { should_not have_selector('li', text: "Log In") }
end

describe "navigation bar when user not log in" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before do
    visit root_path
  end
  it { should have_selector('li', text: "Log In") }
end
