require 'rails_helper'

RSpec.describe PracticeSessionsController, type: :controller do
  describe "GET #new" do
    login_user
    it "returns http success" do
      @exercice = create(:exercice, :edicted)
      @edict = create(:edict, exercice: @exercice)
      get :new, params: { exercice_id: @exercice }

      expect(response).to have_http_status(:success)
      expect(response).to render_template 'trials/new'
      expect(assigns(:exercice)).to eq @exercice
      expect(assigns(:practice_session).user).to eq @user
      expect(assigns(:practice_session).exercice).to eq @exercice
      expect(assigns(:trial).user).to eq @user
      expect(assigns(:trial).practice_session).to eq PracticeSession.first
    end
  end
end
