class UserMailer < Devise::Mailer
    include Devise::Mailers::Helpers

    def welcome_reset_password_instructions(record, opts = {})
        create_reset_password_token(record)
        devise_mail(record, :welcome_reset_password_instructions, opts)
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
