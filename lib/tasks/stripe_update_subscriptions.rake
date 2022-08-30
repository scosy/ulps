namespace :stripe_update_subscriptions do
    desc 'Update subscriptions'

    task 'early_members' => :environment do
        price_id = "price_1LcPosIuO31KnPvm7rZo2BbZ"
        
        User.where(role: 'early_member').each do |user|
            puts "Updating #{user.email}..."
            Stripe::Subscription.list(customer: user.payment_processor.processor_id, limit: 1).each do |stripe_sub|
                old_sub_item = Stripe::SubscriptionItem.list(subscription: stripe_sub.id).first
                Stripe::Subscription.update(stripe_sub.id, {
                    items: [{
                        id: old_sub_item.id,
                        deleted: true
                    }, {
                        price: price_id,
                        quantity: 1
                    }]
                })
            end
        end
    end

    task 'early_member' => :environment do
        price_id = "price_1LcPosIuO31KnPvm7rZo2BbZ"

        user = User.find_by(email: ARGV[1])
        puts "Updating #{user.email}..."
        Stripe::Subscription.list(customer: user.payment_processor.processor_id, limit: 1).each do |stripe_sub|
            old_sub_item = Stripe::SubscriptionItem.list(subscription: stripe_sub.id).first
            Stripe::Subscription.update(stripe_sub.id, {
                items: [{
                    id: old_sub_item.id,
                    deleted: true
                }, {
                    price: price_id,
                    quantity: 1
                }]
            })
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