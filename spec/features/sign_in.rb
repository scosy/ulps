require 'rails_helper'

describe "the signin process", type: :feature do
    before :each do
      User.create(email: 'user@example.com', password: 'password')
    end
  
    it "signs me in" do
      visit "/users/sign_in"
      within("#new_user") do
        fill_in 'user_email', with: 'user@example.com'
        fill_in 'user_password', with: 'password'
      end
      click_button 'Connexion'
      expect(page).to have_content 'Connecté'
    end
  end