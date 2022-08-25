Pay.setup do |config|
  # For use in the receipt/refund/renewal mailers
  config.business_name = "ULPS"
  config.business_address = "Les Gachots, 77510 Verdelot, France"
  config.application_name = "ULPS"
  config.support_email = '"Support ULPS 📚" <support@ulps.fr>'

  config.default_product_name = "default"
  config.default_plan_name = "default"

  config.automount_routes = true
  config.routes_path = "/pay" # Only when automount_routes is true
  # All processors are enabled by default. If a processor is already implemented in your application, you can omit it from this list and the processor will not be set up through the Pay gem.
  config.enabled_processors = [:stripe]
  # All emails can be configured independently as to whether to be sent or not. The values can be set to true, false or a custom lambda to set up more involved logic. The Pay defaults are show below and can be modified as needed.
  config.emails.payment_action_required = true
  config.emails.receipt = true
  config.emails.refund = true
  # This example for subscription_renewing only applies to Stripe, therefor we supply the second argument of price
  config.emails.subscription_renewing = ->(pay_subscription, price) {
    (price&.type == "recurring") && (price.recurring&.interval == "year")
  }

  class FulfillCustomerSubscriptionCreated
    def call(event)
      object = event.data.object # Stripe::Subscription object

      if object.status == "trialing"
        customer = Pay::Customer.find_by(processor_id: object.customer)
        unless customer.nil?
          user = customer.owner
          user.update(available_credits: 1)
        else
          puts "ULPS ALERT - No Pay::Customer found for Susbcription #{object.id}"
        end
      end
    end
  end

  class FulfillInvoicePaid
    def call(event)
      object = event.data.object # Stripe::Invoice object

      if object.status == "paid"
        customer = Pay::Customer.find_by(processor_id: object.customer)
        unless customer.nil?
          user = customer.owner
          user.update(available_credits: user.available_credits + 1)
        else
          puts "ULPS_ALERT - No Pay::Customer found for invoice #{object.id}"
        end
      end
    end
  end

  class FulfillCheckout
    def call(event)
      object = event.data.object # Stripe::Checkout::Session object

      if object.payment_status == "paid"
        customer = Pay::Customer.find_by(processor_id: object.customer)
        user = customer.owner
        line_items = Stripe::Checkout::Session.list_line_items(object.id, {limit: 5})
        if line_items.data[0].price.id == ENV["STRIPE_PACK_CREDITS_PRICE_ID"]
          user.update(available_credits: user.available_credits + 3)
        elsif line_items.data[0].price.id == ENV["STRIPE_EXTRA_CREDIT_PRICE_ID"]
          user.update(available_credits: user.available_credits + 1)
        end
      end
    end
  end

  # Subscriptions created webhook
  Pay::Webhooks.delegator.subscribe "stripe.customer.subscription.created", FulfillCustomerSubscriptionCreated.new
  
  # Subscriptions renewed webhook
  Pay::Webhooks.delegator.subscribe "stripe.invoice.paid", FulfillInvoicePaid.new

  # Checkout session completed webhooks
  Pay::Webhooks.delegator.subscribe "stripe.checkout.session.completed", FulfillCheckout.new
  Pay::Webhooks.delegator.subscribe "stripe.checkout.session.async_payment_succeeded", FulfillCheckout.new

end