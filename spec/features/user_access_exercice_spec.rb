require 'rails_helper'

feature 'user access exercice' do
  scenario 'successfully' do
    visit root_path


    click_on "get the fun started"
    exercice = Exercice.all.sample
    click_on exercice.name
    fill_in 'Email', with: 'me@me.me'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
  end

  feature 'user login with warden' do
    scenario 'successfully' do
      user = FactoryBot.create(:user)
      login_as(user, :scope => :user)
      visit root_path
      click_on "get the fun started"
      exercice = Exercice.all.sample
      expect(page).to have_content(exercice.name)
      click_on exercice.name
      expect(page).to have_content(exercice.name)
    end
  end
end
