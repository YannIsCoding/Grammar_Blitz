require 'rails_helper'

feature 'user access exercice' do
  scenario 'successfully' do
    exercice = create(:exercice)
    p FactoryBot(:exercice)
    visit root_path
    click_on "GET THE FUN"
    click_on exercice.name
    fill_in 'Email', with: 'me@me.me'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
  end

  feature 'user login with warden' do
    scenario 'successfully' do
      user = create(:user)
      login_as(user, scope: :user)
      exercice = create(:exercice)
      create(:personal_pronoun)
      create(:article)
      create(:noun)
      create(:verb)
      create(:link)
      visit root_path
      click_on "GET THE FUN"
      expect(page).to have_content(exercice.name)
      click_on exercice.name
      expect(page).to have_content(exercice.name)
    end
  end
end
