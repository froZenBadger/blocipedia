require 'rails_helper'

feature 'Sign In', :devise do
  scenario 'user cannot sign in if not registered' do
    sign_in('person@example.com', 'password')
    expect(page).to have_content 'Invalid email or password'
  end

  scenario 'user can sign in with valid credentials' do
    user = FactoryGirl.create(:user)
    sign_in(user.email, user.password)
    expect(page).to have_content 'Signed in successfully'
  end

  scenario 'user cannot sign in wth invalid email' do
    user = FactoryGirl.create(:user)
    sign_in('invalid@email.com', user.password)
    expect(page).to have_content 'Invalid email or password'
  end

  scenario 'user can sign in with invalid password' do
    user = FactoryGirl.create(:user)
    sign_in(user.email, 'invaid password')
    expect(page).to have_content 'Invalid email or password'
  end
end
