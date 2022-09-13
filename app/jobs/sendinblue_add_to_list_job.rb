class SendinblueAddToListJob < ApplicationJob
  queue_as :default

  def perform(*args)

    user = User.find_by(email: args[0])
    list_id = args[1]

    api_instance = SibApiV3Sdk::ContactsApi.new
    
    create_contact = SibApiV3Sdk::CreateContact.new
    create_contact = {
      'email'=> user.email,
      'listIds'=> [list_id],
      'updateEnabled'=> true
    }
    begin
        api_instance.create_contact(create_contact)
        puts "User #{user.email} added to SendinBlue"
    rescue SibApiV3Sdk::ApiError => e
        puts "Exception when calling ContactsApi->create_contact: #{e}"
        puts e.response_body
    end


  end
end
