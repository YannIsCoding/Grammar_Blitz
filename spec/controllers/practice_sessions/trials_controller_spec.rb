require 'rails_helper'

RSpec.describe PracticeSessions::TrialsController, type: :controller do
  describe "POST #create" do
    login_user
    it "returns http success" do
      @exercice = create(:exercice, :edicted)
      @edict = create(:edict, exercice: @exercice)
      @practice_session = create(:practice_session, user: @user, exercice: @exercice)
      @trial = create(:trial, practice_session: @practice_session, user: @user,
                              edict: @edict, value: @edict.value )

      post :create,
           params: { practice_session_id: @practice_session, response_3: 'dem' },
           format: :js

      expect(response).to have_http_status(:success)
      expect(response).to render_template :new
      expect(assigns(:previous_trial).result).to eq 'correct'
      expect(assigns(:trial).user).to eq @user
      expect(assigns(:trial).practice_session).to eq @practice_session
      expect(assigns(:trial).value).to eq "Ich fahre mit dem Fahrrad"
    end
  end
end
