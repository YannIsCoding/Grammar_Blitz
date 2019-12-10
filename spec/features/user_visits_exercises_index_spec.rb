require 'rails_helper'

feature 'user provide answer to s_v_do exercise' do
  before :each do
    @exercice = create(:exercice)
    @exercice_question = create(:exercice, :question_accusative)
    @user = create(:user)
  end

  scenario 'successfully' do
    login_as(@user, scope: :user)
    visit exercices_path
    expect(page).to have_content('accusative with direct object')
    expect(page).to have_content('question with accusative direct object')
  end
end
