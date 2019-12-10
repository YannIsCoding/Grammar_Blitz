require 'rails_helper'

feature 'user provide answer to v_s_do exercise' do
  before :each do
    @exercice = create(:exercice, :question_accusative)
    @user = create(:user)
    s = create(:sentence, user: @user, exercice: @exercice, word_indexes: [2])
    s.word_indexes = [2]
    s.save!
    create(:personal_pronoun, :first_singular_nominative)
    @possessive_pronoun = create(:pronoun, :possessive_first_person_feminin_accusative)
    @article = create(:article)
    create(:verb_noun_link)
  end

  scenario 'not successfully' do
    login_as(@user, scope: :user)
    visit exercice_path(@exercice.id)
    fill_in 'response_0', with: 'gloubiboulga'
    click_button 'BANG!'
    expect(page).to have_content('Versuch es nochmal')
  end

  scenario 'successfully with empty space' do
    login_as(@user, scope: :user)
    visit exercice_path(@exercice.id)
    if page.has_content? 'my box'
      fill_in 'response_0', with: "#{@possessive_pronoun.value} "
    else
      fill_in 'response_0', with: "   #{@article.value} "
    end
    click_button 'BANG!'
    expect(page).to have_content('GUT GEMACHT')
  end
end
