class CheckoutsController < ApplicationController
    before_action :authenticate_user!

    def index
    end

    def membership
        if current_user.subscribed?
            redirect_to root_path, alert: "Vous êtes déjà abonné à ULPS"
        else
            @checkout_session = current_user.payment_processor.checkout(
                mode: "subscription",
                line_items: ENV["STRIPE_MEMBERSHIP_PRICE_ID"],
                subscription_data: { 
                    trial_period_days: 30
                },
                success_url: checkout_membership_success_url,
                cancel_url: checkout_membership_url
            )
        end
    end

    def extra_credit
        @checkout_session = current_user.payment_processor.checkout(
            mode: "payment",
            line_items: ENV["STRIPE_EXTRA_CREDIT_PRICE_ID"],
            success_url: checkout_extra_credit_success_url,
            cancel_url: checkout_extra_credit_url
        )
    end

    def pack_credits
        @checkout_session = current_user.payment_processor.checkout(
            mode: "payment",
            line_items: ENV["STRIPE_PACK_CREDITS_PRICE_ID"],
            success_url: checkout_pack_credits_success_url,
            cancel_url: checkout_pack_credits_url
        )
    end

    def membership_success
    end

    def extra_credit_success
    end

    def pack_credits_success
    end

end