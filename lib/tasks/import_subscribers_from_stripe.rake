namespace :import_subscribers_from_stripe do
    desc 'Import subscribers from Stripe'

    task :run => :environment do   
        i = 0
        Stripe::Subscription.list.each do |stripe_sub|
            print "#{i} - Importing #{stripe_sub.customer}... "
            pay_customer = Pay::Customer.find_by(processor_id: stripe_sub.customer)
            if pay_customer.nil?
                customer = Stripe::Customer.retrieve(stripe_sub.customer)
                print "Creating customer #{customer.email}... "
                user = User.create(email: customer.email, password: SecureRandom.hex(10), role: 'early_member')
                pay_customer = Pay::Customer.create(owner: user, processor: :stripe, processor_id: customer.id)
            else
                user = pay_customer.owner
                print "Customer found #{user.email}. "
            end

            subscription = user.subscriptions.where(processor_id: stripe_sub.id).first_or_initialize
            subscription_updated = subscription.update(
                customer:        pay_customer,
                processor_plan:  stripe_sub.plan.id,
                status:          stripe_sub.status,
                quantity:        1,
                name:            "default"
            )

            puts (subscription_updated? ? "✅" : "❌")
            i += 1
        end
    end

end
