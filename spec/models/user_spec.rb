# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'before save' do
    it 'is not valid with blank email' do
      expect(User.new(email: '')).to_not be_valid
    end
    it 'is not valid with blank password' do
      expect(User.new(password: '')).to_not be_valid
    end
    it 'is not valid with blank password confirmation' do
      expect(User.new(password_confirmation: '')).to_not be_valid
    end
    it 'is valid with valid email and password' do
      expect(User.new(email: 'test@ulps.fr', password: 'password', password_confirmation: 'password')).to be_valid
    end
  end

  # Test role methods
  context 'role methods' do
    before(:each) do
      @user = User.new(email: 'test@ulps.fr', password: 'password')
      @user.save
    end

    it 'is not admin' do
      expect(@user.admin?).to be false
    end
  end

  # Test mailer methods
  context 'mailer methods' do
    before(:each) do
      @user = User.new(email: 'test@ulps.fr', password: 'password')
      @user.save
    end

    it 'sends welcome email and reset password instructions' do
      expect(@user.send_welcome_reset_password_instructions).to be_truthy
    end

    it 'sends credits added' do
      expect(@user.send_credits_added(10)).to be_truthy
    end

    it 'sends episode obtained' do
      @episode = Episode.new(book: Book.new(title: 'test'))
      @episode.save
      expect(@user.episode_obtained(@episode)).to be_truthy
    end
  end

  # Test payment processor methods
  context 'payment processor methods' do
    before(:each) do
      @user = User.new(email: 'test@ulps.fr', password: 'password')
      @user.save
    end

    it 'is not subscribed' do
      expect(@user.subscribed?).to be false
    end

    it 'can add credits' do
      expect(@user.add_credits(10)).to be_truthy
    end
  end
end
