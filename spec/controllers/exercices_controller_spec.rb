require 'rails_helper'

RSpec.describe ExercicesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      # get :show
      # expect(response).to have_http_status(:success)
      # expect(get("/exercices/1")).to route_to(:controller => 'exercices')
    end
  end

end
