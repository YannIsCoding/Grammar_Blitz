require 'rails_helper'

feature 'user provide wrong answer to S_V_OD exercice' do
  scenario 'successfully' do
    user = User.last
    login_as(user, scope: :user)
    exercice = Exercice.find_by(structure_id: Structure.find_by(name: 'S_V_OD'))
    visit exercice_path(exercice.id)
    fill_in 'response', with: 'gloubiboulga'
    click_button 'Submit'
    expect(page).to have_content('Try again')
  end
end

feature 'user provide correct answer to S_V_OD exercice' do
  15.times do # repeat due to the inherant randomness of the test
    scenario 'successfully' do
      user = User.last
      login_as(user, scope: :user)
      exercice = Exercice.find_by(structure_id: Structure.find_by(name: 'S_V_OD'))
      visit exercice_path(exercice.id)
      exercice = Exercice.find(exercice.id) # data inside of exercice has change. need to reload
      fill_in 'response', with: exercice.solution
      click_button 'Submit'
      expect(page).to have_content('GOOD JOB')
    end
  end
end
