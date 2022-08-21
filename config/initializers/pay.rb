Pay.setup do |config|
  # For use in the receipt/refund/renewal mailers
  config.business_name = "ULPS"
  config.business_address = "Les Gachots, 77510 Verdelot, France"
  config.application_name = "ULPS"
  config.support_email = "yo@ulps.fr"

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

  # Give credits to the user when they get charged
  class InvoicePaidProcessor
    def call(event)
      checkout_session = event.data.object
      customer = Pay::Customer.find_by(processor_id: checkout_session.customer)
      user = customer.owner
      user.update(available_credits: user.available_credits + 1)
    end
  end
  Pay::Webhooks.delegator.subscribe "stripe.invoice.paid", InvoicePaidProcessor.new

end