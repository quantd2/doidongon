require 'rails_helper'

describe Relationship do

  let(:follower) { FactoryGirl.create(:item) }
  let(:followed) { FactoryGirl.create(:item) }
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }

  subject { relationship }

  it { should be_valid }

  describe "follower methods" do
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }
    it { is_expected.to have_attributes(follower: follower) }
    it { is_expected.to have_attributes(followed: followed) }
  end

  describe "when followed id is not present" do
    before { relationship.followed_id = nil }
    it { should_not be_valid }
  end

  describe "when follower id is not present" do
    before { relationship.follower_id = nil }
    it { should_not be_valid }
  end
end
