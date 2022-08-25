namespace :stripe_update_subscriptions do
    desc 'Update subscriptions'
    task :run => :environment do
        i = 0

        price_id = ENV["STRIPE_MEMBERSHIP_PRICE_ID"]
        old_price_id = ENV["STRIPE_OLD_MEMBERSHIP_PRICE_ID"]

        Stripe::Subscription.list(price: old_price_id).each do |stripe_sub|
            print "#{i += 1} - Updating #{stripe_sub.customer}... "
            old_sub_item = Stripe::SubscriptionItem.list(subscription: stripe_sub.id).first
            Stripe::Subscription.update(stripe_sub.id, {
                items: [{
                    id: old_sub_item.id,
                    deleted: true
                },{
                    price: price_id,
                    quantity: 1
                }],
                proration_behavior: "none"
            })

        end
    end
end