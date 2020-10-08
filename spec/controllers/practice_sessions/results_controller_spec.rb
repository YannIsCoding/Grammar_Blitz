require 'rails_helper'

RSpec.describe PracticeSessions::ResultsController, type: :controller do
  describe "GET #show" do
    login_user
    it "returns http success" do
      @exercice = create(:exercice, :edicted)
      @practice_session = create(:practice_session, user: @user, exercice: @exercice)

      post :show,
           params: { practice_session_id: @practice_session, response_3: 'dem' },
           format: :js

      expect(response).to have_http_status(:success)
      expect(response).to render_template :show
    end
  end
end
