require 'rails_helper'

describe "Authentication" do

  describe "authorization" do
    describe "for non-signed-in users" do
    let(:user) { FactoryGirl.create(:user) }

      describe "in the item controller" do
        describe "submitting to the create action" do
          before { post items_path }
          specify { expect(response).to redirect_to(user_session_path) }
        end

        describe "submitting to the destroy action" do
          before do
            item = FactoryGirl.create(:item)
            delete item_path(item)
          end
          specify { expect(response).to redirect_to(user_session_path) }
        end

        describe "submitting to the edit action" do
          before do
            item = FactoryGirl.create(:item)
            patch item_path(item)
          end
          specify { expect(response).to redirect_to(user_session_path) }
        end
      end
    end
  end
end
