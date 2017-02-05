require 'rails_helper'

describe "navigation when user logs in" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before do
    sign_in user
    visit user_path(user)
  end
  it { should have_selector('li', text: "Log Out") }
end

describe "navigation when user not log in" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before do
    visit root_path
  end
  it { should have_selector('li', text: "Log In") }
end
