# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  pay_customer default_payment_processor: :stripe

  has_many :user_episodes, dependent: :destroy
  has_many :episodes, through: :user_episodes
  has_many :filled_orders, dependent: :destroy

  after_create :sib_add_to_list unless Rails.env.test?

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    if user.nil?
      user = create(email: auth.info.email, password: Devise.friendly_token[0, 20], provider: auth.provider,
                    uid: auth.uid, name: auth.info.name)
    end
    user
  end

  delegate :subscribed?, to: :payment_processor

  def admin?
    role == 'admin'
  end

  def send_welcome_reset_password_instructions
    UserMailer.welcome_reset_password_instructions(self).deliver_later
  end

  def send_credits_added(credits)
    UserMailer.credits_added(self, credits).deliver_later
  end

  def add_credits(credits)
    update(available_credits: available_credits + credits)
    send_credits_added(credits)
  end

  def episode_obtained(episode)
    UserMailer.episode_obtained(self, episode).deliver_later
  end

  def sib_add_to_list(*args)
    list_id = args.any? ? 14 : 13

    SendinblueAddToListJob.perform_later(self.email, list_id)
  end
  
  def start_subscription
    self.update(available_credits: 1)
    self.filled_orders.create(description: 'Started subscription : get 1 credit')
    self.sib_add_to_list("clients")
  end
end
