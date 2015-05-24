# Sudo-method for sending messages
def send_message(customer, sender, message_body)
  customer.chat.messages.create!(body: message_body, sender: sender)
end

org = Organisation.create!(name: 'The Company', area_code: '0113',
                           staff_limit: 50)
user = org.users.create!(email: 'owner@gmail.com', password: 'password',
                         password_confirmation: 'password', first_name: 'John',
                         last_name: 'Smith')

# Set first user as owner of Organisation
org.update_attributes(owner_id: user.id)

customer = org.customers.create!(phone_number: '+447412846843')
customer.build_chat.save

send_message(customer, customer, 'Hey! Can I get some pizzas to 123 Stree Lane?')
send_message(customer, user, 'Sure, what do you want?')
send_message(customer, customer, '2x margarita and 2x fries')
send_message(customer, user, 'That will be £12.99')
