require 'rails_helper'

feature 'user provide answer to s_v_do exercise' do
  before :each do
    @exercice = create(:exercice)
    @user = create(:user)
    create(:personal_pronoun, :first_singular_nominative)
    create(:article)
    create(:verb_noun_link)
  end
  scenario 'not successfully' do
    login_as(@user, scope: :user)
    visit exercice_path(@exercice.id)
    fill_in 'response', with: 'gloubiboulga'
    click_button 'BANG!'
    expect(page).to have_content('Try again')
  end

  scenario 'successfully' do
    login_as(@user, scope: :user)
    visit exercice_path(@exercice.id)
    @exercice = Exercice.find(@exercice.id) # data inside of exercice has change. need to reload
    fill_in 'response', with: @exercice.solution
    click_button 'BANG!'
    expect(page).to have_content('GOOD JOB')
  end
end
