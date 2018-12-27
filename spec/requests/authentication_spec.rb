require 'rails_helper'

describe 'Authentication', type: :feature do
    it 'allows users to log in' do
      user = FactoryBot.create(:user, password: 'password')
      visit new_user_session_url

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
      
      expect(current_url).to eq(root_url)
      expect(page).to have_selector('#message', text: 'Signed in successfully.')
    end
  end