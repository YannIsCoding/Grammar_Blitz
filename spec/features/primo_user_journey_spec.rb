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
    possessive_pronoun_accusative = create(:pronoun, :possessive_first_person_feminin_accusative )
    article_accusative = create(:article)
    create(:verb_noun_link)
    click_on exercice.name
    5.times do
      if page.has_content? 'my box'
        fill_in 'response_0', with: possessive_pronoun_accusative
      else
        fill_in 'response_0', with: article_accusative
      end
      click_on "BANG!"
      expect(page).to have_content 'GUT GEMACHT!'
      fill_in 'response_0', with: 'chunky bacon'
      click_on "BANG!"
      expect(page).to have_content 'Versuch es nochmal'
    end
    exercice_io_do = create(:exercice, :direct_indirect)
    click_on "Profile"
    expect(page).to have_content exercice.name
    expect(page).not_to have_content exercice_io_do.name
    click_on "Exercises"
    #create data for the io_do exercise
    kiste = Noun.first
    create(:verb_noun_link, :for_io_do, noun: kiste)
    create(:noun, :feminin_person)
    article_dative = create(:article, :definite_feminin_dative)
    possessive_pronoun_dative = create(:pronoun, :possessive_first_person_feminin_dative)
    click_on exercice_io_do.name
    fill_in 'response_0', with: 'chunky bacon'
    click_on "BANG!"
    expect(page).to have_content 'Versuch es nochmal'
    5.times do
      if page.has_content? 'my waitress'
        fill_in 'response_0', with: possessive_pronoun_dative
      else
        fill_in 'response_0', with: article_dative
      end

      if page.has_content? 'my box'
        fill_in 'response_1', with: possessive_pronoun_accusative
      else
        fill_in 'response_1', with: article_accusative
      end
      click_on "BANG!"
      expect(page).to have_content 'GUT GEMACHT!'
    end
    click_on "Profile"
    expect(page).to have_content exercice.name
    expect(page).to have_content exercice_io_do.name
  end
end
