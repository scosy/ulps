class CheckoutsController < ApplicationController
    before_action :authenticate_user!

    def show
        @checkout_session = current_user.payment_processor.checkout(
            mode: "subscription",
            line_items: "price_1LXhqeIuO31KnPvmoiVQqzgD"
        )
    end
end