require 'rails_helper'

feature 'user login ' do
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
    exercice = create(:exercice)
    create(:personal_pronoun, :first_singular_nominative)
    create(:article)
    create(:verb_noun_link)
    user = create(:user)
    login_as(user, scope: :user)
    visit root_path
    click_on "GET THE FUN"
    expect(page).to have_content(exercice.name)
    click_on exercice.name
    expect(page).to have_content(exercice.name)
  end
end

