require 'rails_helper'

RSpec.describe SentencesController, type: :controller do
  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #setup" do
    it "returns http success" do
      get :setup
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #result" do
    it "returns http success" do
      get :result
      expect(response).to have_http_status(:success)
    end
  end
end
