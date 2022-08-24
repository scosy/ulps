class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  pay_customer default_payment_processor: :stripe

  has_many :user_episodes, dependent: :destroy
  has_many :episodes, through: :user_episodes
  has_many :filled_orders

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    if user.nil?
      user = self.create(email: auth.info.email, password: Devise.friendly_token[0,20], provider: auth.provider, uid: auth.uid, name: auth.info.name, image: auth.info.image)
    end
  end

  def subscribed?
    payment_processor.subscribed?
  end

  def admin?
    role == 'admin'
  end

  def send_welcome_reset_password_instructions
    UserMailer.welcome_reset_password_instructions(self).deliver_later
  end
    
end
