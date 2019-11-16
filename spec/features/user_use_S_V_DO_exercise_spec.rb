require 'rails_helper'

feature 'user access exercice' do
  scenario 'successfully' do
    exercice = create(:exercice)
    visit root_path
    click_on "GET THE FUN"
    click_on exercice.name
    fill_in 'Email', with: 'me@me.me'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
  end
end

  feature 'user login with warden' do
    scenario 'successfully' do
      user = create(:user)
      login_as(user, scope: :user)
      exercice = create(:exercice)
      create(:personal_pronoun)
      create(:article)
      create(:verb_noun_link)
      visit root_path
      click_on "GET THE FUN"
      expect(page).to have_content(exercice.name)
      click_on exercice.name
      expect(page).to have_content(exercice.name)
    end
  end

  feature 'user provide answer to s_v_do exercice' do
    scenario 'not successfully' do
      user = create(:user)
      create(:personal_pronoun)
      create(:article)
      create(:verb_noun_link)
      exercice = create(:exercice)
      login_as(user, scope: :user)
      visit exercice_path(exercice.id)
      fill_in 'response', with: 'gloubiboulga'
      click_button 'BANG!'
      expect(page).to have_content('Try again')
    end

    scenario 'successfully' do
      user = create(:user)
      create(:personal_pronoun)
      create(:article)
      create(:verb_noun_link)
      login_as(user, scope: :user)
      exercice = create(:exercice)
      visit exercice_path(exercice.id)
      exercice = Exercice.find(exercice.id) # data inside of exercice has change. need to reload
      fill_in 'response', with: exercice.solution
      click_button 'BANG!'
      expect(page).to have_content('GOOD JOB')
    end
  end
