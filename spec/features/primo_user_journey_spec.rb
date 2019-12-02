require 'rails_helper'

# this is a Behemote on purpose to be sure that everything work as excpected for a first time user
feature 'first time user tries everything ' do
  scenario 'successfully' do
    exercice = create(:exercice)
    visit root_path
    click_on "Sign In"
    fill_in 'Email', with: 'test@exemple.com'
    fill_in 'Username', with: 'Test user'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_on 'Sign up'
    click_on "GET THE FUN"
    # Fill in db with data so exercice can work
    create(:personal_pronoun, :first_singular_nominative)
    create(:article)
    create(:verb_noun_link)
    click_on exercice.name
    fill_in 'response', with: Article.last.value
    click_on "BANG!"
    expect(page).to have_content 'GOOD JOB!'
    fill_in 'response', with: 'chunky bacon'
    click_on "BANG!"
    expect(page).to have_content 'Try again'
    exercice_io_do = create(:exercice, :direct_indirect)
    click_on "Profile"
    expect(page).to have_content exercice.name
    expect(page).not_to have_content exercice_io_do.name
    click_on "Exercises"
    #create data for the io_do exercise
    create(:verb_noun_link, :for_io_do)
    create(:noun, :feminin_person)
    create(:article, :definite_feminin_dative)
    click_on exercice_io_do.name
    fill_in 'response', with: 'chunky bacon'
    click_on "BANG!"
    expect(page).to have_content 'Try again'
    fill_in 'response', with: Article.last.value
    fill_in 'response_2', with: Article.first.value
    click_on "BANG!"
    expect(page).to have_content 'GOOD JOB!'
    click_on "Profile"
    expect(page).to have_content exercice.name
    expect(page).to have_content exercice_io_do.name
  end
end
