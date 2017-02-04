require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    let(:user) { FactoryGirl.create(:user) }

    it "returns redirect success" do
      sign_in user
      get :index
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET #show" do
    let(:user) { FactoryGirl.create(:user) }

    it "returns http success" do
      sign_in user
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
