# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

#Customers 
customer1 = Customer.create!(
  first_name: 'Billy',
  last_name: 'Johnson',
  email: 'billy@example.com',
  address: '123 Maple Street, Billyland, UT'
)

customer2 = Customer.create!(
  first_name: 'Bob',
  last_name: 'Smith',
  email: 'bob@example.com',
  address: '456 Oak Avenue, Bobtopia, NY'
)

customer3 = Customer.create!(
  first_name: 'Charlie',
  last_name: 'Brown',
  email: 'charlie@example.com',
  address: '789 Pine Drive, Browns Town, OH'
)

customer4 = Customer.create!(
  first_name: 'Daniel',
  last_name: 'Davis',
  email: 'daniel@example.com',
  address: '101 Elm Street, Denver, CO'
)
#Teas 
tea1 = Tea.create!(
  title: 'Earl Grey',
  description: 'A fragrant black tea flavored with bergamot.',
  temperature: 200, 
  brew_time: 4     
)

tea2 = Tea.create!(
  title: 'Chamomile',
  description: 'A calming herbal tea made from chamomile flowers.',
  temperature: 190,
  brew_time: 5
)

tea3 = Tea.create!(
  title: 'Green Tea',
  description: 'A refreshing tea with mild flavors, rich in antioxidants.',
  temperature: 180,
  brew_time: 3
)

tea4 = Tea.create!(
  title: 'Jasmine Tea',
  description: 'A fragrant green tea infused with jasmine blossoms.',
  temperature: 180,
  brew_time: 3
)
#Subscriptions
subscription1 = Subscription.create!(
  customer: customer1,
  tea: tea1,
  title: 'Earl Grey Subscription',
  price: 10.99,
  status: 'active',
  frequency: 'monthly'
)

subscription2 = Subscription.create!(
  customer: customer1,
  tea: tea2,
  title: 'Chamomile Subscription',
  price: 12.50,
  status: 'cancelled',
  frequency: 'weekly'
)

subscription3 = Subscription.create!(
  customer: customer2,
  tea: tea3,
  title: 'Green Tea Subscription',
  price: 15.00,
  status: 'active',
  frequency: 'biweekly'
)

subscription4 = Subscription.create!(
  customer: customer2,
  tea: tea4,
  title: 'Jasmine Tea Subscription',
  price: 18.75,
  status: 'paused',
  frequency: 'monthly'
)

subscription5 = Subscription.create!(
  customer: customer3,
  tea: tea1,
  title: 'Earl Grey Subscription',
  price: 10.00,
  status: 'active',
  frequency: 'monthly'
)

subscription6 = Subscription.create!(
  customer: customer4,
  tea: tea3,
  title: 'Green Tea Subscription',
  price: 14.00,
  status: 'cancelled',
  frequency: 'weekly'
)
