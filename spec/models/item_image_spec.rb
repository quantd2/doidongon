require 'rails_helper'

describe ItemImage do
  let(:item) { FactoryGirl.build(:item) }
  let(:item_image) { FactoryGirl.create(:item_image, item: item) }
  subject { item_image }

  it { should respond_to(:image_name) }
  it { should respond_to(:item_id) }
end
