require 'rails_helper'

feature 'user provide wrong answer to s_v_do exercice' do
  scenario 'successfully' do
    user = create(:user)
    exercice = create(:exercice)
    create(:personal_pronoun)
    create(:article)
    p '##################'
    p subject { :noun }
    p '##################'
    p create(:noun)
    p create(:verb)
    create(:link)
    login_as(user, scope: :user)
    visit exercice_path(exercice.id)
    fill_in 'response', with: 'gloubiboulga'
    click_button 'Submit'
    expect(page).to have_content('Try again')
  end
end

feature 'user provide correct answer to s_v_do exercice' do
  15.times do # repeat due to the inherant randomness of the test
    scenario 'successfully' do
      user = User.last
      login_as(user, scope: :user)
      exercice = Exercice.find_by(structure_id: Structure.find_by(name: 's_v_do'))
      visit exercice_path(exercice.id)
      exercice = Exercice.find(exercice.id) # data inside of exercice has change. need to reload
      fill_in 'response', with: exercice.solution
      click_button 'Submit'
      expect(page).to have_content('GOOD JOB')
    end
  end
end
