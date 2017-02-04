require 'rails_helper'

describe Item do
  let(:user) { FactoryGirl.create(:user) }
  let(:location) { FactoryGirl.create(:location) }
  let(:category) { FactoryGirl.create(:category) }

  before do
    @item = Item.new(name: "Lorem ipsum", description: "desc1",
      user_id: user.id, location_id: location.id, category_id: category.id)
  end
  subject { @item }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:user_id) }
  it { is_expected.to respond_to(:category_id) }
  it { is_expected.to respond_to(:location_id) }
  it { is_expected.to respond_to(:item_images) }
  it { is_expected.to be_valid }

  describe "when user id is not present" do
    before { @item.user_id = nil }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @item.name = nil }
    it { should_not be_valid }
  end

  describe "when location id is not present" do
    before { @item.location_id = nil }
    it { should_not be_valid }
  end

  describe "when category id is not present" do
    before { @item.category_id = nil }
    it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @item.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "with description that is too long" do
    before { @item.description = "a" * 301 }
    it { should_not be_valid }
  end

end
