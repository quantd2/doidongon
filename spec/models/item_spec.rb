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
  it { should respond_to(:relationships) }
  it { should respond_to(:followed_items) }
  it { should respond_to(:following?) }
  it { should respond_to(:follow!) }
  it { should respond_to(:unfollow!) }
  it { should respond_to(:reverse_relationships) }
  it { should respond_to(:followers_items) }
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

  describe "following" do
    let(:other_item) { FactoryGirl.create(:item) }
    before do
      @item.save
      @item.follow!(other_item)
    end

    it "follow item" do
      expect(@item.following?(other_item)).not_to be_nil
    end

    it "check followed item" do
      expect(@item.followed_items).to include(other_item)
    end

    describe "and unfollowing" do
      before { @item.unfollow!(other_item) }
      it { should_not be_following(other_item) }
      it "unfollow item" do
        expect(@item.following?(other_item)).to be_nil
      end

      it "check unfollowed item" do
        expect(@item.followed_items).not_to include(other_item)
      end
    end

    describe "followed item" do
      it "check follower item" do
        expect(other_item.followers_items).to include(@item)
      end
    end
  end
end
