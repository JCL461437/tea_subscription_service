require 'rails_helper'

RSpec.describe "POST /api/v1/subscribe", type: :request do
  describe 'happy path' do
    it 'creates a subscription and returns the subscription information' do
      customer = Customer.create!(email: "daniel@example.com", first_name: "Daniel", last_name: "Davis", address: "101 Elm Street, Denver, CO")
      tea = Tea.create!(title: "Chamomile", description: "A calming herbal tea made from chamomile flowers.", temperature: 190.0, brew_time: 5.0)
      subscription_params = {
        customer: customer.email,
        tea: tea.title,
        frequency: "Monthly"
      }

      post "/api/v1/subscribe", params: subscription_params

      expect(response).to have_http_status(:success)

      payload = JSON.parse(response.body, symbolize_names: true)

      expect(payload).to have_key(:data)
      expect(payload[:data]).to have_key(:id)
      expect(payload[:data][:id]).to be_a(String)
      expect(payload[:data]).to have_key(:type)
      expect(payload[:data][:type]).to eq("subscription")
      expect(payload[:data]).to have_key(:attributes)

      expect(payload[:data][:attributes]).to have_key(:title)
      expect(payload[:data][:attributes][:title]).to eq("Subscription for Chamomile tea.")
      expect(payload[:data][:attributes]).to have_key(:price)
      expect(payload[:data][:attributes][:price]).to eq("2.0")
      expect(payload[:data][:attributes]).to have_key(:status)
      expect(payload[:data][:attributes][:status]).to eq("active")
      expect(payload[:data][:attributes]).to have_key(:frequency)
      expect(payload[:data][:attributes][:frequency]).to eq("Monthly")

      expect(payload[:data][:attributes]).to have_key(:tea_information)
      expect(payload[:data][:attributes][:tea_information]).to have_key(:name)
      expect(payload[:data][:attributes][:tea_information][:name]).to eq("Chamomile")
      expect(payload[:data][:attributes][:tea_information]).to have_key(:description)
      expect(payload[:data][:attributes][:tea_information][:description]).to eq("A calming herbal tea made from chamomile flowers.")
      expect(payload[:data][:attributes][:tea_information]).to have_key(:temperature)
      expect(payload[:data][:attributes][:tea_information][:temperature]).to eq(190.0)
      expect(payload[:data][:attributes][:tea_information]).to have_key(:brew_time)
      expect(payload[:data][:attributes][:tea_information][:brew_time]).to eq(5.0)

      expect(payload[:data][:attributes]).to have_key(:customer_information)
      expect(payload[:data][:attributes][:customer_information]).to have_key(:first_name)
      expect(payload[:data][:attributes][:customer_information][:first_name]).to eq("Daniel")
      expect(payload[:data][:attributes][:customer_information]).to have_key(:last_name)
      expect(payload[:data][:attributes][:customer_information][:last_name]).to eq("Davis")
      expect(payload[:data][:attributes][:customer_information]).to have_key(:email)
      expect(payload[:data][:attributes][:customer_information][:email]).to eq("daniel@example.com")
      expect(payload[:data][:attributes][:customer_information]).to have_key(:address)
      expect(payload[:data][:attributes][:customer_information][:address]).to eq("101 Elm Street, Denver, CO")
    end
  end
  
  describe 'sad path' do
    it 'cannot create a subscription if customer or tea not found' do

      subscription_params = {
        customer: "nonexistent@example.com", 
        tea: "Nonexistent Tea", 
        frequency: "weekly"
      }

      post "/api/v1/subscribe", params: subscription_params

      expect(response).to have_http_status(:not_found)

      payload = JSON.parse(response.body, symbolize_names: true)

      expect(payload).to have_key(:error)
      expect(payload[:error]).to eq("Subscription attempt failed, try re-entering your customer email and tea name")
    end

    it 'cannot create a subscription with missing parameters' do
      subscription_params = {
        customer: "", 
        tea: "", 
        frequency: ""
      }

      post "/api/v1/subscribe", params: subscription_params

      expect(response).to have_http_status(:not_found)

      payload = JSON.parse(response.body, symbolize_names: true)

      expect(payload).to have_key(:error)
      expect(payload[:error]).to eq('Subscription attempt failed, try re-entering your customer email and tea name')
    end
  end
end
