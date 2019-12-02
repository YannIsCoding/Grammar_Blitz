require 'rails_helper'

feature 'User visits profile page' do
  before :each do
    @user = create(:user)
    @trial = create(:trial, user: @user)
    login_as(@user, scope: :user)
  end

  scenario 'successfully' do
    visit profile_path
    expect(page).to have_css 'h1', text: "Hello #{@user.username}"
  end

  scenario 'And sees his/her stats' do
    visit profile_path
    page.has_content?(@trial.exercice.name)
  end

  scenario 'and sees his/her accurate global ranking' do
    visit profile_path
    expect(page).to have_css '.active-user', text: 'Alan'
    competitor = create(:user, :competitor)
    create(:trial, user: competitor, exercice: @trial.exercice, success: true)
    visit profile_path
    expect(page).to have_css '.ranking-container', text: /leo/
    expect(page).to have_css '.active-user', text: '2'
    create_list(:trial, 5, user: @user, exercice: @trial.exercice, success: true)

    visit profile_path
    expect(page).to have_css '.active-user', text: '1'
  end
end
