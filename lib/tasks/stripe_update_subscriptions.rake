namespace :stripe_update_subscriptions do
    desc 'Update subscriptions'

    task 'early_members' => :environment do
        # Update subscriptions for early members
        User.where(role: 'early_member').each do |user|
            puts "Updating #{user.email}..."
            Stripe::Subscription.list(customer: user.processor_id, limit: 1).each do |stripe_sub|
                Stripe::Subscription.update(stripe_sub.id, {
                    items: [{
                        id: stripe_sub.items.first.id,
                        deleted: true
                    }, {
                        price: price_id,
                        quantity: 1
                    }]
                })
            end
        end
    end

    task :run => :environment do
        i = 0

        price_id = "price_1Laaq2IuO31KnPvm2DSBhTqB"
        
        old_price_ids = [
            "price_1LIUE2IuO31KnPvmP765pu7V", # 3.95/week + 21 days free trial
            "price_1LD0zAIuO31KnPvm5DG31eEQ", # 15./month + 21 days free trial
            "price_1LCzaQIuO31KnPvmzRQEmG2d", # 3.75/week + 21 days free trial
            "price_1LCdv3IuO31KnPvmTwy1EtiE" # 15.0/month + 21 days free trial
        ]

        old_price_ids.each do |old_price_id|
            puts "💎 Updating #{old_price_id} to #{price_id}..."
            Stripe::Subscription.list(price: old_price_id, limit: 100).each do |stripe_sub|
                puts "#{i += 1} - Updating #{stripe_sub.customer}... "
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
end