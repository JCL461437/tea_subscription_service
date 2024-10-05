class Api::V1::SubscriptionsController < ApplicationController

  def create
    customer = Customer.find(params[:customer_id])
    tea = Tea.find(params[:tea_id])

    subscription = Subscription.create(customer, tea)

    if subscription.save
      render json: SubscriptionSerializer.new.new_subscription(customer, tea, subscription), status: 200
    else 
      render json: {error: 'Subscription attempt failed, try re-entering your customer email and tea name'}, status: 422
    end
  end
end