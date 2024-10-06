require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "relationships" do
    it { should belong_to(:customer) }
    it { should belong_to(:tea) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_numericality_of(:price) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:frequency) }
  end

  describe "model methods" do
    describe "instance methods" do
      describe ".change_status" do
        it "will change the status to 'cancelled' or 'active' depending on the exisiting status" do
          customer1 = Customer.create!(first_name: 'Billy', last_name: 'Johnson', email: 'billy@example.com', address: '123 Maple Street, Billyland, UT')
          customer2 = Customer.create!(first_name: 'Bob', last_name: 'Smith', email: 'bob@example.com', address: '456 Oak Avenue, Bobtopia, NY')
          tea = Tea.create!(title: 'Earl Grey', description: 'A fragrant black tea flavored with bergamot.', temperature: 200, brew_time: 4)
          subscription1 = Subscription.create!(customer: customer1, tea: tea, title: 'Earl Grey Subscription', price: 10.00, status: 'active', frequency: 'monthly')
          subscription2 = Subscription.create!(customer: customer2, tea: tea, title: 'Green Tea Subscription', price: 14.00, status: 'cancelled', frequency: 'weekly')

          expect(subscription1.status).to eq('active')
          subscription1.cancel
          expect(subscription1.status).to eq('cancelled')
        end
      end
    end
  end
end