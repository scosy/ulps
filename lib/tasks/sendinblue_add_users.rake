namespace :sendinblue_add_users do
    task not_early: :environment do
        api_instance = SibApiV3Sdk::ContactsApi.new
        prospects_list_id = 13
        
        # Get all users which role is nil
        User.where(role: nil).each do |user|
            create_contact = SibApiV3Sdk::CreateContact.new
            create_contact = {
                'email'=> user.email,
                'listIds'=> [prospects_list_id],
                'updateEnabled'=> true
            }
            begin
                api_instance.create_contact(create_contact)
                user.update(role: 'prospect')
                puts "User #{user.email} added to SendinBlue"
            rescue SibApiV3Sdk::ApiError => e
                puts "Exception when calling ContactsApi->create_contact: #{e}"
                puts e.response_body
            end
        end
    end
end
