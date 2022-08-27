namespace :import_subscribers_from_stripe do
    desc 'Import subscribers from Stripe'

    task :give_episodes => :environment do
        i = 0
        Stripe::Customer.list(limit: 100).each do |stripe_customer|
            puts "#{i += 1} - Updating #{stripe_customer.id}... "
            stripe_customer.subscriptions.each do |stripe_sub|
                if stripe_sub.items.count == 1
                    episode = Episode.find_by(stripe_id: stripe_sub.items.first.id)
                    if episode
                        user_episode = UserEpisode.new(user_id: stripe_customer.id, episode_id: episode.id)
                        user_episode.save
                    end
                end
            end
        end
    end

    task :update => :environment do
        i = 0
        Stripe::Subscription.list(status: "active").each do |stripe_sub|
            print "#{i += 1} - Importing #{stripe_sub.customer}... "
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
            subscription.update(
                customer:        pay_customer,
                processor_plan:  stripe_sub.plan.id,
                status:          stripe_sub.status,
                quantity:        1,
                name:            "default"
            )

            puts (subscription.errors.none? ? "✅" : "❌")
        end
    end

    task :run => :environment do   
        i = 0
        Stripe::Subscription.list(limit: 100).each do |stripe_sub|
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
            subscription.update(
                customer:        pay_customer,
                processor_plan:  stripe_sub.plan.id,
                status:          stripe_sub.status,
                quantity:        1,
                name:            "default"
            )

            puts (subscription.errors.none? ? "✅" : "❌")
            i += 1
        end
    end

end
