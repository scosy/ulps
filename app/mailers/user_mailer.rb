class UserMailer < Devise::Mailer
    include Devise::Mailers::Helpers
    default from: '"ulps.fr 📚" <support@ulps.fr>'

    # Send welcome email and reset password instructions (only for ULPS launch)
    def welcome_reset_password_instructions(record, opts = {})
        create_reset_password_token(record)
        devise_mail(record, :welcome_reset_password_instructions, opts)
    end

    # Send email when an episode is obtained
    def episode_obtained(user, episode)
        @episode = episode
        @user = user
        mail(to: @user.email, subject: "Votre épisode sur #{@episode.book.title}")
    end

    # Send email when credits are added
    def credits_added(user, credits)
        @user = user
        @credits = credits
        mail(to: @user.email, subject: "Vous avez reçu #{@credits} crédit(s)")
    end

    private 

    def create_reset_password_token(user)
        raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
        @token = raw
        user.reset_password_token = hashed
        user.reset_password_sent_at = Time.now.utc
        user.save(validate: false)
    end
end
