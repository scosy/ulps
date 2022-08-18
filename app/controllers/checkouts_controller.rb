class CheckoutsController < ApplicationController
    before_action :authenticate_user!

    def show
        @checkout_session = current_user.payment_processor.checkout(
            mode: "subscription",
            line_items: "price_1LXhqeIuO31KnPvmoiVQqzgD",
            success_url: checkout_success_url,
            cancel_url: checkout_cancel_url
        )
    end

    def success
        @subscription = current_user.payment_processor.subscriptions.first
    end

    def cancel
    end
end